FROM backend:latest

WORKDIR /app/db/mysql

RUN go mod download

WORKDIR /app/db/mysql/schema

CMD [ "go", "run", "migrate.go" ]
