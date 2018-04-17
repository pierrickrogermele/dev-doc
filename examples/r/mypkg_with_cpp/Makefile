all: check build

check:
	R CMD check .

build:
	R CMD build .

clean:
	$(RM) src/*.o src/*.so mypkg_*.tar.gz

.PHONY: all check clean build
