package value

import (
	"crypto/rand"
	"time"

	"github.com/oklog/ulid/v2"
)

var entropy = ulid.Monotonic(rand.Reader, 0)

func NewULID() ulid.ULID {
	ms := ulid.Timestamp(time.Now())
	return ulid.MustNew(ms, entropy)
}
