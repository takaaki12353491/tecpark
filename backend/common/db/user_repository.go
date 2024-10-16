package db

import (
	"common/db/query"
	"common/domain/model"
	"common/domain/repository"
	"context"

	"gorm.io/gorm"
)

var _ repository.UserRepository = (*UserRepository)(nil) // インターフェースを実装しているか確認

type UserRepository struct {
	Conn *gorm.DB
}

func NewUserRepository(conn *gorm.DB) *UserRepository {
	return &UserRepository{conn}
}

func (r *UserRepository) GetUsers(ctx context.Context) ([]*model.User, error) {
	return query.Use(r.Conn).User.Find()
}
