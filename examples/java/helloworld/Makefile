# -*- mode:makefile-gmake -*-

export CLASSPATH=.

run: build
	java HelloWorldApp

build: HelloWorldApp.class

%.class: %.java
	javac $<

clean:
	rm -f *.class *~
