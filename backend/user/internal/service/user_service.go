package service

import (
	"common/domain/model"
	"user/internal/domain/repository"
)

type UserService interface {
	GetUsers() ([]*model.User, error)
}

type userService struct {
	userRepository repository.UserRepository
}

func NewUserService(userRepository repository.UserRepository) UserService {
	return &userService{
		userRepository: userRepository,
	}
}

func (s *userService) GetUsers() ([]*model.User, error) {
	users, err := s.userRepository.GetUsers()
	if err != nil {
		return nil, err
	}

	return users, nil
}
