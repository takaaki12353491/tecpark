package main

import (
	"common/domain/model"

	"gorm.io/gen"
)

type Querier interface {
	// SELECT * FROM @@table WHERE id=@id
	GetByID(id model.ULID) (gen.T, error)
}

func main() {
	g := gen.NewGenerator(gen.Config{
		OutPath: "../query",
		Mode:    gen.WithoutContext | gen.WithDefaultQuery | gen.WithQueryInterface, // generate mode
	})

	g.ApplyBasic(model.User{})

	g.ApplyInterface(func(Querier) {}, model.User{})

	g.Execute()
}
