package db

import (
	"common/db"
	"common/db/query"
	"user/internal/domain/repository"
)

type userRepository struct {
	*db.UserRepository
}

func NewUserRepository(query *query.Query) repository.UserRepository {
	return &userRepository{
		UserRepository: db.NewUserRepository(query),
	}
}
