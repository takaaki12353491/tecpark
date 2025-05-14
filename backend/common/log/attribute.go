package xlog

import "log/slog"

type Key string

const (
	KeyError      = Key("error")
	KeyStackTrace = Key("stackTrace")
)

func (k Key) Attr(value any) slog.Attr {
	return slog.Any(string(k), value)
}
