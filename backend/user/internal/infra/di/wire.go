//go:build wireinject

package di

import (
	"common/db/query"
	"user/internal/infra/db"
	"user/internal/interface/graphql/resolver"
	"user/internal/service"

	"github.com/google/wire"
)

func InitializeResolver(query *query.Query) *resolver.Resolver {
	wire.Build(
		service.WireSet,
		db.WireSet,
		resolver.NewResolver,
	)
	return &resolver.Resolver{}
}
