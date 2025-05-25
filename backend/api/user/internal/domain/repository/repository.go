package repository

type Repository struct {
	User User
}

func NewRepository(user User) *Repository {
	return &Repository{
		User: user,
	}
}
