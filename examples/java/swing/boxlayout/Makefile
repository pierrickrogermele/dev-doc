# -*- mode:makefile-gmake -*-

export CLASSPATH=.

run: build
	java MyBoxLayout

build: MyBoxLayout.class

%.class: %.java
	javac $<

clean:
	rm -f *.class *~
