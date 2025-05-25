//go:generate mockgen -source=$GOFILE -package=mock_$GOPACKAGE -destination=mock/$GOFILE
package repository

import "context"

type Transaction interface {
	Do(context.Context, func(context.Context, *Repository) error) error
}
