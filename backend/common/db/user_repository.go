package db

import (
	"common/db/query"
	"common/domain/model"
	"common/domain/repository"
)

var _ repository.UserRepository = (*UserRepository)(nil) // インターフェースを実装しているか確認

type UserRepository struct {
	Query *query.Query
}

func NewUserRepository(query *query.Query) *UserRepository {
	return &UserRepository{query}
}

func (r *UserRepository) GetUsers() ([]*model.User, error) {
	return r.Query.User.Find()
}
