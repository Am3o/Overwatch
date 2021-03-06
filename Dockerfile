FROM golang:1.15 AS build

WORKDIR /app
COPY . /app

RUN go mod vendor
RUN CGO_ENABLED=0 go build -mod=vendor -a -ldflags '-w' -o /app/main

FROM alpine

COPY --from=build /app/main /usr/local/bin/app
ENTRYPOINT /usr/local/bin/app
