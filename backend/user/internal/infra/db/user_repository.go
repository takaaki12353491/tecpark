package db

import (
	"common/db"
	"common/db/query"
	"user/internal/domain/repository"
)

func NewUserRepository(query *query.Query) repository.UserRepository {
	return &userRepository{
		UserRepository: db.UserRepository{
			Query: query,
		},
	}
}

type userRepository struct {
	db.UserRepository
}
