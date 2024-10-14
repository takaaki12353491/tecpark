gqlgen:
	go run github.com/99designs/gqlgen generate

wire:
	cd internal/infra/di; wire gen

test:
	go test -v -cover -coverprofile=coverage.out  ./...

coverage:
	go tool cover -html=coverage.out -o coverage.html; open coverage.html