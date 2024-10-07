package db

import (
	"common/db/query"
	"common/domain/model"
	"common/domain/repository"
)

func NewUserRepository(query *query.Query) repository.UserRepository {
	return &UserRepository{query}
}

type UserRepository struct {
	Query *query.Query
}

func (r *UserRepository) GetUsers() ([]*model.User, error) {
	return r.Query.User.Find()
}
