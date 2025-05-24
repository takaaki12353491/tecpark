package db

import (
	"context"
	"user/internal/domain/model"
	"user/internal/domain/repository"

	"github.com/oklog/ulid/v2"
	xerrors "github.com/takaaki12353491/tecpark/backend/common/errors"
	dbmodel "github.com/takaaki12353491/tecpark/backend/db/rdb/model"
	"github.com/takaaki12353491/tecpark/backend/db/rdb/query"
	"gorm.io/gorm"
)

type User struct {
	db *gorm.DB
}

func NewUser(db *gorm.DB) repository.User {
	return &User{db}
}

func (db *User) GetUsers(ctx context.Context) ([]*model.User, error) {
	records, err := query.User.WithContext(ctx).Find()
	if err != nil {
		return []*model.User{}, xerrors.WithStack(err)
	}

	users := make([]*model.User, 0, len(records))
	for _, record := range records {
		users = append(users, db.toDomain(record))
	}

	return users, nil
}

func (db *User) toDomain(dbmodel *dbmodel.User) *model.User {
	return &model.User{
		ID:        ulid.MustParse(dbmodel.ID),
		Nickname:  dbmodel.Nickname,
		CreatedAt: dbmodel.CreatedAt,
		UpdatedAt: dbmodel.UpdatedAt,
	}
}
