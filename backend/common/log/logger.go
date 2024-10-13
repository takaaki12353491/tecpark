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

func NewLogger() logger.Interface {
	return &Logger{
		Config: logger.Config{
			SlowThreshold:             200 * time.Millisecond,
			LogLevel:                  logger.Info,
			IgnoreRecordNotFoundError: true,
			Colorful:                  false,
		},
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
		slog.ErrorContext(ctx, "sql is error",
			slog.String("latency", fmt.Sprintf("%.3fms", latency)),
			slog.Int64("rows", rows),
			slog.String("sql", sql),
			slog.String("error", err.Error()),
		)
	case elapsed > l.SlowThreshold && l.SlowThreshold != 0 && l.LogLevel >= logger.Warn:
		slog.WarnContext(ctx, "sql is slow",
			slog.String("latency", fmt.Sprintf("%.3fms", latency)),
			slog.Int64("rows", rows),
			slog.String("sql", sql),
		)
	case l.LogLevel == logger.Info:
		slog.InfoContext(ctx, "sql is success",
			slog.String("latency", fmt.Sprintf("%.3fms", latency)),
			slog.Int64("rows", rows),
			slog.String("sql", sql),
		)
	}
}
