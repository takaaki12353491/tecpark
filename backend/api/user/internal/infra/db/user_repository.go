package db

import (
	"user/internal/domain/repository"

	"github.com/takaaki12353491/tecpark/backend/common/db"

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
