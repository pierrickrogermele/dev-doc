CFLAGS = -std=c++17 -I$(VULKAN_SDK_PATH)/include
LDFLAGS = `pkg-config --static --libs glfw3` -lvulkan

all: prg

prg: *.cpp
	    $(CXX) $(CFLAGS) -o prg *.cpp $(LDFLAGS)

run: prg
	    ./prg

clean:
	    $(RM) prg

.PHONY: all test clean
