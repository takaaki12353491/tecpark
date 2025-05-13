package xlog

import "log/slog"

type Key string

const (
	KeyError = Key("error")
)

func (k Key) Attr(value any) slog.Attr {
	return slog.Any(string(k), value)
}
