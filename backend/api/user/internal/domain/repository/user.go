package repository

import (
	"context"
	"user/internal/domain/model"
)

type User interface {
	GetUsers(ctx context.Context) ([]*model.User, error)
}
