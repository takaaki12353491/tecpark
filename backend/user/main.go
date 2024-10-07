package main

import (
	"common/db"
	"common/db/query"
	"common/util"
	"fmt"
	"log"
	"time"
	"user/internal/infra/di"
	"user/internal/interface/graphql"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/labstack/echo/v4"
)

func main() {
	tz := util.GetEnv("TZ", "Asia/Tokyo")
	location, err := time.LoadLocation(tz)
	if err != nil {
		panic(fmt.Sprintf("failed to load time location: %v", err))
	}
	time.Local = location

	db, _ := db.NewDB(db.WithTZ(tz))
	query := query.Use(db)
	resolver := di.InitializeResolver(query)
	srv := handler.NewDefaultServer(graphql.NewExecutableSchema(graphql.Config{Resolvers: resolver}))

	e := echo.New()
	e.POST("/query", echo.WrapHandler(srv))
	e.GET("/playground", echo.WrapHandler(playground.Handler("GraphQL playground", "/query")))

	port := "80"
	log.Printf("connect to http://localhost:%s/playground for GraphQL playground", port)
	e.Logger.Fatal(e.Start(":" + port))
}
