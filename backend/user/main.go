package main

import (
	"log"
	"user/internal/interface/graphql"
	"user/internal/interface/graphql/resolver"

	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/labstack/echo/v4"
)

func main() {
	srv := handler.NewDefaultServer(graphql.NewExecutableSchema(graphql.Config{Resolvers: &resolver.Resolver{}}))

	e := echo.New()
	e.POST("/query", echo.WrapHandler(srv))
	e.GET("/playground", echo.WrapHandler(playground.Handler("GraphQL playground", "/query")))

	port := "80"
	log.Printf("connect to http://localhost:%s/playground for GraphQL playground", port)
	e.Logger.Fatal(e.Start(":" + port))
}
