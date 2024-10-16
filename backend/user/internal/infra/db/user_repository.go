package db

import (
	"common/db"
	"user/internal/domain/repository"

	"gorm.io/gorm"
)

type userRepository struct {
	*db.UserRepository
}

func NewUserRepository(conn *gorm.DB) repository.UserRepository {
	return &userRepository{
		UserRepository: db.NewUserRepository(conn),
	}
}
