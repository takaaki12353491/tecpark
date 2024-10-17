package service

import (
	"common/domain/model"
	"context"
	"user/internal/domain/repository"
)

type UserService struct {
	userRepository repository.UserRepository
}

func NewUserService(userRepository repository.UserRepository) *UserService {
	return &UserService{
		userRepository: userRepository,
	}
}

func (s *UserService) GetUsers(ctx context.Context) ([]*model.User, error) {
	users, err := s.userRepository.GetUsers(ctx)
	if err != nil {
		return nil, err
	}

	return users, nil
}
