package xlog

import (
	"fmt"
	"log/slog"

	"github.com/cockroachdb/errors"
)

type stackTrace struct {
	Error  string
	Frames []any
}

type joinedStackTrace struct {
	StackTrace stackTrace
	Join       []joinedStackTrace
}

func (j *joinedStackTrace) flatten() []stackTrace {
	if len(j.Join) == 0 {
		return []stackTrace{j.StackTrace}
	}

	flatten := []stackTrace{}
	for _, s := range j.Join {
		flatten = append(flatten, s.flatten()...)
	}

	return flatten
}

type joinedError interface{ Unwrap() []error }

func extractStackTraces(err error) *joinedStackTrace {
	if err == nil {
		return nil
	}

	var joinedErr joinedError
	subStackTraces := make([]joinedStackTrace, 0)
	if errors.As(err, &joinedErr) {
		errs := joinedErr.Unwrap()
		subStackTraces = make([]joinedStackTrace, 0, len(errs))
		for _, e := range errs {
			if e != nil {
				v := extractStackTraces(e)
				if v != nil {
					subStackTraces = append(subStackTraces, *v)
				}
			}
		}
	}

	_, ok := err.(errors.Printer)
	if !ok {
		return &joinedStackTrace{
			StackTrace: stackTrace{Error: err.Error(), Frames: []any{fmt.Sprintf("%+v", err)}},
			Join:       subStackTraces,
		}
	}

	frames := make([]any, 0, len(errors.GetReportableStackTrace(err).Frames))
	for _, f := range errors.GetReportableStackTrace(err).Frames {
		frames = append(frames, f)
	}
	return &joinedStackTrace{
		StackTrace: stackTrace{Error: err.Error(), Frames: frames},
		Join:       subStackTraces,
	}
}

func StackTrace(err error) slog.Attr {
	st := extractStackTraces(err)
	if st == nil {
		return KeyStackTrace.Attr(stackTrace{})
	}

	return KeyStackTrace.Attr(st.flatten())
}
