package db

import (
	"context"
	"user/internal/domain/model"
	"user/internal/domain/repository"
	"user/internal/infra/db/query"

	xerrors "github.com/takaaki12353491/tecpark/backend/common/errors"
	"gorm.io/gorm"
)

type User struct {
	Conn *gorm.DB
}

func NewUser(conn *gorm.DB) repository.User {
	return &User{conn}
}

func (db *User) GetUsers(ctx context.Context) ([]*model.User, error) {
	users, err := query.User.WithContext(ctx).Find()
	if err != nil {
		return []*model.User{}, xerrors.WithStack(err)
	}

	return users, nil
}
