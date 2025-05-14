package main

import (
	"fmt"
	"time"
	"user/internal/infra/server"

	"github.com/takaaki12353491/tecpark/backend/common/env"
	_ "github.com/takaaki12353491/tecpark/backend/common/log"
)

func main() {
	tz := env.Get("TZ", "Asia/Tokyo")

	location, err := time.LoadLocation(tz)
	if err != nil {
		panic(fmt.Sprintf("failed to load time location: %v", err))
	}

	time.Local = location

	server.Run()
}
