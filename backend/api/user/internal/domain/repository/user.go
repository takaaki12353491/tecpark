package repository

import (
	"context"

	"github.com/takaaki12353491/tecpark/backend/common/domain/model"
)

type User interface {
	GetUsers(ctx context.Context) ([]*model.User, error)
}
