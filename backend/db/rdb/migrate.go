package main

import (
	"fmt"
	"time"

	"github.com/takaaki12353491/tecpark/backend/common/db"
	"github.com/takaaki12353491/tecpark/backend/common/env"
	dbmodel "github.com/takaaki12353491/tecpark/backend/db/rdb/model"
)

func main() {
	tz := env.Get("TZ", "Asia/Tokyo")
	location, err := time.LoadLocation(tz)
	if err != nil {
		panic(fmt.Sprintf("failed to load time location: %v", err))
	}
	time.Local = location

	db, _ := db.New()

	db.AutoMigrate(&dbmodel.User{})
}
