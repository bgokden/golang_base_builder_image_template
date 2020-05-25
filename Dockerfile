# golang debian buster 1.14.1 linux/amd64
# https://github.com/docker-library/golang/blob/master/1.14/buster/Dockerfile
FROM golang@sha256:eee8c0a92bc950ecb20d2dffe46546da12147e3146f1b4ed55072c10cacf4f4c as builder

# Ensure ca-certficates are up to date
RUN update-ca-certificates

WORKDIR /tmp/app

# use modules
COPY go.mod tools.go /tmp/app/

ENV GO111MODULE=on
RUN go mod tidy
RUN go mod download
RUN go mod verify

RUN go get github.com/mattn/goveralls

RUN rm -rf /tmp/app

ONBUILD RUN update-ca-certificates

ONBUILD COPY . .

ONBUILD RUN go test -v -cover -race -coverprofile=./coverage.out ./...

# Enforce code coverage check
# ONBUILD RUN goveralls -coverprofile=./coverage.out -service=$CI_SERVICE -repotoken=$COVERALLS_TOKEN

ONBUILD RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
      -ldflags='-w -s -extldflags "-static"' -a \
      -o /app/app .
