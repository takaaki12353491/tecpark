FROM golang:1.24-alpine

COPY . /app

WORKDIR /app

RUN go mod download

CMD [ "go", "run", "migrate.go" ]
