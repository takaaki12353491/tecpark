package usecase

import (
	"context"
	"user/internal/domain/repository"

	"github.com/takaaki12353491/tecpark/backend/common/domain/model"
)

type User struct {
	userRepository repository.User
}

func NewUser(userRepository repository.User) *User {
	return &User{
		userRepository: userRepository,
	}
}

func (uc *User) GetUsers(ctx context.Context) ([]*model.User, error) {
	users, err := uc.userRepository.GetUsers(ctx)
	if err != nil {
		return nil, err
	}

	return users, nil
}
