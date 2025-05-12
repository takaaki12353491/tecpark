package value

import (
	"math/rand"
	"time"

	"github.com/oklog/ulid/v2"
)

type ULID string

func NewULID() ULID {
	entropy := rand.New(rand.NewSource(time.Now().UnixNano()))
	ms := ulid.Timestamp(time.Now())
	id, err := ulid.New(ms, entropy)
	if err != nil {
		panic(err)
	}

	return ULID(id.String())
}
