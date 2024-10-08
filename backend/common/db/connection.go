package db

import (
	"common/log"
	"common/util"
	"fmt"
	"net/url"
	"os"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
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

func WithTZ(tz string) Option {
	return func(c *Config) {
		c.TZ = tz
	}
}

func NewDB(options ...Option) (*gorm.DB, error) {
	config := &Config{
		User:     os.Getenv("MYSQL_USER"),
		Password: os.Getenv("MYSQL_PASSWORD"),
		Host:     os.Getenv("MYSQL_HOST"),
		Port:     os.Getenv("MYSQL_PORT"),
		Database: os.Getenv("MYSQL_DATABASE"),
		TZ:       util.GetEnv("TZ", "Asia/Tokyo"),
	}
	for _, opt := range options {
		opt(config)
	}
	dsn := config.getDSN()

	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{
		Logger: log.NewLogger(),
	})
	if err != nil {
		panic(fmt.Sprintf("failed to connect to database: %v", err))
	}

	return db, nil
}
