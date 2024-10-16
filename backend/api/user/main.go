package main

import (
	"bytes"
	"common/db"
	xlog "common/log"
	"common/util"
	"fmt"
	"time"
	"user/internal/infra/di"
	"user/internal/interface/graphql"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"

	//nolint:staticcheck
	"go.opentelemetry.io/contrib/instrumentation/github.com/labstack/echo/otelecho"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	"go.opentelemetry.io/otel/trace"
)

func main() {
	tz := util.GetEnv("TZ", "Asia/Tokyo")
	location, err := time.LoadLocation(tz)
	if err != nil {
		panic(fmt.Sprintf("failed to load time location: %v", err))
	}
	time.Local = location

	xlog.Init()

	e := echo.New()

	e.Use(middleware.Recover())
	tp := sdktrace.NewTracerProvider()
	e.Use(otelecho.Middleware("tecpark-user", otelecho.WithTracerProvider(tp))) //先に設定しないとtraceIDなどがcontextに設定されない
	e.Use(middleware.LoggerWithConfig(middleware.LoggerConfig{
		Skipper: func(c echo.Context) bool {
			return c.Path() == "/metrics" || c.Path() == "/health"
		},
		Format: `{"time":"${time_rfc3339_nano}",${custom},"remote_ip":"${remote_ip}",` +
			`"host":"${host}","method":"${method}","uri":"${uri}","status":${status},` +
			`"error":"${error}","latency":${latency},"latency_human":"${latency_human}",` +
			`"bytes_in":${bytes_in},"bytes_out":${bytes_out}}` + "\n",
		CustomTagFunc: func(c echo.Context, buf *bytes.Buffer) (int, error) {
			span := trace.SpanFromContext(c.Request().Context())
			buf.WriteString(fmt.Sprintf("\"%s\":\"%s\"", "traceID", span.SpanContext().TraceID().String()))
			buf.WriteString(fmt.Sprintf(",\"%s\":\"%s\"", "spanID", span.SpanContext().SpanID().String()))
			return 0, nil
		},
	}))

	conn, _ := db.NewConnection(db.WithTZ(tz))
	resolver := di.InitializeResolver(conn)
	srv := handler.NewDefaultServer(graphql.NewExecutableSchema(graphql.Config{Resolvers: resolver}))

	e.POST("/query", echo.WrapHandler(srv))
	e.GET("/playground", echo.WrapHandler(playground.Handler("GraphQL playground", "/query")))
	e.GET("/health", func(c echo.Context) error {
		return c.String(200, "OK")
	})

	port := "80"
	e.Logger.Fatal(e.Start(":" + port))
}
