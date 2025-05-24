package db

import (
	"fmt"
	"net/url"

	"github.com/takaaki12353491/tecpark/backend/common/env"
	xlog "github.com/takaaki12353491/tecpark/backend/common/log"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/plugin/opentelemetry/tracing"
)

type Config struct {
	User     string
	Password string
	Host     string
	Port     string
	Database string
	TZ       string
}

func (c *Config) DSN() string {
	tzEncoded := url.QueryEscape(c.TZ)
	return fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=%s",
		c.User, c.Password, c.Host, c.Port, c.Database, tzEncoded)
}

type Option func(*Config)

func WithPort(port string) Option {
	return func(c *Config) {
		c.Port = port
	}
}

func WithTZ(tz string) Option {
	return func(c *Config) {
		c.TZ = tz
	}
}

func New(options ...Option) *gorm.DB {
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
	dsn := config.DSN()

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

	return db
}
