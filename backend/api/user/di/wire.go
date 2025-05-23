//go:build wireinject

package di

import (
	"user/internal/infra/db"
	"user/internal/interface/graphql/resolver"
	"user/internal/usecase/interactor"

	"github.com/google/wire"
	"gorm.io/gorm"
)

func InitializeResolver(conn *gorm.DB) *resolver.Resolver {
	wire.Build(
		resolver.NewResolver,
		interactor.NewUser,
		db.NewUser,
	)
	return &resolver.Resolver{}
}
