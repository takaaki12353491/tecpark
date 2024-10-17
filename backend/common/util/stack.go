package util

import "fmt"

type Stack[T any] []T

func (s *Stack[T]) Push(item T) {
	*s = append(*s, item)
}

func (s *Stack[T]) Pop() (T, error) {
	var zero T
	if s == nil || len(*s) == 0 {
		return zero, fmt.Errorf("stack is nil or empty")
	}

	item := (*s)[len(*s)-1]
	*s = (*s)[:len(*s)-1]

	return item, nil
}
