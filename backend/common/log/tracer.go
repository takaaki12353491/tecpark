package xslog

import (
	"log/slog"
	"os"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/stdout/stdouttrace"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/sdk/resource"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.4.0"
)

func Init() {
	log := slog.New(New(slog.NewJSONHandler(os.Stdout, &slog.HandlerOptions{})))
	slog.SetDefault(log)
	slog.SetLogLoggerLevel(slog.LevelInfo)
}

func InitTracer() (*sdktrace.TracerProvider, error) {
	// 標準出力用のエクスポーターを作成
	exp, err := stdouttrace.New(stdouttrace.WithPrettyPrint())
	if err != nil {
		return nil, err
	}

	// トレースプロバイダーを設定
	tp := sdktrace.NewTracerProvider(
		sdktrace.WithSampler(sdktrace.AlwaysSample()), // 全リクエストをサンプリング
		sdktrace.WithBatcher(exp),
		sdktrace.WithResource(resource.NewWithAttributes(
			semconv.SchemaURL,
			semconv.ServiceNameKey.String("tecpark-user"),
		)),
	)

	// OpenTelemetryのグローバルトレーサーを設定
	otel.SetTracerProvider(tp)
	// ここを設定しないとトレース伝搬されない
	otel.SetTextMapPropagator(propagation.TraceContext{})
	return tp, nil
}
