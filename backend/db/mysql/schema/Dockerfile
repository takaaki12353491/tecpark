FROM backend:latest

WORKDIR /app/backend/db/mysql/schema

RUN go mod download

CMD [ "go", "run", "migrate.go" ]
