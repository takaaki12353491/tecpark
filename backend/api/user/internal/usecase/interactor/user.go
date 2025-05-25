package interactor

import (
	"context"
	"user/internal/domain/model"
	"user/internal/domain/repository"
	iport "user/internal/usecase/input/port"

	xerrors "github.com/takaaki12353491/tecpark/backend/common/errors"
)

type User struct {
	tx             repository.Transaction
	userRepository repository.User
}

func NewUser(tx repository.Transaction, userRepository repository.User) iport.User {
	return &User{
		tx:             tx,
		userRepository: userRepository,
	}
}

func (uc *User) GetUsers(ctx context.Context) ([]*model.User, error) {
	users, err := uc.userRepository.GetUsers(ctx)
	if err != nil {
		return nil, xerrors.WithStack(err)
	}

	return users, nil
}
