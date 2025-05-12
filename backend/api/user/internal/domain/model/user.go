package model

import (
	"time"

	"github.com/takaaki12353491/tecpark/backend/common/value"
)

type User struct {
	ID        value.ULID `gorm:"primarykey;type:char(26)"`
	Nickname  string     `gorm:"not null;type:varchar(30);"`
	CreatedAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP(3)"`
	UpdatedAt time.Time  `gorm:"not null;default:CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3)"`
}
