package db

import (
	"context"
	"user/internal/domain/model"
	"user/internal/domain/repository"
	"user/internal/infra/db/query"

	"gorm.io/gorm"
)

type User struct {
	Conn *gorm.DB
}

func NewUser(conn *gorm.DB) repository.User {
	return &User{conn}
}

func (db *User) GetUsers(ctx context.Context) ([]*model.User, error) {
	return query.Use(db.Conn).WithContext(ctx).User.Find()
}
