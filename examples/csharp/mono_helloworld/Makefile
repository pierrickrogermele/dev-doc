all: HelloWorld.exe

HelloWorld.exe: $(wildcard *.cs)
	mcs $^

clean:
	$(RM) *.exe

.PHONY: all clean
