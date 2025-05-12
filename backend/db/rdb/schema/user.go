package schema

import (
	"time"

	"github.com/oklog/ulid/v2"
)

type User struct {
	ID        ulid.ULID `gorm:"primarykey;type:char(26)"`
	Nickname  string    `gorm:"not null;type:varchar(30);"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP(3)"`
	UpdatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3)"`
}
