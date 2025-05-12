package value_test

import (
	"testing"

	"github.com/stretchr/testify/suite"
	"github.com/takaaki12353491/tecpark/backend/common/value"
)

type ULIDTestSuite struct {
	suite.Suite
}

func TestULID(t *testing.T) {
	suite.Run(t, new(ULIDTestSuite))
}

func (s *ULIDTestSuite) TestNewULID() {
	ulid := value.NewULID()
	s.Regexp(`^[0-9A-Z]{26}`, string(ulid))
	s.Regexp(`^[0-7][0-9A-Z]{9}`, string(ulid)[:10])
	s.Regexp(`[0-9A-Z]{16}$`, string(ulid)[10:])
}
