package util

import (
	"testing"

	"github.com/stretchr/testify/suite"
)

func TestStackTestSuite(t *testing.T) {
	suite.Run(t, new(StackTestSuite))
}

type StackTestSuite struct {
	suite.Suite
	stack Stack[int]
}

func (suite *StackTestSuite) SetupTest() {
	suite.stack = Stack[int]{}
}

func (suite *StackTestSuite) TestPush() {
	suite.stack.Push(1)
	suite.Equal(Stack[int]{1}, suite.stack, "expected stack [1]")

	suite.stack.Push(2)
	suite.Equal(Stack[int]{1, 2}, suite.stack, "expected stack [1, 2]")
}

func (suite *StackTestSuite) TestPop() {
	suite.stack.Push(1)
	suite.stack.Push(2)

	item, err := suite.stack.Pop()
	suite.NoError(err, "unexpected error")
	suite.Equal(2, item, "expected popped item 2")

	item, err = suite.stack.Pop()
	suite.NoError(err, "unexpected error")
	suite.Equal(1, item, "expected popped item 1")

	_, err = suite.stack.Pop()
	suite.Error(err, "expected error when popping from empty stack")
}
