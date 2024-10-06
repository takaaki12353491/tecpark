package main

import (
	"common/domain/model"
	"common/util"
	"fmt"
	"log"
	"net/url"
	"os"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

func main() {
	user := os.Getenv("MYSQL_USER")
	password := os.Getenv("MYSQL_PASSWORD")
	host := os.Getenv("MYSQL_HOST")
	port := os.Getenv("MYSQL_PORT")
	database := os.Getenv("MYSQL_DATABASE")
	tz := util.GetEnv("TZ", "Asia/Tokyo")
	tzEncoded := url.QueryEscape(tz)
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True&loc=%s", user, password, host, port, database, tzEncoded)

	logger := logger.New(
		log.Default(),
		logger.Config{
			LogLevel: logger.Info,
		},
	)

	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{
		Logger: logger,
	})
	if err != nil {
		panic(fmt.Sprintf("failed to connect to database: %v", err))
	}

	db.AutoMigrate(&model.User{})
}
