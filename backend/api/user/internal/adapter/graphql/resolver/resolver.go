package resolver

import (
	iport "user/internal/usecase/input/port"
)

// This file will not be regenerated automatically.
//
// It serves as dependency injection for your app, add any dependencies you require here.

type Resolver struct {
	userIPort iport.User
}

func NewResolver(
	userIPort iport.User,
) *Resolver {
	return &Resolver{
		userIPort: userIPort,
	}
}
