package scalar

import (
	"fmt"
	"io"
	"strconv"

	"github.com/99designs/gqlgen/graphql"
	"github.com/oklog/ulid/v2"
)

func MarshalULID(v ulid.ULID) graphql.Marshaler {
	return graphql.WriterFunc(func(w io.Writer) {
		_, _ = io.WriteString(w, strconv.Quote(v.String()))
	})
}

func UnmarshalULID(v interface{}) (ulid.ULID, error) {
	str, ok := v.(string)
	if !ok {
		return ulid.ULID{}, fmt.Errorf("ULID must be a string")
	}

	return ulid.Parse(str)
}
