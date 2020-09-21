# -*- mode:makefile-gmake -*-

export CLASSPATH=.

run: build
	java TestDates

build: TestDates.class

%.class: %.java
	javac $<

clean:
	rm -f *.class *~
