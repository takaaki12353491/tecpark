package db

import (
	"fmt"

	"github.com/takaaki12353491/tecpark/backend/common/env"
	xlog "github.com/takaaki12353491/tecpark/backend/common/log"
	"github.com/takaaki12353491/tecpark/backend/db/rdb/query"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/plugin/opentelemetry/tracing"
)

func NewMySQL(options ...Option) *gorm.DB {
	config := &Config{
		User:     env.Get("MYSQL_USER", "tecpark"),
		Password: env.Get("MYSQL_PASSWORD", "tecpark"),
		Host:     env.Get("MYSQL_HOST", "localhost"),
		Port:     env.Get("MYSQL_PORT", "3306"),
		Database: env.Get("MYSQL_DATABASE", "tecpark"),
		TZ:       env.Get("TZ", "Asia/Tokyo"),
	}
	for _, opt := range options {
		opt(config)
	}
	dsn := config.MySQLDSN()

	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{
		Logger: xlog.NewLogger(),
	})
	if err != nil {
		panic(fmt.Sprintf("failed to connect to database: %v", err))
	}

	err = db.Use(tracing.NewPlugin())
	if err != nil {
		panic(fmt.Sprintf("failed to setup tracing plugin: %v", err))
	}

	query.SetDefault(db)

	return db
}
