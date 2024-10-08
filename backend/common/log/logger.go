package log

import (
	"context"
	"fmt"
	"log/slog"
	"time"

	"gorm.io/gorm/logger"
)

var _ logger.Interface = (*Logger)(nil)

type Logger struct {
	logger.Writer
	logger.Config
	infoStr, warnStr, errStr            string
	traceStr, traceErrStr, traceWarnStr string
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
	switch {
	case err != nil && l.LogLevel >= logger.Error:
		if rows == -1 {
			slog.ErrorContext(ctx, fmt.Sprintf("[%.3fms] [rows:%s] %s", float64(elapsed.Nanoseconds())/1e6, "-", sql), slog.String("error", err.Error()))
		} else {
			slog.ErrorContext(ctx, fmt.Sprintf("[%.3fms] [rows:%d] %s", float64(elapsed.Nanoseconds())/1e6, rows, sql), slog.String("error", err.Error()))
		}
	case elapsed > l.SlowThreshold && l.SlowThreshold != 0 && l.LogLevel >= logger.Warn:
		if rows == -1 {
			slog.WarnContext(ctx, fmt.Sprintf("[%.3fms] [rows:%s] %s", float64(elapsed.Nanoseconds())/1e6, "-", sql))
		} else {
			slog.WarnContext(ctx, fmt.Sprintf("[%.3fms] [rows:%d] %s", float64(elapsed.Nanoseconds())/1e6, rows, sql))
		}
	case l.LogLevel == logger.Info:
		if rows == -1 {
			slog.InfoContext(ctx, fmt.Sprintf("[%.3fms] [rows:%s] %s", float64(elapsed.Nanoseconds())/1e6, "-", sql))
		} else {
			slog.InfoContext(ctx, fmt.Sprintf("[%.3fms] [rows:%d] %s", float64(elapsed.Nanoseconds())/1e6, rows, sql))
		}
	}
}
