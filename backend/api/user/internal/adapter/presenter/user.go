package presenter

import (
	"user/internal/domain/model"
	odata "user/internal/usecase/output/data"
)

type User struct {
}

func NewUser() *User {
	return &User{}
}

func (u *User) Present(users []*model.User) []*odata.User {
	odataUsers := make([]*odata.User, 0, len(users))
	for _, user := range users {
		odataUsers = append(odataUsers, &odata.User{
			ID:        user.ID.String(),
			Nickname:  user.Nickname,
			CreatedAt: user.CreatedAt,
			UpdatedAt: user.UpdatedAt,
		})
	}

	return odataUsers
}
