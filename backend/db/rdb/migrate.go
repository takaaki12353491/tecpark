package main

import (
	"fmt"
	"time"

	"github.com/takaaki12353491/tecpark/backend/common/db"
	"github.com/takaaki12353491/tecpark/backend/common/util"
	"github.com/takaaki12353491/tecpark/db/rdb/schema"
)

func main() {
	tz := util.GetEnv("TZ", "Asia/Tokyo")
	location, err := time.LoadLocation(tz)
	if err != nil {
		panic(fmt.Sprintf("failed to load time location: %v", err))
	}
	time.Local = location

	db, _ := db.New()

	db.AutoMigrate(&schema.User{})
}
