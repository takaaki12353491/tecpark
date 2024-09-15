package model

import (
	"time"
)

type User struct {
	ID        uint      `gorm:"primarykey"`
	CreatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP(3)"`
	UpdatedAt time.Time `gorm:"not null;default:CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3)"`
}
