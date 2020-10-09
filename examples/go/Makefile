all: bin/hello

bin/hello: src/hello/hello.go
	GOPATH=${PWD} go install hello

run:
	bin/hello

clean:
	$(RM) -r bin

.PHONY: all run clean
