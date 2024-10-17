package service

import (
	"common/db"
	"common/domain/model"
	xlog "common/log"
	"log"
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

	err := testConn.AutoMigrate(&model.User{})
	if err != nil {
		log.Fatalf("failed to auto-migrate: %v", err)
	}

	code := m.Run()

	tables, _ := testConn.Migrator().GetTables()
	for _, table := range tables {
		err := testConn.Migrator().DropTable(table)
		if err != nil {
			log.Fatalf("failed to drop table %s: %v", table, err)
		}
	}

	os.Exit(code)
}
