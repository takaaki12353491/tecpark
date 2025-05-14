package xerrors

import (
	"github.com/cockroachdb/errors"
)

func WithStack(err error) error {
	_, ok := err.(errors.Printer)
	if ok {
		return err
	}

	return errors.WithStack(err)
}
