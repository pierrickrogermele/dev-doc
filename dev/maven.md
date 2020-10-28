<!-- vimvars: b:markdown_embedded_syntax={'sh':'bash','bash':'','xml':''} -->
# Maven

 * [Maven Repository](https://mvnrepository.com/).

For a quick introduction, see [Maven in 5 Minutes](https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html).

## Main goals

Here is a list of the main maven goals (i.e.: targets):
```bash
mvn compile
mvn test
mvn test-compile # only compile tests, do not run them.
mvn package # build .jar
mvn install # install in local repository
mvn clean
mvn javadoc:javadoc # Build Java doc
```

See [Introduction to the Build Lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html).

## Running code

To execute a class of your project, run:
```bash
mvn exec:java -e -Dexec.mainClass=my.path.to.my.MainClass
```
See [3 ways to run Java main from Maven](http://www.vineetmanohar.com/2009/11/3-ways-to-run-java-main-from-maven/).
Arguments and env vars can also be defined.

Execute application under tiling window managers (like xmonad):
```sh
_JAVA_AWT_WM_NONREPARENTING=1 mvn exec:java -e -Dexec.mainClass=my.path.to.my.MainClass
```

It can also be done be defining a plugin goal:
```xml
	<build>
		<plugins>
			<plugin>
				<groupId>org.codehaus.mojo</groupId>
				<artifactId>exec-maven-plugin</artifactId>
				<version>1.4.0</version>
				<executions>
					<execution>
						<goals>
							<goal>java</goal>
						</goals>
					</execution>
				</executions>
				<configuration>
					<mainClass>HelloWorld</mainClass>
				</configuration>
			</plugin>
		</plugins>
	</build>
```
And then running simply:
```bash
mvn exec:java
```

## Stack trace

To make maven print the stack trace when an error occurs:
```bash
mvn -e test
```

## Version

To get version of Maven, and version of Java used:
```bash
mvn -version
```

## Java compiler version

On MACOS-X, to run a specific version of the Java compiler:
```bash
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/ mvn ...
```

## Dependencies

To search for dependencies, go to <http://mvnrepository.com/>.

On OSX, dependencies are stored inside `~/.m2`.

Inside `pom.xml`:
```xml
<dependencies>
	<dependency>
		<groupId>junit</groupId>
		<artifactId>junit</artifactId>
		<version>4.12</version>
		<scope>test</scope>
	</dependency>
</dependencies>
```

List all dependencies:
```bash
mvn dependency:list
```

List all licenses used in the project:
```bash
mvn license:aggregate-add-third-party
```

Generate a dependencies report:
```bash
mvn project-info-reports:dependencies
```
It will generate the file `target/site/dependencies.html`.

Output classpath:
```bash
mvn org.apache.maven.plugins:maven-dependency-plugin:2.10:build-classpath
```

Tree of dependencies:
```bash
mvn dependency:tree
```

Downloading sources of dependencies:
```bash
mvn dependency:sources
```

Downloading Javadoc of dependencies:
```bash
mvn dependency:resolve -Dclassifier=javadoc
```

## Debugging

Execute code in debug mode:
```sh
mvnDebug exec:java -e -Dexec.mainClass=my.path.to.my.MainClass
```
`mvnDebug` will start listening to port 8000. You will then have to run a debugger on that port:
```sh
jdb -attach 8000
```

## Test

Running tests:
```bash
mvn test
```

Running a specific class:
```bash
mvn -Dtest=MyClass test
```

Running a specific method:
```bash
mvn -Dtest=MyClass#myTestMethod test
```

### Using JUnit for testing.

Add the following dependency to the `pom.xml` file:
```xml
<dependency>
	<groupId>junit</groupId>
	<artifactId>junit</artifactId>
	<version>4.11</version>
	<scope>test</scope>
</dependency>
```

## Encoding

Setting encoding to UTF-8, thus producing a platform independent code:
```xml
	<properties>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
	</properties>
```
Setting this, solves the following warning:
	[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!

## Plugins

### IzPack

 * [IzPack](https://izpack.atlassian.net/wiki/spaces/IZPACK/pages/491576/Compiling+Using+Maven).
 * [Easy Installer with IzPack](http://dontpanic.42.nl/2011/07/easy-installer-with-izpack.html).

A plugin for building an installer for Windows, MacOS and Linux.

### Apache Maven Assembly

 * [Apache Maven Assembly Plugin](http://maven.apache.org/plugins/maven-assembly-plugin/).

### Apache Maven Shade

 * [Apache Maven Shade Plugin](http://maven.apache.org/plugins/maven-shade-plugin/).

Can create an executable uber-jar.
