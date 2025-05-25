FROM golang:1.24-alpine

COPY . /app

WORKDIR /app/cmd/migrate

RUN go mod download

CMD [ "go", "run", "main.go" ]
