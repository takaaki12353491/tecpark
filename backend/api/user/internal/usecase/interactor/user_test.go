package interactor_test

import (
	"context"
	"testing"
	"user/internal/domain/model"
	mock_repository "user/internal/domain/repository/mock"
	"user/internal/usecase/interactor"

	"github.com/google/go-cmp/cmp"
	"github.com/google/go-cmp/cmp/cmpopts"
	"github.com/oklog/ulid/v2"
	"github.com/stretchr/testify/suite"
	"go.uber.org/mock/gomock"
)

type UserSuite struct {
	suite.Suite
	ctrl           *gomock.Controller
	tx             *mock_repository.MockTransaction
	userRepository *mock_repository.MockUser
	userUseCase    *interactor.User
}

func TestUser(t *testing.T) {
	suite.Run(t, new(UserSuite))
}

func (s *UserSuite) SetupSuite() {
	s.ctrl = gomock.NewController(s.T())
	s.tx = mock_repository.NewMockTransaction(s.ctrl)
	s.userRepository = mock_repository.NewMockUser(s.ctrl)
	s.userUseCase = interactor.NewUser(s.tx, s.userRepository).(*interactor.User)
}

func (s *UserSuite) TearDownTest() {
	s.ctrl.Finish()
}

func (s *UserSuite) TestGetUsers() {
	s.T().Parallel()

	want := []*model.User{
		{ID: ulid.Make(), Nickname: "Nickname1"},
		{ID: ulid.Make(), Nickname: "Nickname2"},
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
