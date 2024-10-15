package service

import (
	"common/db"
	"common/db/query"
	"common/domain/model"
	xlog "common/log"
	"os"
	"testing"

	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var testQuery *query.Query

func TestMain(m *testing.M) {
	testDB, _ := db.NewDB(db.WithPort("33306"))
	testDB = testDB.Session(&gorm.Session{
		Logger: xlog.NewLogger(xlog.WithLogLevel(logger.Error)),
	})
	testQuery = query.Use(testDB)

	testDB.AutoMigrate(&model.User{})

	code := m.Run()

	tables, _ := testDB.Migrator().GetTables()
	for _, table := range tables {
		testDB.Migrator().DropTable(table)
	}

	os.Exit(code)
}
