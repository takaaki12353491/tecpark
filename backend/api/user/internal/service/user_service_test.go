package service

import (
	"common/db/query"
	"common/domain/model"
	"context"
	"testing"
	"user/internal/infra/db"

	"github.com/google/go-cmp/cmp"
	"github.com/google/go-cmp/cmp/cmpopts"
	"github.com/stretchr/testify/suite"
	"gorm.io/gorm"
)

func TestUserService(t *testing.T) {
	suite.Run(t, new(UserServiceSuite))
}

type UserServiceSuite struct {
	suite.Suite
	userService *UserService
	tx          *gorm.DB
}

func (s *UserServiceSuite) SetupTest() {
	s.tx = testConn.Begin()
	userRepository := db.NewUserRepository(s.tx)
	s.userService = NewUserService(userRepository)
}

func (s *UserServiceSuite) TearDownTest() {
	s.tx.Rollback()
}

func (s *UserServiceSuite) TestGetUsers() {
	users := []*model.User{
		{ID: "1", Nickname: "Nickname1"},
		{ID: "2", Nickname: "Nickname2"},
	}
	err := query.Use(s.tx).User.CreateInBatches(users, 100)
	if err != nil {
		s.T().Fatalf("failed to create users in batches: %v", err)
	}

	result, err := s.userService.GetUsers(context.Background())

	s.NoError(err)

	cmpopt := cmpopts.IgnoreFields(model.User{}, "CreatedAt", "UpdatedAt")
	for k := range users {
		if diff := cmp.Diff(users[k], result[k], cmpopt); diff != "" {
			s.T().Errorf("user value is mismatch (-want +got):%s\n", diff)
		}
	}
}
