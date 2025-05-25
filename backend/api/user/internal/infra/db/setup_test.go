package db_test

import (
	"log"
	"os"
	"testing"

	"github.com/takaaki12353491/tecpark/backend/common/db"
	xlog "github.com/takaaki12353491/tecpark/backend/common/log"
	dbmodel "github.com/takaaki12353491/tecpark/backend/db/rdb/model"

	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func TestMain(m *testing.M) {
	var testConn *gorm.DB

	conn := db.NewMySQL(db.WithPort("33306"))
	testConn = conn.Session(&gorm.Session{
		Logger: xlog.NewLogger(xlog.WithLogLevel(logger.Error)),
	})

	err := testConn.AutoMigrate(&dbmodel.User{})
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
