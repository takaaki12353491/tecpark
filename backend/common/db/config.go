package db

import (
	"fmt"
	"net/url"
)

type Config struct {
	User     string
	Password string
	Host     string
	Port     string
	Database string
	TZ       string
}

func (c *Config) MySQLDSN() string {
	tzEncoded := url.QueryEscape(c.TZ)
	return fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=%s",
		c.User, c.Password, c.Host, c.Port, c.Database, tzEncoded)
}

func (c *Config) PostgresDSN() string {
	tzEncoded := url.QueryEscape(c.TZ)
	return fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable TimeZone=%s",
		c.Host, c.User, c.Password, c.Database, c.Port, tzEncoded)
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
