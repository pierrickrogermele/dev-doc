JAVA_HOME = /Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home
CXXFLAGS = -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/darwin/

all: jni_basic_example Main.class

jni_basic_example: jni_basic_example.o
	$(CXX) -L$(JAVA_HOME)/jre/lib/server -o $@ -ljvm $< 

run: all
	LD_LIBRARY_PATH=$$LD_LIBRARY_PATH:$(JAVA_HOME)/jre/lib/server ./jni_basic_example

Main.class: Main.java
	$(JAVA_HOME)/bin/javac Main.java

clean:
	$(RM) jni_basic_example *.o *.class

.PHONY: all clean run
