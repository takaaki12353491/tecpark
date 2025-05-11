package resolver

import "user/internal/usecase"

// This file will not be regenerated automatically.
//
// It serves as dependency injection for your app, add any dependencies you require here.

type Resolver struct {
	userUseCase *usecase.User
}

func NewResolver(
	userUseCase *usecase.User,
) *Resolver {
	return &Resolver{
		userUseCase: userUseCase,
	}
}
