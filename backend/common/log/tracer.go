package xlog

import (
	"log/slog"
	"os"
)

func Init() {
	log := slog.New(New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{})))
	slog.SetDefault(log)
	slog.SetLogLoggerLevel(slog.LevelInfo)
}
