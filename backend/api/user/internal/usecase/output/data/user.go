package odata

import (
	"time"
)

type User struct {
	ID        string
	Nickname  string
	CreatedAt time.Time
	UpdatedAt time.Time
}
