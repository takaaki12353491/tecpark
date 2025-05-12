package usecase_test

import (
	"context"
	"testing"
	"user/internal/domain/model"
	mock_repository "user/internal/domain/repository/mock"
	"user/internal/usecase"

	"github.com/google/go-cmp/cmp"
	"github.com/google/go-cmp/cmp/cmpopts"
	"github.com/stretchr/testify/suite"
	"github.com/takaaki12353491/tecpark/backend/common/value"
	"go.uber.org/mock/gomock"
)

func TestUser(t *testing.T) {
	suite.Run(t, new(UserSuite))
}

type UserSuite struct {
	suite.Suite
	ctrl           *gomock.Controller
	userRepository *mock_repository.MockUser
	userUseCase    *usecase.User
}

func (s *UserSuite) SetupSuite() {
	s.ctrl = gomock.NewController(s.T())
	s.userRepository = mock_repository.NewMockUser(s.ctrl)
	s.userUseCase = usecase.NewUser(s.userRepository)
}

func (s *UserSuite) TearDownTest() {
	s.ctrl.Finish()
}

func (s *UserSuite) TestGetUsers() {
	want := []*model.User{
		{ID: value.NewULID(), Nickname: "Nickname1"},
		{ID: value.NewULID(), Nickname: "Nickname2"},
	}

	s.userRepository.EXPECT().
		GetUsers(gomock.Any()).
		Return(want, nil).
		Times(1)

	got, err := s.userUseCase.GetUsers(context.Background())

	s.Require().NoError(err)

	cmpopt := cmpopts.IgnoreFields(model.User{}, "CreatedAt", "UpdatedAt")
	for k := range want {
		if diff := cmp.Diff(want[k], got[k], cmpopt); diff != "" {
			s.T().Errorf("user value is mismatch (-want +got):%s\n", diff)
		}
	}
}
