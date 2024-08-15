FROM golang:1.22-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN GOARCH=amd64 GOOS=linux go build -o /main

FROM alpine:3.18

RUN apk --no-cache add ca-certificates

COPY --from=build /main /main

EXPOSE 80

CMD ["/main"]
