package model

import (
	"time"

	"github.com/oklog/ulid/v2"
)

type User struct {
	ID        ulid.ULID
	Nickname  string
	CreatedAt time.Time
	UpdatedAt time.Time
}
