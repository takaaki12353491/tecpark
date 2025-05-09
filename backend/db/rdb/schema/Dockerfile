FROM backend:latest

WORKDIR /app/backend/db/rdb/schema

RUN go mod download

CMD [ "go", "run", "migrate.go" ]
