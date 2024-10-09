FROM backend:latest AS build

WORKDIR /app/backend/user

RUN go mod download

RUN GOARCH=amd64 GOOS=linux go build -o /main

FROM backend:latest AS local

WORKDIR /app/backend/user

RUN go install github.com/air-verse/air@latest

EXPOSE 80

CMD [ "air" ]

FROM alpine:latest

RUN apk --no-cache add ca-certificates tzdata

COPY --from=build /main /main

EXPOSE 80

CMD ["/main"]
