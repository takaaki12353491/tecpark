package db

import (
	"context"
	"user/internal/domain/repository"

	"gorm.io/gorm"
)

type transaction struct {
	db *gorm.DB
}

func NewTransaction(db *gorm.DB) repository.Transaction {
	return &transaction{db: db}
}

func (t *transaction) Do(ctx context.Context, fn func(ctx context.Context, r *repository.Repository) error) error {
	return t.db.Transaction(func(tx *gorm.DB) error {
		r := repository.NewRepository(
			NewUser(tx),
		)

		return fn(ctx, r)
	})
}
