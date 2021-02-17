## build stage
FROM golang:1.15 AS builder
WORKDIR /app
COPY . .
RUN go build -o sangrenel .

# final stage
FROM alpine:latest
RUN apk add --no-cache ca-certificates libc6-compat
COPY --from=builder /app/sangrenel /bin/
ENTRYPOINT ["/bin/sangrenel"]
CMD ["--help"]
