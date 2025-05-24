//nolint:exhaustruct
package server

import (
	"bytes"
	"fmt"
	"net/http"
	"user/di"
	"user/internal/adapter/graphql"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"github.com/takaaki12353491/tecpark/backend/common/db"
	_ "github.com/takaaki12353491/tecpark/backend/common/log"

	"go.opentelemetry.io/contrib/instrumentation/github.com/labstack/echo/otelecho"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	"go.opentelemetry.io/otel/trace"
)

func Run() {
	tp := sdktrace.NewTracerProvider()

	e := echo.New()

	e.Use(middleware.Recover())
	e.Use(otelecho.Middleware("tecpark-user", otelecho.WithTracerProvider(tp))) // 先に設定しないとtraceIDなどがcontextに設定されない
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
			fmt.Fprintf(buf, "\"%s\":\"%s\"", "traceID", span.SpanContext().TraceID().String())
			fmt.Fprintf(buf, ",\"%s\":\"%s\"", "spanID", span.SpanContext().SpanID().String())

			return 0, nil
		},
	}))

	db := db.New()
	resolver := di.InitializeResolver(db)
	srv := handler.New(graphql.NewExecutableSchema(graphql.Config{Resolvers: resolver}))

	e.POST("/query", echo.WrapHandler(srv))
	e.GET("/playground", echo.WrapHandler(playground.Handler("GraphQL playground", "/query")))
	e.GET("/health", func(c echo.Context) error {
		return c.String(http.StatusOK, "OK")
	})

	port := "80"
	e.Logger.Fatal(e.Start(":" + port))
}
