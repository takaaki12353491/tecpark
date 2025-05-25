package main

import (
	dbmodel "github.com/takaaki12353491/tecpark/backend/db/rdb/model"
	"gorm.io/gen"
)

type Querier interface {
	// SELECT * FROM @@table WHERE id=@id
	GetByID(id string) (gen.T, error)
}

func main() {
	g := gen.NewGenerator(gen.Config{
		OutPath: "../../query",
		Mode:    gen.WithDefaultQuery,
	})

	g.ApplyBasic(dbmodel.User{})

	g.ApplyInterface(func(Querier) {}, dbmodel.User{})

	g.Execute()
}
