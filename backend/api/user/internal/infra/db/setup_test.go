package db_test

import (
	"log"
	"os"
	"testing"
	"user/internal/domain/model"

	"github.com/takaaki12353491/tecpark/backend/common/db"
	xlog "github.com/takaaki12353491/tecpark/backend/common/log"

	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func TestMain(m *testing.M) {
	var testConn *gorm.DB

	conn, _ := db.New(db.WithPort("33306"))
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
