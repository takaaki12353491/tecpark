package service

import (
	"common/db"
	"common/domain/model"
	xlog "common/log"
	"os"
	"testing"

	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

var testConn *gorm.DB

func TestMain(m *testing.M) {
	conn, _ := db.NewConnection(db.WithPort("33306"))
	testConn = conn.Session(&gorm.Session{
		Logger: xlog.NewLogger(xlog.WithLogLevel(logger.Error)),
	})

	testConn.AutoMigrate(&model.User{})

	code := m.Run()

	tables, _ := testConn.Migrator().GetTables()
	for _, table := range tables {
		testConn.Migrator().DropTable(table)
	}

	os.Exit(code)
}
