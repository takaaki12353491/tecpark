package db

import (
	"fmt"

	"github.com/takaaki12353491/tecpark/backend/common/env"
	xlog "github.com/takaaki12353491/tecpark/backend/common/log"
	"github.com/takaaki12353491/tecpark/backend/db/rdb/query"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/plugin/opentelemetry/tracing"
)

func NewPostgres(options ...Option) *gorm.DB {
	config := &Config{
		User:     env.Get("POSTGRES_USER", "tecpark"),
		Password: env.Get("POSTGRES_PASSWORD", "tecpark"),
		Host:     env.Get("POSTGRES_HOST", "localhost"),
		Port:     env.Get("POSTGRES_PORT", "5432"),
		Database: env.Get("POSTGRES_DB", "tecpark"),
		TZ:       env.Get("TZ", "Asia/Tokyo"),
	}
	for _, opt := range options {
		opt(config)
	}

	db, err := gorm.Open(postgres.Open(config.PostgresDSN()), &gorm.Config{
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
