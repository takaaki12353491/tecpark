//go:build wireinject

package di

import (
	"user/internal/infra/db"
	"user/internal/interface/graphql/resolver"
	"user/internal/service"

	"github.com/google/wire"
	"gorm.io/gorm"
)

func InitializeResolver(conn *gorm.DB) *resolver.Resolver {
	wire.Build(
		service.WireSet,
		db.WireSet,
		resolver.NewResolver,
	)
	return &resolver.Resolver{}
}
