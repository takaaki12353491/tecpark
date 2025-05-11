FROM golang:1.24-alpine AS build

COPY . /app

WORKDIR /app

RUN go mod download

RUN GOARCH=amd64 GOOS=linux go build -o /main

FROM alpine:latest

RUN apk --no-cache add ca-certificates tzdata

COPY --from=build /main /main

EXPOSE 80

CMD ["/main"]
