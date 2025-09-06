FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o /hello-world-app

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /hello-world-app .

EXPOSE 8080

CMD ["./hello-world-app"]
