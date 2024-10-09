package xslog

import (
	xcontext "common/context"
	"context"
	"log/slog"

	"go.opentelemetry.io/otel/trace"
)

var keys = []xcontext.Key{
	xcontext.UserIDKey,
}

type Handler struct {
	slog.Handler
}

func New(
	handler slog.Handler,
) *Handler {
	return &Handler{
		Handler: handler,
	}
}

func (h *Handler) Handle(
	ctx context.Context,
	record slog.Record,
) error {
	span := trace.SpanFromContext(ctx)
	record.AddAttrs(slog.Attr{Key: "trace", Value: slog.StringValue(span.SpanContext().TraceID().String())})
	record.AddAttrs(slog.Attr{Key: "span", Value: slog.StringValue(span.SpanContext().SpanID().String())})
	for _, key := range keys {
		if val := ctx.Value(key); val != nil {
			record.AddAttrs(slog.Attr{Key: string(key), Value: slog.AnyValue(val)})
		}
	}
	return h.Handler.Handle(ctx, record)
}
