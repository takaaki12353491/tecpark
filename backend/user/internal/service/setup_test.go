package service

import (
	"common/db"
	"common/domain/model"
	"log"
	"os"
	"testing"

	"gorm.io/gorm"
)

var testTX *gorm.DB

func TestMain(m *testing.M) {
	testDB, _ := db.NewDB(db.WithPort("33306"))

	testTX = testDB.Begin()
	if err := testTX.Error; err != nil {
		log.Fatalf("failed to begin transaction: %v", err)
	}

	if err := testTX.AutoMigrate(&model.User{}); err != nil {
		log.Fatalf("failed to migrate database: %v", err)
	}

	code := m.Run()

	if err := testTX.Rollback().Error; err != nil {
		log.Fatalf("failed to rollback transaction: %v", err)
	}

	os.Exit(code)
}
