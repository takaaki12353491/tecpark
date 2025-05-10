package db

import (
	"fmt"
	"net/url"

	xlog "github.com/takaaki12353491/tecpark/backend/common/log"
	"github.com/takaaki12353491/tecpark/backend/common/util"

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

func (c *Config) getDSN() string {
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

func NewConnection(options ...Option) (*gorm.DB, error) {
	config := &Config{
		User:     util.GetEnv("MYSQL_USER", "tecpark"),
		Password: util.GetEnv("MYSQL_PASSWORD", "tecpark"),
		Host:     util.GetEnv("MYSQL_HOST", "localhost"),
		Port:     util.GetEnv("MYSQL_PORT", "3306"),
		Database: util.GetEnv("MYSQL_DATABASE", "tecpark"),
		TZ:       util.GetEnv("TZ", "Asia/Tokyo"),
	}
	for _, opt := range options {
		opt(config)
	}
	dsn := config.getDSN()

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

	return db, nil
}
