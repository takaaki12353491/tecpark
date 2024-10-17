package repository

import (
	"common/domain/model"
	"context"
)

type UserRepository interface {
	GetUsers(ctx context.Context) ([]*model.User, error)
}
