package xlog_test

import (
	"fmt"
	"testing"

	"errors"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	xerrors "github.com/takaaki12353491/tecpark/backend/common/errors"
	xlog "github.com/takaaki12353491/tecpark/backend/common/log"
)

func j4_1() error { return xerrors.WithStack(fmt.Errorf("j4_1 error")) }
func j4_2() error { return xerrors.WithStack(fmt.Errorf("j4_2 error")) }
func j3_1() error { return xerrors.WithStack(fmt.Errorf("j3_1 error")) }
func j3_2() error {
	return xerrors.WithStack(errors.Join(
		xerrors.WithStack(j4_1()),
		xerrors.WithStack(j4_2()),
	))
}
func j2() error {
	return xerrors.WithStack(errors.Join(
		xerrors.WithStack(j3_1()),
		xerrors.WithStack(j3_2()),
	))
}
func j1() error { return xerrors.WithStack(j2()) }

func TestStackTrace(t *testing.T) {
	st := xlog.StackTrace(j1())

	stValue := st.Value.Any()
	require.NotNil(t, stValue, "stack trace value should not be nil")

	sts, ok := stValue.([]xlog.ExportStackTrace)
	require.True(t, ok)
	require.NotEmpty(t, sts)

	j3_1_err := sts[0]
	assert.Equal(t, "j3_1 error", j3_1_err.Error)
	assert.NotEmpty(t, j3_1_err.Frames)

	j4_1_err := sts[1]
	assert.Equal(t, "j4_1 error", j4_1_err.Error)
	assert.NotEmpty(t, j4_1_err.Frames)

	j4_2_err := sts[2]
	assert.Equal(t, "j4_2 error", j4_2_err.Error)
	assert.NotEmpty(t, j4_2_err.Frames)
}
