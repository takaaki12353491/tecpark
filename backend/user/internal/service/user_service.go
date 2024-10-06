package service

import (
	"common/domain/model"
	"common/domain/repository"
)

type UserService interface {
	GetUsers() ([]*model.User, error)
}

func NewUserService(userRepository repository.UserRepository) UserService {
	return &userService{
		userRepository: userRepository,
	}
}

type userService struct {
	userRepository repository.UserRepository
}

func (s *userService) GetUsers() ([]*model.User, error) {
	users, err := s.userRepository.GetUsers()
	if err != nil {
		return nil, err
	}

	return users, nil
}
