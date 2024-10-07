package main

import (
	"common/db"
	"common/domain/model"
	"common/util"
	"fmt"
	"time"
)

func main() {
	tz := util.GetEnv("TZ", "Asia/Tokyo")
	location, err := time.LoadLocation(tz)
	if err != nil {
		panic(fmt.Sprintf("failed to load time location: %v", err))
	}
	time.Local = location

	db, _ := db.NewDB()

	db.AutoMigrate(&model.User{})
}
