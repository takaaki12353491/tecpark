//go:generate mockgen -source=$GOFILE -package=mock_$GOPACKAGE -destination=mock/$GOFILE
package repository

import (
	"context"
	"user/internal/domain/model"
)

type User interface {
	GetUsers(ctx context.Context) ([]*model.User, error)
}
