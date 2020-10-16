all:
	mvn compile

run: all
	mvn exec:java -e -Dexec.mainClass=my.pkg.MainClass

clean:
	$(RM) -r target

.PHONY: all run clean
