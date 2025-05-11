package usecase

import (
	"context"
	"testing"
	"user/internal/domain/model"
	"user/internal/infra/db"
	"user/internal/infra/db/query"

	"github.com/google/go-cmp/cmp"
	"github.com/google/go-cmp/cmp/cmpopts"
	"github.com/oklog/ulid/v2"
	"github.com/stretchr/testify/suite"
	"gorm.io/gorm"
)

func TestUser(t *testing.T) {
	suite.Run(t, new(UserSuite))
}

type UserSuite struct {
	suite.Suite
	user *User
	tx   *gorm.DB
}

func (s *UserSuite) SetupTest() {
	s.tx = testConn.Begin()
	query.SetDefault(s.tx)
	userRepository := db.NewUser(s.tx)
	s.user = NewUser(userRepository)
}

func (s *UserSuite) TearDownTest() {
	s.tx.Rollback()
}

func (s *UserSuite) TestGetUsers() {
	ctx := s.T().Context()

	users := []*model.User{
		{ID: ulid.Make(), Nickname: "Nickname1"},
		{ID: ulid.Make(), Nickname: "Nickname2"},
	}
	err := query.User.WithContext(ctx).CreateInBatches(users, 100)
	if err != nil {
		s.T().Fatalf("failed to create users in batches: %v", err)
	}

	result, err := s.user.GetUsers(context.Background())

	s.NoError(err)

	cmpopt := cmpopts.IgnoreFields(model.User{}, "CreatedAt", "UpdatedAt")
	for k := range users {
		if diff := cmp.Diff(users[k], result[k], cmpopt); diff != "" {
			s.T().Errorf("user value is mismatch (-want +got):%s\n", diff)
		}
	}
}
