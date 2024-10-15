package service

import (
	"common/db"
	"common/domain/model"
	"os"
	"testing"

	"gorm.io/gorm"
)

var testDB *gorm.DB

func TestMain(m *testing.M) {
	testDB, _ = db.NewDB(db.WithPort("33306"))

	testDB.AutoMigrate(&model.User{})

	code := m.Run()

	tables, _ := testDB.Migrator().GetTables()
	for _, table := range tables {
		testDB.Migrator().DropTable(table)
	}

	os.Exit(code)
}
