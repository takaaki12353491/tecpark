package xlog

import (
	"log/slog"
	"os"
)

func init() {
	log := slog.New(&Handler{
		Handler: slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{}),
	})
	slog.SetDefault(log)
	slog.SetLogLoggerLevel(slog.LevelInfo)
}
