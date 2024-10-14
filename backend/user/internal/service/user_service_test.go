package service

import (
	"common/domain/model"
	"context"
	"errors"
	"testing"
	"user/internal/domain/repository"

	"github.com/stretchr/testify/mock"
	"github.com/stretchr/testify/suite"
)

var _ repository.UserRepository = (*MockUserRepository)(nil)

type MockUserRepository struct {
	mock.Mock
}

func (m *MockUserRepository) GetUsers(ctx context.Context) ([]*model.User, error) {
	args := m.Called(ctx)
	if args.Get(0) == nil {
		return nil, args.Error(1)
	}
	return args.Get(0).([]*model.User), args.Error(1)
}

func TestUserService(t *testing.T) {
	suite.Run(t, new(UserServiceSuite))
}

type UserServiceSuite struct {
	suite.Suite
	userService    *UserService
	userRepository *MockUserRepository
}

func (s *UserServiceSuite) SetupTest() {
	s.userRepository = new(MockUserRepository)
	s.userService = NewUserService(s.userRepository)
}

func (s *UserServiceSuite) TestGetUsers_Success() {
	expectedUsers := []*model.User{
		{ID: "1", Nickname: "1"},
		{ID: "2", Nickname: "2"},
	}
	s.userRepository.On("GetUsers", mock.Anything).Return(expectedUsers, nil)

	result, err := s.userService.GetUsers(context.Background())

	s.NoError(err)
	s.Equal(expectedUsers, result)
}

func (s *UserServiceSuite) TestGetUsers_Error() {
	expectedError := errors.New("failed to get users")
	s.userRepository.On("GetUsers", mock.Anything).Return(nil, expectedError)

	result, err := s.userService.GetUsers(context.Background())

	s.Error(err)
	s.Nil(result)
	s.Equal(expectedError, err)
}
