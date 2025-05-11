package main

import (
	"user/internal/domain/model"

	"github.com/oklog/ulid/v2"
	"gorm.io/gen"
)

type Querier interface {
	// SELECT * FROM @@table WHERE id=@id
	GetByID(id ulid.ULID) (gen.T, error)
}

func main() {
	g := gen.NewGenerator(gen.Config{
		OutPath: "../../internal/infra/db/query",
		Mode:    gen.WithDefaultQuery,
	})

	g.ApplyBasic(model.User{})

	g.ApplyInterface(func(Querier) {}, model.User{})

	g.Execute()
}
