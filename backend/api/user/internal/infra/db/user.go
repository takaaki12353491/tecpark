package db

import (
	"context"
	"user/internal/domain/repository"

	"github.com/takaaki12353491/tecpark/backend/common/db/query"
	"github.com/takaaki12353491/tecpark/backend/common/domain/model"
	"gorm.io/gorm"
)

type User struct {
	Conn *gorm.DB
}

func NewUserRepository(conn *gorm.DB) repository.User {
	return &User{conn}
}

func (db *User) GetUsers(ctx context.Context) ([]*model.User, error) {
	return query.Use(db.Conn).WithContext(ctx).User.Find()
}
