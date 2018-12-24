BINARY=fritz-tls

.PHONY: all build fmt bootstrap lint

all: build

build:
	go build -o ${BINARY}

fmt:
	gofmt -w -s $(shell find . -type f -name '*.go' -not -path "./vendor/*")

bootstrap:
	go get -u gopkg.in/alecthomas/gometalinter.v2
	go get -d github.com/goreleaser/goreleaser
	gometalinter.v2 --install
	go get -d github.com/goreleaser/goreleaser; \
	  cd ${GOPATH}/src/github.com/goreleaser/goreleaser ;\
	  make setup build

lint:
	gometalinter.v2 ./... --vendor .
