package repository

import "common/domain/model"

type UserRepository interface {
	GetUsers() ([]*model.User, error)
}
