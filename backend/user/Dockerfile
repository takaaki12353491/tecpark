FROM backend:latest AS build

WORKDIR /app/user

RUN go mod download

RUN GOARCH=amd64 GOOS=linux go build -o /main

FROM backend:latest AS local

WORKDIR /app/user

RUN go install github.com/air-verse/air@latest

EXPOSE 80

CMD [ "air" ]

FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=build /main /main

EXPOSE 80

CMD ["/main"]
