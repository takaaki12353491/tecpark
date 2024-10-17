// Code generated by Wire. DO NOT EDIT.

//go:generate go run -mod=mod github.com/google/wire/cmd/wire
//go:build !wireinject
// +build !wireinject

package di

import (
	"gorm.io/gorm"
	"user/internal/infra/db"
	"user/internal/interface/graphql/resolver"
	"user/internal/service"
)

// Injectors from wire.go:

func InitializeResolver(conn *gorm.DB) *resolver.Resolver {
	userRepository := db.NewUserRepository(conn)
	userService := service.NewUserService(userRepository)
	resolverResolver := resolver.NewResolver(userService)
	return resolverResolver
}