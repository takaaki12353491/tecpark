package usecase

import (
	"context"
	"testing"
	"user/internal/infra/db"

	"github.com/takaaki12353491/tecpark/backend/common/db/query"
	"github.com/takaaki12353491/tecpark/backend/common/domain/model"

	"github.com/google/go-cmp/cmp"
	"github.com/google/go-cmp/cmp/cmpopts"
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
	userRepository := db.NewUserRepository(s.tx)
	s.user = NewUser(userRepository)
}

func (s *UserSuite) TearDownTest() {
	s.tx.Rollback()
}

func (s *UserSuite) TestGetUsers() {
	users := []*model.User{
		{ID: "1", Nickname: "Nickname1"},
		{ID: "2", Nickname: "Nickname2"},
	}
	err := query.Use(s.tx).User.CreateInBatches(users, 100)
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
