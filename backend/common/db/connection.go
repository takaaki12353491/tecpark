package db

import (
	"common/util"
	"fmt"
	"net/url"
	"os"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func NewDB() (*gorm.DB, error) {
	user := os.Getenv("MYSQL_USER")
	password := os.Getenv("MYSQL_PASSWORD")
	host := os.Getenv("MYSQL_HOST")
	port := os.Getenv("MYSQL_PORT")
	database := os.Getenv("MYSQL_DATABASE")
	tz := util.GetEnv("TZ", "Asia/Tokyo")
	tzEncoded := url.QueryEscape(tz)
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=%s", user, password, host, port, database, tzEncoded)

	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{
		Logger: logger.Default.LogMode(logger.Info),
	})
	if err != nil {
		panic(fmt.Sprintf("failed to connect to database: %v", err))
	}

	return db, nil
}
