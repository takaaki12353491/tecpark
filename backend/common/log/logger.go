package xlog

import (
	"context"
	"fmt"
	"log/slog"
	"time"

	"gorm.io/gorm/logger"
)

type Logger struct {
	logger.Writer
	logger.Config
}

type Option func(*logger.Config)

func WithLogLevel(level logger.LogLevel) Option {
	return func(config *logger.Config) {
		config.LogLevel = level
	}
}

func NewLogger(options ...Option) logger.Interface {
	config := logger.Config{
		SlowThreshold:             200 * time.Millisecond,
		LogLevel:                  logger.Info,
		IgnoreRecordNotFoundError: true,
		Colorful:                  false,
	}

	for _, option := range options {
		option(&config)
	}

	return &Logger{
		Config: config,
	}
}

func (l *Logger) LogMode(level logger.LogLevel) logger.Interface {
	newlogger := *l
	newlogger.LogLevel = level
	return &newlogger
}

func (l *Logger) Info(ctx context.Context, msg string, data ...interface{}) {
	if l.LogLevel >= logger.Info {
		slog.InfoContext(ctx, fmt.Sprintf(msg, data...))
	}
}

func (l *Logger) Warn(ctx context.Context, msg string, data ...interface{}) {
	if l.LogLevel >= logger.Warn {
		slog.WarnContext(ctx, fmt.Sprintf(msg, data...))
	}
}

func (l *Logger) Error(ctx context.Context, msg string, data ...interface{}) {
	if l.LogLevel >= logger.Error {
		slog.ErrorContext(ctx, fmt.Sprintf(msg, data...))
	}
}

func (l *Logger) Trace(ctx context.Context, begin time.Time, fc func() (sql string, rowsAffected int64), err error) {
	if l.LogLevel <= logger.Silent {
		return
	}

	elapsed := time.Since(begin)
	sql, rows := fc()
	latency := float64(elapsed.Nanoseconds()) / 1e6

	switch {
	case err != nil && l.LogLevel >= logger.Error:
		slog.ErrorContext(ctx, "query failed",
			slog.String("latency", fmt.Sprintf("%.3fms", latency)),
			slog.Int64("rows", rows),
			slog.String("sql", sql),
			slog.String("error", err.Error()),
		)
	case elapsed > l.SlowThreshold && l.SlowThreshold != 0 && l.LogLevel >= logger.Warn:
		slog.WarnContext(ctx, "query was slow",
			slog.String("latency", fmt.Sprintf("%.3fms", latency)),
			slog.Int64("rows", rows),
			slog.String("sql", sql),
		)
	case l.LogLevel == logger.Info:
		slog.InfoContext(ctx, "query was successful",
			slog.String("latency", fmt.Sprintf("%.3fms", latency)),
			slog.Int64("rows", rows),
			slog.String("sql", sql),
		)
	}
}
