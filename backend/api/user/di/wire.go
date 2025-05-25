//go:build wireinject

package di

import (
	"user/internal/adapter/graphql/resolver"
	"user/internal/infra/db"
	"user/internal/usecase/interactor"

	"github.com/google/wire"
	"gorm.io/gorm"
)

func InitializeResolver(conn *gorm.DB) *resolver.Resolver {
	wire.Build(
		resolver.NewResolver,
		interactor.NewUser,
		db.NewTransaction,
		db.NewUser,
	)
	return &resolver.Resolver{}
}
