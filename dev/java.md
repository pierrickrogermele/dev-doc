<!-- vimvars: b:markdown_embedded_syntax={'java':'','xml':'','jproperties':''} -->
# Java

 * "The Clean Coder" by Martin.
 * books by Herb Schildt.
 * [VIDEO: Java 8 DOs and DON’Ts](https://dineshramitc.wordpress.com/2015/09/22/video-java-8-dos-and-donts/).
 * [Java Quiz](http://topjavatutorial.com/java-quiz/).
 * [The Java® Language Specification - Java SE 7 Edition](http://docs.oracle.com/javase/specs/jls/se7/jls7.pdf).
 * [The Java® Virtual Machine Specification - Java SE 7 Edition](https://docs.oracle.com/javase/specs/jvms/se7/jvms7.pdf).

 * [Documentation](http://docs.oracle.com/javase/).
 * [Tutorials](http://docs.oracle.com/javase/tutorial/index.html).
 * [JDK 15 Documentation](https://docs.oracle.com/en/java/javase/15/).
 * [Java™ Platform, Standard Edition 7 API](http://docs.oracle.com/javase/7/docs/api/index.html).

Books:
 * [Effective Java (2nd Edition)](https://www.amazon.com/Effective-Java-2nd-Joshua-Bloch/dp/0321356683/ref=sr_1_1?s=books&ie=UTF8&qid=1472635292&sr=1-1&keywords=effective+java).
 * JDBC et Java Guide du programmeur, George Reese, éd. O'Reilly
 * Java 2D Graphics, Jonathan Knudsen, éd. O'Reilly
 * Java In A Nutshell, David Flanagan, éd. O'Reilly
 * Java Virtual Machine, Jon Meyer & Troy Downing, éd. O'Reilly

## Install

  * [Java JRE Download](https://www.java.com/en/download/manual.jsp).

On Ubuntu, to install jre:
```bash
apt-get install -y default-jre
```

MacOS-X provides a full JDK. Look for current version with:
```bash
ls -l /System/Library/Frameworks/JavaVM.framework/Versions
```
For JRE in MacOS-X, go to `System Preferences -> Java`.

## Running

### javac (compiling)

To a compile a single java file:
```bash
javac MyClass.java
```

To compile several java files:
```bash
javac MyClass1.java MyClass2.java ...
```

To compile using a file listing java files
```bash
javac @myjavafiles
```
Inside @myjavafiles: list of java files separated by blanks or line breaks.

CLASS PATH:
```bash
javac -classpath ...
```
OR
```bash
export CLASSPATH=...
javac ...
```
The jar files must be listed explicitly.

Setting destination directory for .class files:
```bash
javac -d output_dir *.java
```

Forcing encoding of .java files to UTF-8:
```bash
javac -encoding utf8 *.java
```

Generates all debugging information:
```bash
javac -g ...
```
It's also possible to specify what debug information to embed:
```bash
javac -g:vars,lines,source ...
```

To get javac version:
```bash
javac -version
```

Used Compiler version
The compiler version used to compile a Java class is written inside the class file, and encoded as major.minor number.
See <https://en.wikipedia.org/wiki/Java_class_file> for explanations.
Major number 52 corresponds to J2SE 1.8. See `javap` to major and minor numbers of a class file.

### javacc

[JavaCC](http://javacc.java.net/), Java Compiler Compiler, is a parser/scanner generator.

MacOS-X: exists in MacPorts.

### javap (disassembling)

`javap` is the Java disassembler.

Display lines and local variables tables:
```bash
javap -l MyClass
```

To get the major.minor number of a class file, one need only to disassemble it:
```bash
javap -verbose MyClass.class
```

### jar (creating and inspecting jar files)

To view the content of a jar file:
```bash
jar -tf jar_file
```

### java (running)

To run a class:
```bash
java -cp <class_directory> MyClass # without the .class suffix.
java MyClass # if in inside the class directory.
```

To run a program from a jar file:
```bash
java -jar my.jar
```

To get java version:
```bash
java -version
```

Run a Uber-jar (self executable JAR) in UTF-8 mode on Windows:
```bash
java -Dfile.encoding=UTF8 -jar my.jar
```

To get default values (including default memory sizes):
```bash
java -XX:+PrintFlagsFinal -version
```
Modified values are shown with `:=` instead of `=`.

Setting heap size (-Xms for initial size and -Xmx for the maximum):
```bash
java -Xms1024m -Xmx2048m
```

Setting thread stack size:
```bash
java -Xss1024k
```

`java.library.path` is the path where to find native libraries.

Default value of system property `java.library.path` on MacOS-X:
	/Users/pierrick/Library/Java/Extensions:/Library/Java/Extensions:/Network/Library/Java/Extensions:/System/Library/Java/Extensions:/usr/lib/java:.

### Beanshell

Beanshell is a Java interpreter.

See [official site](http://www.beanshell.org/).

To install as an extension place the `bsh.jar` file in your `$JAVA_HOME/jre/lib/ext` folder. For *MacOS-X* users, place the `bsh.jar` in either `/Library/Java/Extensions` for all users, or inside `~/Library/Java/Extensions` for individual users.

You can also add the *BeanShell* jar to your classpath like this:

	* unix:     `export CLASSPATH=$CLASSPATH:bsh-xx.jar`.
	* windows:  `set classpath %classpath%;bsh-xx.jar`.

To run the graphical desktop:
```bash
java bsh.Console
```

To run as text-only on the command line:
```bash
java bsh.Interpreter
```

To run a script file:
```bash
java bsh.Interpreter filename [ args ]
```

### javadoc

 * [How to Write Doc Comments for the Javadoc Tool](http://www.oracle.com/technetwork/articles/java/index-137868.html).

Documenting a method:
```java
/**
 * Returns an Image object that can then be painted on the screen. 
 * The url argument must specify an absolute {@link URL}. The name
 * argument is a specifier that is relative to the url argument. 
 * <p>
 * This method always returns immediately, whether or not the 
 * image exists. When this applet attempts to draw the image on
 * the screen, the data will be loaded. The graphics primitives 
 * that draw the image will incrementally paint on the screen. 
 *
 * @param  url  an absolute URL giving the base location of the image
 * @param  name the location of the image, relative to the url argument
 * @return      the image at the specified URL
 * @see         Image
 */
public Image getImage(URL url, String name) {
	try {
		return getImage(new URL(url, name));
	} catch (MalformedURLException e) {
		return null;
	}
}
```

## Deployment

 * [Bringing your Java Application to Mac OS X Part Three](https://www.oracle.com/technical-resources/articles/javase/javatomac3.html).

## Types, variables and constants

### null

Setting a variable to `null`:
```java
MyClass my_obj = null;
```

Testing if null:
```java
if (my_obj == null)
	// ...
```

### Constant

Use the `final` keyword:
```java
final int N = 10;
```

### int & long

Constant value declaration:
```java
2; // Integer
2L; // Long
```

Convert an int to an hex string:
```java
int i;
String hex = java.lang.Integer.toHexString(i);
```

Convert a string to an int:
```java
int aInt = Integer.parseInt(aString);
```

Create an `Integer` instance:
```java
Integer i = Integer.valueOf(10);
Integer j = Integer.valueOf("30");
```

### float & double

Constant value declaration:
```java
2.0f; // Float
2f; // Float
2.0d; // Double
2d; // Double
```

Biggest (maximum) positive value:
```java
Double.MAX_VALUE;
```

Smallest positive value:
```java
Double.MIN_VALUE;
```

NaN (Not a Number):
```java
Double.NaN;
```

### Strings

 * [Format String Syntax](https://docs.oracle.com/javase/7/docs/api/java/util/Formatter.html#syntax).

Test equality of strings:
```java
if (s1.equals(s2)) {
    // ...
}
```

Test if empty:
```java
s.isEmpty();
```

Transforming into a float or int:
```java
float f = Float.valueOf(s.trim()).floatValue();
```

Set in lowercase:
```java
s2 = s.toLowerCase();
```

Get a substring:
```java
s2 = s.substring(1); // from second char to end
s3 = s.substring(0,4); // from first char to 4th char
```

Replace characters:
```java
s.replace('o'/*old char*/, 'n' /*new char*/);
```

Get length of a string:
```java
s.length();
```

Test end of a string:
```java
s.endsWith(".cpp");
```

Test start of a string:
```java
s.startsWith("MyPrefix");
```

Join:
```java
import org.apache.commons.lang.StringUtils;
StringUtils.join(my_array, ",");
```

Split:
```java
String[] array = mystring.split(":");
```

Create a string with a repeated character:
```java
char[] c = new char[10];
java.util.Arrays.fill(c, 'X');
String s = new String(c);
```

Format (sprintf equivalent):
```java
String.format("%4d", 0.12345);
```
See [Format String Syntax](https://docs.oracle.com/javase/7/docs/api/java/util/Formatter.html#syntax).

StringBuilder VS StringBuffer:
StringBuilder has the same capabilities as StringBuffer. The main difference is
StringBuffer is thread safe, but StringBuilder is not good at multi-threading.
If your program is a single thread, then use StringBuilder, because it is
faster. If multiple threads require access to the same dynamic string
information, use class StringBuffer in your code.

### Array

Creating an array:
```java
String[] str_array = new String[5];
int[] anArray = {1, 2, 3};
```

Getting size of an array:
```java
int size = anArray.length;
```

Copy an array:
```java
System.arraycopy(a, 0, b, 0, a.length);
```

Search inside an array:
```java
import java.util.Arrays;
Arrays.sort(anArray);
if (Arrays.binarySearch(anArray, myobject) < 0)
	// not found
```

Find type of the element of an array:
```java
if (x.getClass().getComponentType() == Double.TYPE) {
	// ...
}
```

Using apache library:
```java
import org.apache.commons.lang3.ArrayUtils;
if (ArrayUtils.contains(my_array, my_value))
	// ...
```

Convert to a list:
```java
import java.util.Arrays;
String[] myarray = new String[3];
java.util.List mylist = Arrays.asList(myarray);
```

Foreach style loop:
```java
for (String s: myarray) {
	// do something
}
```

### Enum

Enum declaration:
```java
public enum Day {
	SUNDAY, MONDAY, TUESDAY, WEDNESDAY, 
		THURSDAY, FRIDAY, SATURDAY 
		}
```

Getting number associated with enum value:
```java
int i = Day.MONDAY.ordinal();
```

Getting the name:
```java
String s = Day.MONDAY.name();
// or
String s = Day.MONDAY.toString();
```

Getting an array of all enums:
```java
Day[] days = Day.class.getEnumConstants();
int nbdays = days.length();
```

Enum class with static member:
```java
enum Color {
	RED, GREEN, BLUE;
	static final Map<String,Color> colorMap = new HashMap<String,Color>();
	static {
		for (Color c : Color.values())
		colorMap.put(c.toString(), c);
	} 
}
```

Enum class with instance member:
```java
enum Coin {
	PENNY(1), NICKEL(5), DIME(10), QUARTER(25);
	Coin(int value) { this.value = value; }
	private final int value;
	public int value() { return value; }
}
```

### Date

`java.util.Date` seems to be *deprecated*. It has been replaced by `Calendar`.

```java
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;

// parse a date from a string 
DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
try {
	Date today = df.parse("20/12/2005");           
}
catch (ParseException e) { 
}

// write a date into a string
DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
String s = df.format(today);
```

### LocalDate

Create a local date:
```java
import java.time.LocalDate;
LocalDate my_date = LocalDate.of(2017, 10, 11);
```

### LocalTime

Create a time object:
```java
import java.time.LocalTime;
LocalTime my_time = LocalTime.of(14, 23, 56);
```

### ZonedDateTime

Create an instance from a LocalDate instance:
```java
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZonedDateTime;
import java.time.ZoneId;

LocalDate my_date = LocalDate.of(2017, 10, 11);
LocalTime my_time = LocalTime.of(14, 23, 56);
ZoneId zoneid = ZoneId.of("Europe/Paris");
ZonedDateTime my_datetime = ZonedDateTime.of(my_date, my_time, zoneid)
```

## OOP

### Introspection

Test if a class S is a subclass of class C:
```java
if (C.class.isAssignableFrom(S.class))
	/*...*/;
```

Test if an instance isA:
```java
C.class.isInstance(obj);
obj1.getClass().isInstance(obj);
```

Testing if an object is an instance of a class or superclass or if it implements an interface:
```java
if (obj instanceof MyInterface) {
}
```

This test works with a class object:
```java
public static boolean implementsInterface(Object object, Class interf) {
	return interf.isInstance(object);
}
```

It's possible to initialize an instance member from within the class (i.e. outside the constructor's definition):
```java
class MyClass {
	public int instance_member = 5;
	public MyClass() { 
		// this.instance_member is already initialized to 5
	 
		// do something...
	}
}
```

Getting the class object of an instance:
```java
java.lang.Class cl1 = my_object.getClass();
java.lang.Class cl2 = new MyClass().getlass();
```

Getting a Class instance of from an instance of class:
```java
obj.getClass();
```

Getting a Class instance from a static class name:
```java
MyClass.class;
```

Getting a Class instance from class name (as a string):
```java
Class cl = Class.forName("javax.swing.JList");
```

### Constructors

```java
class MyClass {
	public MyClass() {}
}
```

If no constructor is defined, a default constructor is created

If the constructor of the mother class is not called on the first line of the constructor, then the default constructor of the superclass is called: `super()`.

### Abstract

Abstract classes can declare abstract methods:
```java
abstract class MyClass {

	abstract void myMethod();
}
```

### Inner classes

 * [Java - Inner classes](https://www.tutorialspoint.com/java/java_innerclasses.htm).

You can define a class inside another class:
```java
class MyClass {
	String s = "Coucou";
	private class MyInnerClass {
		void myMethod() {
			System.out.println(s); // Accessing `s` member of inner class.
			if (MyClass.this.getSomeValue() == 10) // Accessing enclosing instance from an inner class.
				doSomething()
		}
	}
}
```
This inner class has access to members of its outer class.

An inner class can also be declared static, in which case it can be accessed without an outer class instance. Also a static inner class will not have access to the outer class members.
```java
class MyClass {
	static class MyInnerClass {
		void myMethod() {
			System.out.println("Coucou");
		}
	}
	static void main(String[] args) {
		MyInnerClass c = new MyInnerClass();
		c.myMethod();
	}
}
```

You can also define a class localy inside a method:
```java
class MyClass {
	public void myMethod() {
		class MyInnerClass {
			public void myInnerMethod() {
			}
		}
	}
}
```

You can define a class within the body of a method without naming it (anonymous inner class).
```java
class MyClass {
	public void somefunc() {
		(new SuperClass(myargs,...) { void newfunc() {} }).call();
	}
}
```

An interface can be used instead of a superclass. Arguments list is empty. The anonymous class explicitly extends the Object class.
```java
class MyClass {
	public void somefunc() {
		(new MyInterfance() { void newfunc() {} }).call();
	}
}
```

## Statements

### if / then / else

```java
if (a > 10)
	// ...
else if (a > 5)
	// ...
else
	// ...
```


### while

```java
while (a > 1) {
	do_something();
}
```

### do / while

```java
do {
	do_something();
} while (a > 1);
```

### for

Simple loop on an integer:
```java
s = 0;
for (int i = 0 ; i < 10 ; ++i)
	s += i;
```

In a `while`, `do/while` or `for` loop, it is possible to exit the loop or go to the next iteration with `break` and `continue`:
```java
for (int i = 0 ; i < 10 ; ++i) {

	if (my_function(i)) {
		i += 2;
		continue;
	}

	if (my_other_function(i))
		break;

	do_something(i);
}
```

For-each loop with an array:
```java
for (String s: myarray)
	System.out.println(s);
```

For-each loop With a map:
```java
for(java.util.Map.Entry<KeyClass, ValueClass> e: mymap.entrySet()) {
	KeyClass key = e.getKey();
	ValueClass value = e.getValue();
}
```

### switch

With an integer:
```java
switch(i) {
	 case 1: /*...*/ break;
	 case 2: /*...*/ break;
	 default: /*...*/
}
```

With an enumerate:
```java
enum MyEnumType { GREEN, BLUE, RED, BLACK, WHITE }
switch(e) {
	case GREEN: /*...*/ break;
	case RED: /*...*/ break;
}
```

Multiple cases for one action:
```java
switch(i) {
	case 1: case 2: case 3:
	case 4:
		j = 1;
		break;
}
```


### final

A `final` class cannot be derived.
A `final` method cannot be overwritten in a derived class.
`final` applied to a class attribute or a local variable means that it cannot be changed (i.e.: it is a constant).

## main method

```java
public class MyClass {
	public static void main(String[] args) {
	}
}
```

## import

The import directive allows to shorten namespace when referencing a class.
For instance instead of writing:
```java
javax.swing.JDialog dialog = new javax.swing.JDialog();
```
You write :
```java
import javax.swing.JDialog;
class Toto {
	private JDialog dialog = new JDialog();
}
```

## Operators

Operators            | Precedence
-------------------- | ---------------------------
postfix              | `expr++` `expr--`
unary                | `++expr` `--expr` `+expr` `-expr` `~` `!`
multiplicative       | `*` `/` `%`
additive             | `+` `-`
shift                | `<<` `>>` `>>>`
relational           | `<` `>` `<=` `>=` `instanceof`
equality             | `==` `!=`
bitwise AND          | `&`
bitwise exclusive OR | `^`
bitwise inclusive OR | `|`
logical AND          | `&&`
logical OR           | `||`
ternary              | `? :`
assignment           | `=` `+=` `-=` `*=` `/=` `%=` `&=` `^=` `|=` `<<=` `>>=` `>>>=`

## Casting

C type cast:
```java
Object o = a.getObject();
String s = (String)o;
```

## Methods

To define default values for a method, one must use method overloading:
```java
// Plain method
void foo(int a, SomeClass obj) {
	if (obj == null)
		obj = new SomeClass();
	// ...
}

// Method with no second parameters
void foo(int a) {
	foo(a, null);
}

// Method with no parameters
void foo() {
	foo(2, null);
}
```

## Garbage collector & References

Abstract reference class:
```java
java.lang.ref.Reference<MyClass> ref;
```

Getting referenced object:
```java
MyClass obj = ref.get();
```

Weak reference:
```java
java.lang.ref.Reference<MyClass> ref = new java.lang.ref.WeakReference<MyClass(my_instance);
```

Garbage collections:
The Garbage Collector is able to detect isolated cycles (group of objects that are linked together, but that aren't references by any other object) and remove them.
The Garbage Collector is able to move objects in memory in order to defragment the heap, and thus make place for creating big objects. ==> The references are ids generated separately from the address in memory (reference != pointer).

## System properties

How to get system properties:
```java
java.util.Properties props = System.getProperties();
String path = props.getProperty("java.library.path");
```

How to set a system property:
```java
java.util.Properties props = System.getProperties();
props.setProperty("java.library.path", "/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rJava/jri");
```

## Assertions

```java
assert a == b : "a is different from b !";
```

The message can be any object that has the toString() method defined:
```java
assert o1.equals(o2) : some_object;
```

Assertion are disabled by default at runtime.
In order to enable or disable assertions when running a program, use the -ea and -da options.
For instance if you want to enable all assertions (excepting system assertions for which to special options are defined: -esa and -dsa):
```bash
java -ea ... MyClass
```
One can specify a package in which to enable exceptions:
```bash
java -ea:com.my.name.space.to.my.package ... MyClass
```

## Threading

### Thread class

Defining a new thread class:
```java
public class HelloRunnable implements Runnable {
	public void run() {
		System.out.println("Hello from a thread!");
	}
}
```

Running a thread instance:
```java
(new Thread(new HelloRunnable())).start();
```

It's also possible to extend the `Thread` class instead of implementing the `Runnable` interface. TODO What is the difference ?

### Synchronized method

```java
public synchronized void myMethod() {
	++this.n;
}
```

### Semaphores

```java
class MyClass  {
	private final java.util.concurrent.Semaphore sem = new java.util.concurrent.Semaphore(3);

	public void myMethod() throws InterruptedException {
		sem.acquire();
	}
}
```

## File system

Create a File instance:
```java
java.io.File file = new java.io.File("/my/path/to/my/file.txt");
java.io.File file = new java.io.File("/my/path/to/my", "file.txt");
java.io.File dir = new java.io.File("/my/path/to/my");                                             
java.io.File file = new java.io.File(dir, "file.txt");
```

Tests if a file exists:
```java
file.exists();
```

Make directory:
```java
file.mkdirs();
```

File path character separator:
```java
char separator = java.io.File.separatorChar;
String separator = java.io.File.separator;
```

Delete a file:
```java
new java.io.File("/some/file.txt").delete();
```

Get pathname:
```java
String path = file.getAbsolutePath();
```

Get current directory:
```java
java.io.File curdir = new java.io.File(".");
```

List files inside a directory:
```java
java.io.File dir = new java.io.File(".");
File[] files = dir.listFiles();
```

## Resources

Get the URL of a resource file:
```java
java.net.URL url = Thread.currentThread().getContextClassLoader().getResource("metfrag-chemspider-output.sdf");
```

Open a resource file as a stream:
```java
java.io.InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream("process.json");
```

## I/O

Printing:
```java
java.lang.System.out.println("Coucou !");
java.lang.System.err.println("Coucou !");
```

Open a stream on a file:
```java
new java.io.FileInputStream(new java.io.File("myfile.txt"));
```

Reading a file line by line:
```java
java.io.BufferedReader br = new BufferedReader(new java.io.FileReader(new File(file)));
while ((line = br.readLine()) != null) {
}
```

Writing into a file:
```java
java.io.BufferedWriter output = new java.io.BufferedWriter(new java.io.FileWriter(file));
output.write(text);
output.close();
```

Write into a string:
```java
java.io.ByteArrayOutputStream os = new java.io.ByteArrayOutputStream();
// Write on output stream ...
String s = os.toString();
```

Loading a key=value file into a dictionnary:
```java
import java.util.Properties;
Properties prop = new Properties();
prop.load(my_stream_or_my_reader);
```

## Serialization

The class to serialize must implements the empty interface java.io.Serializable:
```java
class MyClass implements java.io.Serializable {
}
```

To write a serializable object to a stream:
```java
File f = new File("...");
ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(f));
oos.writeObject(o);
oos.close();
```
	
To read a serializable object from a stream:
```java
ObjectInputStream ois = new ObjectInputStream(new FileInputStream(f));
Object copy = ois.readObject();
ois.close();
```

## Environment variables

Getting an environment variable:
```java
import java.lang.System;
String myvar = System.getenv("MYVAR"); // deprecated
String myvar = System.getProperty("MYVAR");
```

Getting all env vars:
```java
import java.lang.System;
import java.util.Map;
Map<String, String> env = System.getenv();
```

Setting an environment variable
```java
System.setProperty(String key, String value);
```

## Maths

Power:
```java
z = Math.pow(x, y);
```

Absolute value:
```java
k = Math.abs(i - j);
```

Get minimum and maximum:
```java
minimum = Math.min(12, 45);
maximum = Math.max(12, 45);
```

Random:
```java
java.util.Random rand = new java.util.Random();
double x = rand.nextDouble();
int i = rand.nextInt();
int i = rand.nextInt(100);
boolean b = rand.nextBoolean();
```

## Collections

Testing emptiness:
```java
c.isEmpty();
```

### Set

Creating a new set:
```java
Set<E> c = new Set<E>();
```

### List

Creating a list from a single basic type:
```java
java.util.List my_list_of_ints = java.util.List.of(1);
java.util.List my_list_of_longs = java.util.List.of(1L);
java.util.List my_list_of_floats = java.util.List.of(1f);
java.util.List my_list_of_doubles = java.util.List.of(1d);
```

Creating a linked list:
```java
import java.util.List; // is abstract
import java.util.LinkedList;
List my_list = new LinkedList();
```

Add object:
```java
my_list.add("a string");
```

Test if an element exists with "equals" method.
Be careful, it returns true if the element past is null and null is inside the list.
```java
my_list.contains("my string");
```

Transform into an array:
```java
String[] str_array = (String[])my_list.toArray(new String[1] /* gives the type to return */);
```

Getting the first element:
```java
Object first = my_list.iterator().next();
Object first = my_linked_list.getFirst(); // on a LinkedList
```

Generics ArrayList:
```java
import java.util.ArrayList;
ArrayList<String> list = new ArrayList<String>();
list.add("hello");
Object[] array = list.toArray(); // returns an Object[] and not a String[], so what's the interest of using a Generics class ?
int size = list.size();
String s = list.get(3); // get element at index i (access in constant time)
```

Iterate over an ArrayList:
```java
java.util.ArrayList<String> list = new java.util.ArrayList<String>();
java.util.Iterator<String> i = list.iterator();
while (i.hasNext())
	String element = i.next();
```

Iterate with a for loop:
```java
for (String s: names) {
}
```

### Map

```java
private java.util.Map<String, String> params = new java.util.HashMap<String, String>();
```

Testing if a key exists:
```java
if (map.containsKey(mykey)) {
	// ...
}
```

Looping on elements:
```java
Iterator i = mymap.entrySet().iterator();
while (i.hasNext()) {
	Map.Entry mapEntry = (Map.Entry)i.next();
	System.out.println("The key is: " + mapEntry.getKey() + ",value is :"+mapEntry.getValue());
}
```
or:
```java
for (Map.Entry<String, String> entry : map.entrySet())
	System.out.println("Key : " + entry.getKey() + " Value : " + entry.getValue());
```

The `HashMap` class handles keys by value, and values by strong references, using a hash table.
The `TreeMap` class handles keys by value and values by strong references, using a tree.
The `WeakHashMap` class handles keys by weak references, and values by strong references. 

Put a new couple key/value inside the map:
```java
mymap.put(mykey, myvalue);
```

Bidirectional map:
```java
com.google.common.collect.BiMap<Integer, String> map; 
String v = map.get(k);
Integer k = map.inverse().get(v);
```

### Stack

```java
import java.util.Stack;

// create a stack
Stack<String> s = new Stack<String>();

// push
Object my_pushed_object = s.push(object);

// pop
Object my_popped_object = s.pop();

// peek
Object top_object = s.peek();

// empty
if (s.empty())
	do_something();

// search
if (s.search(some_object) > 3) // returns the distance from the top of the stack, or -1.
	do_something();
```

### Vector

```java
// new vector
java.util.Vector v = new Vector();

// add
v.add(some_object);

// iterator
java.util.Iterator i = v.iterator();
while(i.hasNext()) {
	do_something(i.next());
}
```
## Use of generics

 * [Generics in the Java Programming Language](http://www.oracle.com/technetwork/java/javase/generics-tutorial-159168.pdf).

From JDK 1.5 all containers have been replaced with generics:
```java
Stack trainStack = new Stack();
```
is replaced with
```java
Stack<String> trainStack = new Stack<String>();
```

Where an old container is used in place of a new generic container, you should encounter the following warning message:
```
warning: [unchecked] unchecked call to push(E) as a member of the raw type java.util.Stack
```

Wildcard:
```java
void printCollection(Collection<?> c) {
	for (Object e : c) // Any object is at least of type Object
		System.out.println(e);
}
```
The collection can't be modified since we don't know the exact type contained (`Collection<String>` or `Collection<Integer>`, or ...)

Bounded wilcard:
```java
public void drawAll(List<? extends Shape> shapes) { /*...*/ }
```
It's forbidden to modify the list instance, since we don't know the exact type of the list (`List<Rectangle>` or `List<Circle>` ?).

### Generic method

Wildcard should be used whenever there's only one generic parameter in the method. And generic method reserved when a generic type is used at least twice (in return value or parameters).

Sample method:
```java
static <T> void fromArrayToCollection(T[] a, Collection<T> c) {
	for(T o:a)
		c.add(o); // correct
}
```

Bounded type in generic method:
```java
interface Collection<E> {
	public <T extends E> mergeTwoColl(Collection<T> a, Collection<T> b);
}
```

Use of wildcards in generic method:
```java
class Collections {
	public static <T> void copy(List<T> dest, List<? extends T> src) { /*...*/ }
}
```
which could have been written
```java
class Collections {
	public static <T, S extends T> void copy(List<T> dest, List<S> src) { /*...*/ }
}
```

### Using generics with legacy code

```java
List lst = new List();
String s = "toto";
lst.add(s);
java.util.List<String> str_lst = lst; // doesn't raise an error but only a warning from the compiler. However it could generate an exception an runtime.
```

This works because, generics are only used by the compiler. All generics markers are thrown away by compiler when generated compiled code. So `str_lst` is in fact a legacy List.

## Cloneable

`Cloneable` is a particular interface.
It doesn't declare any method. The clone method is defined inside `Object` class.
What it does is the following:
when a class implements Cloneable, then the behaviour of the `Object.clone()` method changes.
When `Cloneable` isn't implemented, `Object.clone()` throws a `CloneNotSupportedException`.
If `Cloneable` is implemented, `Object.clone()` returns a field-by-field copy of the object. References are copied as is (i.e.: the same object is referenced by the clone).

`Object.clone()` is protected, when overriding it, you should let it protected if the class you're writing is designed to be inherited.
Otherwise, make the `clone()` method public.

Thanks to the Generics (Java 1.5 and higher) it's possible to subclass the return type of a method when overriding it.
This is a good thing to do for `clone()` method, since we can this way directly return an object of the right type.

Example:
```java
class MyClass implements Cloneable {

	private SomeOtherClass some_member;

	@Override public MyClass clone() {
		try {
			MyClass obj = (MyClass)super.clone();
			obj.some_member = this.some_member.clone();
			return obj;
		} catch (CloneNotSupportedException e) { /* can't happen */	}
	}
}
```

## Exceptions

Throws:
```java
public void foo() throws MyException1, MyException2;
```

Try/catch:
```java
try {
	// ...
} catch (MyException1 e) {
} catch (MyException2 e) {
}
```

Catch multiple exceptions:
```java
try {
	// ...
} catch (IOException | SQLException ex) {
}
```

Creating a new exception:
```java
public class MyException extends java.lang.Exception {
	public MyException(String msg) {
		super(msg);
	}

	/* one can overwrite toString() method */
	public String toString() {
		return "Exception : " + this.getMessage() + " !";
	}
}
```

Throwing an exception when a parameter is not valid:
```java
void myMethod(int a, Object o) throws IllegalArgumentException {
	if (a < 0)
		throw new IllegalArgumentException("Parameter a must be positive or null.");
	if (o == null)
		throw new IllegalArgumentException("Parameter o can not be null.");
}
```

The `finally` directive executes code just after a try/catch block or before returning from the function.
```java
MyObject foo() {
	MyObject o = null;
	try {
		// ...
	}
	catch (MyException e) {
		// do something
		return null; // finally clause is executed just before returning
	}

	// finally clause executed just after try statement
	finally {
		// do this in all cases (exception thrown or not)
	}

	// do something

	return o; 
}
```

## Encoding

Set default encoding:
```bash
java -Dfile.encoding=UTF8 ...
```
Useful on Windows where default encoding is CP1252.

Also when loading a resource bundle, it is essencial to set the encoding directly, otherwise on Windows it will be loaded in CP1252 by default event with `-Dfile.encoding=UTF8` flag:
```java
java.io.InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream("messages.properties");
java.io.InputStreamReader isr = new java.io.InputStreamReader(in, "UTF-8");
this.bundle = new java.util.PropertyResourceBundle(isr);
```

## Error messages

### `java.lang.UnsupportedClassVersionError: TestArray : Unsupported major.minor version 51.0`

It means that you run your program with the version of java different from the one you used to compile it.

### `BoxLayout can't be shared`

This error occurs on this.add(<some_component>) call, for a `JDialog` component (or any component derived from `JDialog`) ):
```java
this.setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.Y_AXIS));
this.add(some_component);
```
This is because the component passed to BoxLayout must be the same on which we call setLayout.
This is not the case in the code above, because the method setLayout calls in fact the `ContentPane` hidden inside the current `JDialog` component.
```java
this.setLayout(new javax.swing.BoxLayout(getContentPane(), javax.swing.BoxLayout.Y_AXIS));
```
This error occurs for components : `JDialog`, `JFrame`, ...

### Error with inner classes:

```
[junit] Testcase: initializationError(TestParsing$1):	Caused an ERROR
[junit] Test class should have exactly one public constructor
[junit] java.lang.Exception: Test class should have exactly one public constructor
[junit] 	at java.lang.reflect.Constructor.newInstance(Constructor.java:513)
```

The solution is to exclude all inner classes class files from JUnit tests. In Ant write:
```xml
<junit>
...
<batchtest>
    <fileset dir="${build.dir}" includes="*.class" excludes="*$*.class"/>
</batchtest>
...
</junit>
```

## Properties

 * [Properties File Format](https://docs.oracle.com/cd/E23095_01/Platform.93/ATGProgGuide/html/s0204propertiesfileformat01.html).
 * [Properties](https://docs.oracle.com/javase/tutorial/essential/environment/properties.html).
 * [Class Properties](https://docs.oracle.com/javase/7/docs/api/java/util/Properties.html).

Comment in a properties files:
```jproperties
# My comment
```

A value:
```jproperties
my.prop = My Value
```

A multi-lines value:
```jproperties
my.prop = My Value \
          on multiple \
          lines
```

Load a properties file:
```java
java.util.Properties prop = new java.util.Properties();
java.io.Reader reader = new java.io.FileReader(new File("/my/file/properties/to/read.properties"));
prop.load(reader);
```

Get a value:
```java
String s = prop.getProperty("mykey"); // Returns null if absent
String s = prop.getProperty("mykey", "My default value");
```

Save properties to a file:
```java
java.io.Writer writer = new java.io.FileWriter(new File("/my/file/properties/to/write.properties"));
prop.store(writer, "A comment to write at the beginning of the file.");
```

An XML format is also possible:
```java
java.io.OutputStream out = new java.io.FileOutputStream(new File("/my/file/properties.xml"));
prop.storeToXML(out, "A comment to write at the beginning of the file.");
// Then to load:
java.util.Properties prop2 = new java.util.Properties();
java.io.InputStream in = new java.io.FileInputStream(new File("/my/file/properties.xml"));
prop2.loadFromXML(in);
```

## AWT

Abstract Window Toolkit.

Running an AWT app in some window managers (e.g.: xmonad) may result in a blank window. Solution is to export the following env var: `_JAVA_AWT_WM_NONREPARENTING=1`.

### Component

Specify preferred size:
```java
this.setPreferredSize(new java.awt.Dimension(width, height));
```

Repaint component:
```java
this.repaint();
```

Define custom paint:
```java
@Override
public void paintComponent(java.awt.Graphics g) {
}
```

### BorderLayout

A layout that divides the space in 5 spaces : north, south, east, west and center.

```java
class MyPanel extends javax.swing.JPanel {
	MyPanel() {
		super(new java.awt.BorderLayout());
		this.add(new java.awt.Button("FIRST"), java.awt.BorderLayout.NORTH);
		this.add(new java.awt.Button("SECOND"), java.awt.BorderLayout.CENTER);
	}
}
```

### FlowLayout

Layout as a line of text, with justification to the left, to the right or centered.

### GridLayout

A fixed grid layout, with same size for all cells.

```java
class MyPanel extends javax.swing.JPanel {
	MyPanel() {
		super(new java.awt.GridLayout(1/*rows*/, 2/*cols*/));
		this.add(new java.awt.Button("First"));
		this.add(new java.awt.Button("Second"));
	}
}
```

### GridBagLayout

A flexible grid layout.

```java
class MyPanel extends javax.swing.JPanel {
	MyPanel() {
		super();

		// Set layout
		java.awt.GridBagLayout gridBag = new java.awt.GridBagLayout();
		this.setLayout(gridBag);

		// Prepare constraint
		java.awt.GridBagConstraints c = new java.awt.GridBagConstraints();
		c.gridwidth = 2; // Number of cells occupied horizontally by component
		c.gridy = 1; // Put component on the second line.

		// Add button
		java.awt.Button button = new java.awt.Button(name);
		gridBag.setConstraints(button, c);
		this.add(button);
	}
}
```

## Swing

 * [How to Make Dialogs](https://docs.oracle.com/javase/tutorial/uiswing/components/dialog.html)
 * [How to Use Modality in Dialogs](https://docs.oracle.com/javase/tutorial/uiswing/misc/modality.html).
 * [Creating Custom Components](https://www.oreilly.com/library/view/learning-java/1565927184/ch15s06.html).
 * [Adding Cut, Copy and Paste (CCP)](https://docs.oracle.com/javase/tutorial/uiswing/dnd/cutpaste.html).

GUI widget toolkit, successor of AWT.
Swing is not thread safe, see [Swing's Threading Policy](https://docs.oracle.com/javase/7/docs/api/javax/swing/package-summary.html#threading).

Now (2020) being replaced by JavaFX (thread safe).

### UIManager

Change default font size:
```java
int delta = +4; // increase all font sizes by 4 points.
java.util.Enumeration keys = javax.swing.UIManager.getDefaults().keys();
while (keys.hasMoreElements()) {
	Object key = keys.nextElement();
	Object obj = javax.swing.UIManager.get(key);
	if (obj instanceof java.awt.Font) {
		java.awt.Font font = (java.awt.Font)obj;
		font = font.deriveFont(font.getSize2D() + (float)delta);
		javax.swing.UIManager.put(key, font);
	}
}
```

### JComponent

Draw border:
```java
myComponent.setBorder(javax.swing.BorderFactory.createLineBorder(java.awt.Color.black));
```

Paint background:
```java
myComponent.setBackground(java.awt.Color.blue);
```

### JWindow

A bare window: no border, no title bar.

### JFrame

A window with border, title bar, minimize and maximize buttons.

### JPanel

A component used to group other components together.

```java
javax.swing.JPanel mypanel = new javax.swing.JPanel(); // Create a panel with default layout manager.
mypane.add(); // Add component.
```

Attention, default layout is `FlowLayout`, which does not resize children components when parent component is resized.
Better is to use `BorderLayout`:
```java
new javax.swing.JPanel(new java.awt.BorderLayout());
```


### JOptionPane

A modal `JDialog`. More precisely: A `JOptionPane` object is a container that creates a `JDialog` and adds itself to it.
It is possible to choose a `JInternalFrame` instead of a `JDialog` as the target component.

Error message:
```java
javax.swing.JOptionPane.showMessageDialog(null, "My error message", "Error", javax.swing.JOptionPane.ERROR_MESSAGE);
```

Warning message with choice:
```java
Object[] options = { "yes", "no" };
int choice = javax.swing.JOptionPane.showOptionDialog(null, "My message", "Warning", javax.swing.JOptionPane.DEFAULT_OPTION, javax.swing.JOptionPane.WARNING_MESSAGE, null, options, options[0]);
```

### JFileChooser

Open a file chooser for saving:
```java
	javax.swing.JFileChooser fileChooser = new javax.swing.JFileChooser();
	javax.swing.filechooser.FileNameExtensionFilter filter = new javax.swing.filechooser.FileNameExtensionFilter("Images", "jpg", "jpeg", "png");
	fileChooser.setFileFilter(filter);
	if (fileChooser.showSaveDialog(myFrame) == javax.swing.JFileChooser.APPROVE_OPTION) {
		java.io.File file = fileChooser.getSelectedFile();
		// ...
	} else
		// CANCEL
```

### JDialog

With `JDialog` you can create modal or non-modal dialogs.

### JScrollPane

 * [How to Use Scroll Panes](https://docs.oracle.com/javase/tutorial/uiswing/components/scrollpane.html).

JScrollPane uses JViewPort to get a partial view of the component to display.

### JSplitPane

 * [JSplitPane](https://docs.oracle.com/javase/7/docs/api/javax/swing/JSplitPane.html).

Put two components inside a split pane, separated by a movable vertical bar:
```java
javax.swing.JSplitPane sp = new javax.swing.JSplitPane(javax.swing.JSplitPane.HORIZONTAL_SPLIT, leftComp, rightComp);
```

### Menus

 * [How to Use Menus](https://docs.oracle.com/javase/tutorial/uiswing/components/menu.html).

#### JMenuBar

Create a menu bar:
```java
javax.swing.JMenuBar menuBar = new javax.swing.JMenuBar();
```

#### JMenu

Create a menu and add it to the bar:
```java
javax.swing.JMenu menu = new javax.swing.JMenu(Msg.getString("help"));
menuBar.add(menu);
```

#### JMenuItem

Create a menu item with shortcut, accelerator and a listener and add it to a menu:
```java
javax.swing.JMenuItem myItem = new javax.swing.JMenuItem("My Item", java.awt.event.KeyEvent.VK_M);
myItem.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_M, java.awt.event.ActionEvent.CTRL_MASK));
myItem.addActionListener(
	new java.awt.event.ActionListener {
		public void actionPerformed(java.awt.event.ActionEvent e) {
			// do something
		}
	}
);
menu.add(myItem);
```

#### JCheckBoxMenuItem

```java
cbMenuItem = new JCheckBoxMenuItem("My check box item");
cbMenuItem.setMnemonic(KeyEvent.VK_C);
menu.add(cbMenuItem);
```

#### JMenuSeparator

Add an horizontal separator:
```java
menu.add(new javax.swing.JSeparator());
```

#### Mnemonics and accelerators

 * [Class KeyEvent](https://docs.oracle.com/javase/8/docs/api/java/awt/event/KeyEvent.html).
	 
Keyboard events:
 * Mnemonics: for navigating inside the menu. Normally an alphanumeric character, the first occurence of this character is underlined on the menu title.
 * Accelerators: for bypassing the menu. The shorcut is displayed on the right of the menu title.

Example of mnemonics:
```java
// When creating a menu item:
new javax.swing.JMenuItem("My menu item", java.awt.event.KeyEvent.VK_M)
// or after menu item creation:
myMenuItem.setMnemonic(KeyEvent.VK_A);
```

Example of accelerator:
```java
myMenuItem.setAccelerator(javax.swing.KeyStroke.getKeyStroke(java.awt.event.KeyEvent.VK_1, java.awt.event.ActionEvent.ALT_MASK));
```

### BoxLayout

This layout aline components in one direction:
	javax.swing.BoxLayout.X_AXIS       horizontally, left to right.
	javax.swing.BoxLayout.Y_AXIS       vertically, top to bottom.
	javax.swing.BoxLayout.LINE_AXIS    as words are displayed, based on `ComponentOrientation` property.
	javax.swing.BoxLayout.PAGE_AXIS    as lines are displayed, based on `ComponentOrientation` property.

```java
class MyPanel extends javax.swing.JPanel {
	MyPanel() {
		super();
		this.setLayout(new javax.swing.BoxLayout(this, javax.swing.BoxLayout.X_AXIS));
		this.add(new JButton("FIRST"));
		this.add(new JButton("SECOND"));
	}
}
```

### JComboBox

 * [How to Use Combo Boxes](https://docs.oracle.com/javase/tutorial/uiswing/components/combobox.html).

### JCheckBox

 * [How to Use Buttons, Check Boxes, and Radio Buttons](https://docs.oracle.com/javase/tutorial/uiswing/components/button.html).

### JRadioButton

  * [How to Use Radio Buttons](https://docs.oracle.com/javase/tutorial/uiswing/components/button.html#radiobutton).

Create a group of two radio buttons with action listeners:
```java
javax.swing.JRadioButton btn1 = new javax.swing.JRadioButton("Button 1");
btn1.setMnemonic(KeyEvent.VK_B);
btn1.setActionCommand("btn1");
btn1.setSelected(true);

javax.swing.JRadioButton btn2 = new javax.swing.JRadioButton("Button 2");
btn2.setMnemonic(KeyEvent.VK_B);
btn2.setActionCommand("btn2");

javax.swing.ButtonGroup group = new javax.swing.ButtonGroup();
group.add(btn1);
group.add(btn2);

btn1.addActionListener(this);
btn2.addActionListener(this);
//...
public void actionPerformed(ActionEvent e) {
	String s = e.getActionCommand();
	// ...
}
```

### JList

A list of selectable items.

```java
javax.swing.JList<String> list = new javax.swing.JList<String>();
```

### JTabbedPane

A multi tabs pane.

```java
javax.swing.JTabbedPane tab = new javax.swing.JTabbedPane(javax.swing.JTabbedPane.TOP);
tab.add(new MyPanel());
int n = this.tab.getTabCount(); // Number of panes.
java.awt.Component x = this.tab.getComponentAt(0); // Get one of the pane.
```

### JTable

A 2D table, with selection by row(s) or column(s).

### JLabel

Create an image label:
```java
new javax.swing.JLabel(new javax.swing.ImageIcon(new java.net.URL("/my/path/to/my/image/file.jpg")));
```

### JTextArea

All text in same font (i.e.: no formatting).

### JTextPane

Can render text with styles, and accept embedded components.

### JEditorPane

Can render plain text, HTML or RTF, and allow editing.

## javax.json

Read a JSON file:
```java
// TODO
```

## i18n

 * [Java Internationalization Support](https://docs.oracle.com/javase/8/docs/technotes/guides/intl/).
 * [A Quick Example](https://docs.oracle.com/javase/tutorial/i18n/intro/quick.html).

## Annotations

 * [Les Annotations de Java 5.0](http://adiguba.developpez.com/tutoriels/java/tiger/annotations/).

## Lambda (Functional programming)

 * [Lambda Expressions](https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html).
 * [Benchmark: How Java 8 Lambdas and Streams Can Make Your Code 5 Times Slower](http://blog.takipi.com/benchmark-how-java-8-lambdas-and-streams-can-make-your-code-5-times-slower/). Wrong if lambda code is well written: see the blog where a correction is made and better times are achieved.
 * [Is mapToDouble() really necessary for summing a List<Double> with Java 8 streams?](https://stackoverflow.com/questions/24421140/is-maptodouble-really-necessary-for-summing-a-listdouble-with-java-8-streams).

Summing a list of double values:
```java
double totalevent = myList.stream().mapToDouble(Double::doubleValue).sum();
```

## Java daemon

 * How to write a [JAVA DAEMON](http://barelyenough.org/blog/2005/03/java-daemon/).

## JVM Version

To get the JVM version in runtime:
```java
String v = System.getProperty("java.version");
```



## UUID

```java
import java.util.UUID;

UUID a = UUID.randomUUID(); // create new UUID
UUID b = UUID.fromString(my_uuid_string); // create UUID object from string representation
String string_uuid = a.toString();
```

## Debugging

### JDB

Java debugger.

Same command line as java:
```bash
jdb -classpath <myclasspath> -sourcepath <pathtosources> ClassName [arguments...]
```

Remote debugging (attach to port):
```bash
jdb -attach 8000 -sourcepath /my/path/to/my/repos/src/main/java
```

Misc:

Keyword             | Description
------------------- | -----------------------------
`!!`                | Execute last command.
`monitor <command>` | Execute command each time the program stops.
monitor             | List monitors.
`unmonitor <index>` | Remove monitor.

Execution:

Keyword             | Description
------------------- | -----------------------------
run                 | Run program.
next                | Step one line (don't step into calls).
cont                | Continue (resume execution).
step up             | Execute and stop when back into caller (i.e.: step out of current function).
stepi               | Execute current instruction.
step                | Execute current line.
resume              | Resume all threads.
suspend             | Suspend all threads.
threads             | List threads.
`thread <id>`       | Set default thread.
threads             | List threads.

Stack:

Keyword             | Description
------------------- | -----------------------------
where               | Print a thread's stack.
up                  | Move up in thread's stack.
down                | Move down in thread's stack.

Breakpoints:

Keyword                     | Description
--------------------------- | -----------------------------
`stop in <class>.<method>`  | Add breakpoint.
`stop at <class>:line`      | Add breakpoint.
`clear`                     | List breakpoints.
`clear <class>.<method>`    | Remove breakpoint.
`clear <class>:line`        | Remove breakpoint.

Information:

Keyword              | Description
-------------------- | -----------------------------
list                 | Print source code.
locals               | Print all local variables.
`print <expression>` |

### Remote debugging

It's possible to launch an application in remote debug mode, and use a debugger to connect remotely to this app.

 1. Compile the app normally in debug mode:
	```java
	javac -g ...
	```

 2. Run the app in remote mode with a specific socket:
	```java
	java -Xdebug -Xrunjdwp:transport=dt_socket,server=y,address=8000,suspend=y -jar test.jar 
	```

	From Java 5.0:
	```java
	java -agentlib:jdwp=transport=dt_socket,server=y,address=8000 org.iforge.aectann.DebugMe
	```

 3. Launch the debugger.

## Profiling

### HPROF

 * [Using the HPROF Profiler](http://www.ibm.com/support/knowledgecenter/SSYKE2_8.0.0/com.ibm.java.aix.80.doc/diag/tools/hprof.html).

```bash
java -Xrunhprof ...
```

To get all options:
```bash
java -Xrunhprof:help
```

### XPROF

```bash
java -Xprof ...
```

### JConsole

```bash
jconsole
```
Needs to attach to running application (PID or remote).

### Visual VM

Needs to attach to running application (PID or remote).

See [Visual VM](https://visualvm.java.net).

## Libraries

### JMF

 * [How to play audio and video files in Java applications](https://buddhimawijeweera.wordpress.com/2011/05/01/how-to-play-audio-and-video-files-in-java-applications/). Uses JMF (Java Media Framework), which is deprecated and does not play mp4.

Java Media Framework. Deprecated.
Can play mpg and avi, but not mp4.

### Oracle JavaFX

 * [JavaFX API overview](https://docs.oracle.com/javase/8/javafx/api/overview-summary.html).
 * [Integrating JavaFX into Swing Applications](https://docs.oracle.com/javafx/2/swing/swing-fx-interoperability.htm).
 * [Integrating JavaFX into Swing Applications](https://docs.oracle.com/javase/8/javafx/interoperability-tutorial/swing-fx-interoperability.htm).
 * [JavaFX Video Player with MediaView](https://coderslegacy.com/java/javafx-mediaview-video-player/). Video player with play/pause/stop buttons.

JavaFX can play mp4.

### CDK

The Chemistry Development Kit (CDK) is a Java bio- and cheminformatics and computational chemistry library.

See `biocheminfo.md`.

### JGraphT

[JGraphT](http://jgrapht.org) is a graph library focused on data structures and algorithms.

### Commons Apache

For computing binomial coefficients, see [CombinatoricsUtils](http://commons.apache.org/proper/commons-math/apidocs/org/apache/commons/math3/util/CombinatoricsUtils.html).


### JUnit4

 * [JUnit 4](https://junit.org/junit4/).

Assertions:
```java
import static org.junit.Assert.*;
assertTrue(a == 2);
```

Testing that an exception is thrown:
```java
@org.junit.Test(expected=IndexOutOfBoundsException.class)
public void testIndexOutOfBoundsException() {
	ArrayList emptyList = new ArrayList();
	Object o = emptyList.get(0);
}
```

Testing equality of particular objects:
```bash
assertTrue("Wrong.", myobj.equals(my_other_obj));
```

### JUnit5

 * [JUnit 5](https://junit.org/junit5/).
 * [JUnit 5 - How to Run Test Methods in Order](https://www.codejava.net/testing/junit-tests-order).

Maven:
```xml
<!-- JUnit5 https://mvnrepository.com/artifact/org.junit.jupiter/junit-jupiter-engine -->
<dependency>
	<groupId>org.junit.jupiter</groupId>
	<artifactId>junit-jupiter-engine</artifactId>
	<version>5.7.0</version>
	<scope>test</scope>
</dependency>

<!-- JUnit Jupiter API https://mvnrepository.com/artifact/org.junit.jupiter/junit-jupiter-api -->
<dependency>
	<groupId>org.junit.jupiter</groupId>
	<artifactId>junit-jupiter-api</artifactId>
	<version>5.7.0</version>
	<scope>test</scope>
</dependency>
```

Run methods in alphabetical order:
```java
@org.junit.jupiter.api.TestMethodOrder(org.junit.jupiter.api.MethodOrderer.MethodName.class)
public class MyTest {
	// ...
}
```

### Customized runner

When a class is annotated with `@RunWith` or extends a class annotated with `@RunWith`, JUnit will invoke the class it references to run the tests in that class instead of the runner built into JUnit.
Under Ant task `junit`, by default, all classes are annotated with `@RunWith`(Enclosed.class), which has the effect of running JUnit on all inner classes of this class.
The class specified by `@RunWith` must extend `org.junit.runner.Runner`.

Usage:
```java
import org.junit.runner.RunWith;
@RunWith(org.junit.internal.runners.JUnit4ClassRunner.class)
class MyTestClass {
}
```

Running from command line with JUnit 4:
```bash
java -cp /usr/share/java/junit.jar org.junit.runner.JUnitCore TestClassName
```
Running from command line with JUnit 3:
```bash
java -cp /usr/share/java/junit.jar junit.textui.TestRunner TestClassName
```

#### Running code before and after test methods

To run code before and after test class creation:
```java
import org.junit.AfterClass;
import org.junit.BeforeClass;

public class MyTestClass {

	@BeforeClass
	public static void runSomeCodeBefore() {
	}

	@AfterClass
	public static void runSomeCodeAfter() {
	}
}
```
Several methods can be defined.

To run code before and after each test method of the class:
```java
import org.junit.After;
import org.junit.Before;

public class MyTestClass {

	@Before
	public void runSomeCodeBefore() {
	}

	@After
	public void runSomeCodeAfter() {
	}
}
```
Several methods can be defined.

### AssertJ

 * [AssertJ](http://joel-costigliola.github.io/assertj/index.html).
 * [AssertJ fluent assertions API](https://www.javadoc.io/doc/org.assertj/assertj-core/latest/index.html).

Include AssertJ in Maven `pom.xml` dependencies:
```xml
<dependency>
	<groupId>org.assertj</groupId>
	<artifactId>assertj-core</artifactId>
	<version>3.18.0</version>
	<scope>test</scope>
</dependency>
```

Example with JUnit:
```java
import static org.assertj.core.api.Assertions.assertThat;

public class MyTest {

	@org.junit.Test
	public void testSomething() {
		// ...
		assertThat(mylist).hasSizeGreaterThanOrEqualTo(1);
	}
}
```

Object:
```java
assertThat(myObj).isNull();
assertThat(myObj).isNotNull();
```

List:
```java
assertThat(mylist).hasSizeGreaterThanOrEqualTo(1);
```

File:
```java
assertThat(new java.io.File("myfile.txt")).exists();
assertThat(new java.io.File("myfile.txt")).doesNotExist();
assertThat(new java.io.File("myfile.txt")).isEmpty();
assertThat(new java.io.File("myfile.txt")).isNotEmpty();
```

### Reflections

 * [Reflections](https://github.com/ronmamo/reflections), Java runtime metadata analysis, in the spirit of Scannotations.

### Eclipse

 * [Essential EMF](http://www.cheat-sheets.org/saved-copy/rc039-010d-emf.pdf).

### JADE

 * [JADE ADMINISTRATOR’S GUIDE](http://jade.tilab.com/doc/administratorsguide.pdf).
 * [JADE Test Suite USER GUIDE](http://jade.tilab.com/doc/tutorials/JADE_TestSuite.pdf).
 * [JADE TUTORIAL - JADE PROGRAMMING FOR BEGINNERS](http://jade.tilab.com/doc/tutorials/JADEProgramming-Tutorial-for-beginners.pdf).
 * [JADE PROGRAMMER’S GUIDE](http://jade.tilab.com/doc/programmersguide.pdf).

### Opencsv

[Opencsv](http://opencsv.sourceforge.net).

Basic CSV parser.

```java
import au.com.bytecode.opencsv.CSVReader;
CSVReader reader = new CSVReader(new FileReader("yourfile.csv"));
String [] line;
while ((line = reader.readNext()) != null) {
	// line[] is an array of values from the line
	System.out.println(line[0] + line[1] + "etc...");
}
```

### Gaggle

<http://gaggle.systemsbiology.net/docs/>.

Framework for exchanging data between independently developed software tools and databases to enable interactive exploration of systems BIOLOGY data. 

Can connect software like : R, Matlab, MeV, ...

### Google Guava

 * [Google Guava](http://guava-libraries.googlecode.com/svn/trunk/javadoc/index.html).

### Google JSON Simple

 * [JSON Simple](https://code.google.com/archive/p/json-simple/).
 * [JSON.simple Tutorial - Read and Write JSON in Java](https://www.javaguides.net/2019/07/jsonsimple-tutorial-read-and-write-json-in-java.html).

Load JSON from resource file:
```java
org.json.simple.parser.JSONParser jsonParser = new org.json.simple.parser.JSONParser();
java.io.InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream("myfile.json");
org.json.simple.JSONObject root = (org.json.simple.JSONObject) jsonParser.parse(new java.io.BufferedReader(new java.io.InputStreamReader(in)));
```

Get keys/values on the JSON root object:
```java
java.util.Set myKeys = root.keySet();
for (Object o: myKeys) {
	String key = (String)o;
	org.json.simple.JSONObject value = (org.json.simple.JSONObject)root.get(key);
}
```

### EJML

Efficient Java Matrix Library.

 * [EJML official site](https://code.google.com/p/efficient-java-matrix-library/).
 * [EJML wiki](http://ejml.org/wiki/index.php?title=Main_Page).

MVN dependency:

```xml
<dependency>
	<groupId>com.googlecode.efficient-java-matrix-library</groupId>
	<artifactId>ejml</artifactId>
	<version>0.25</version>
</dependency>
```

Load a matrix from a CSV (Column Space Value, *not* comma separated values) file:
```java
org.ejml.data.DenseMatrix64F db = org.ejml.ops.MatrixIO.loadCSV("myfile.csv", 44, 17);
```

### jackson-dataformat-csv


### Apache commons libraries

#### commons-math

The [common-maths](https://commons.apache.org/proper/commons-math/userguide/linear.html) package offers linear algebra operations on matrices and vectors.

#### commons-csv

```xml
<dependency>
	<groupId>org.apache.commons</groupId>
	<artifactId>commons-csv</artifactId>
	<version>1.2</version>
</dependency>
```

### spark-csv

A library that offers Data Frame objects, seen as SQL records.

See [spark-csv](https://github.com/databricks/spark-csv) for a plug-in for Apache Spark for creating a Data Frame from a CSV file.

groupId: com.databricks
artifactId: spark-csv_2.11
version: 1.2.0

### AROM 

AROM is an Object Based Knowledge Representation system.
See [official site](http://www.inrialpes.fr/romans/arom/index.html).

### HADOOP

Hadoop est un framework Java libre destiné aux applications distribuées et à la gestion intensive des données. Il permet aux applications de travailler avec des milliers de nœuds et des pétaoctets de données. Hadoop a été inspiré par les publications MapReduce, GoogleFS et BigTable de Google.
Fondation Apache.

### RESTLET

Web framework for Java.
See [official site](http://www.restlet.org/).

### JAX

JAX is a webservices library.

JAX WS is included in the Sun JDK. However for some tools (like the WsGen ant task) you need to get the latest version.

See the [official site](http://jax-ws.java.net/) of JAX WS.

`wsgen` is a JAX tool used to generate skeleton stubs for SOAP server and client.
It can also generate wsdl file.

The *WsGen ant task* can be found inside `jaxws-tools.jar` of jaxws package.

### REngine

REngine is a framework for running R code from Java.

There is an abstract class [org.rosuda.REngine.REngine](http://rforge.net/org/doc/org/rosuda/REngine/REngine.html) whose derive two concrete implementations:

 * [org.rosuda.REngine.JRI.JRIEngine](http://rforge.net/org/doc/org/rosuda/REngine/JRI/JRIEngine.html).
 * [org.rosuda.REngine.Rserve.RConnection](http://rforge.net/org/doc/org/rosuda/REngine/Rserve/RConnection.html).

`JRIEngine` is an implementation using [JRI](http://www.rforge.net/JRI/index.html), a Java/R Interface. It uses a native library, which must be findable by Java, and needs the variable environment `R_HOME` being properly set. 

On macOS:

 * Install `rJava` library in R.
 * Set `R_HOME` to the right path. You can find R home right value, by executing command `R.home()`.
 * Find the file `libjri.jnilib` inside the `R_HOME` path. It should be in `/Library/Frameworks/R.framework/Versions/Current/Resources/library/rJava/jri`.
 * Make a symbolic link of `libjri.jnilib` inside one of the directories listed in the Java System property `java.library.path`. To get the value of this property, run `System.getProperties().getProperty("java.library.path");` in Java. One possibility is inside your personal Library path: `$HOME/Library/Java/Extensions`.

`RConnection` uses `Rserve` to communicate with R through TCP/IP connection, allowing to run R code on a distant server as well as on the local host.

### W3C XML DOM

 * [How to create XML file in Java](https://www.programmergate.com/how-to-create-xml-file-in-java/).

Create a new XML document:
```java
javax.xml.parsers.DocumentBuilderFactory docFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
javax.xml.parsers.DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
org.w3c.dom.Document doc = docBuilder.newDocument();
```

Create a root element:
```java
org.w3c.dom.Element root = doc.createElement("myroot");
doc.appendChild(root);
```

Create children elements:
```java
org.w3c.dom.Element mychild = doc.createElement("mychild");
org.w3c.dom.Element mySubChild = doc.createElement("mySubChild");
myChild.appendChild(mySubChild);
root.appendChild(myChild);
```

Set text:
```java
myElem.setTextContent("My Text");
```

Set attribute:
```java
myElem.setAttribute("myAttribute", "My Value");
```

Produce the XML:
```java
javax.xml.transform.dom.DOMSource source = new javax.xml.transform.dom.DOMSource(doc);
javax.xml.transform.stream.StreamResult result = new javax.xml.transform.stream.StreamResult(new File("myfile.xml"));
javax.xml.transform.TransformerFactory transformerFactory = javax.xml.transform.TransformerFactory.newInstance();
javax.xml.transform.Transformer transformer = transformerFactory.newTransformer();
transformer.setOutputProperty(javax.xml.transform.OutputKeys.INDENT, "yes");
transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
transformer.transform(source, result);
```

Exclude the XML declaration in the output:
```java
transformer.setOutputProperty(javax.xml.transform.OutputKeys.OMIT_XML_DECLARATION, "yes");
```

Loading an XML:
```java
javax.xml.parsers.DocumentBuilderFactory dbFactory = javax.xml.parsers.DocumentBuilderFactory.newInstance();
javax.xml.parsers.DocumentBuilder builder = dbFactory.newDocumentBuilder();
org.w3c.dom.Document doc = builder.parse(new FileInputStream("myfile.xml"));
```

Getting root element:
```java
org.w3c.dom.Element root = doc.getDocumentElement();
```

Getting all children:
```java
org.w3c.dom.NodeList children = root.getChildNodes();
```

### Apache Batik SVG Toolkit

 * [Apache Batik SVG Toolkit](https://xmlgraphics.apache.org/batik/).
 * [Batik Swing components](https://xmlgraphics.apache.org/batik/using/swing.html).

 * [Displays a SVG icon in SVG using apache Batik](https://gist.github.com/lindenb/1003235).

### JDBC

Test if database is read-only:
```java
java.sql.DatabaseMetaData meta = myConn.getMetaData();
boolean ro = meta.isReadOnly();
```

### SQLite

 * [SQLite Java](https://www.sqlitetutorial.net/sqlite-java/).
 * [SQLite - Java](https://www.tutorialspoint.com/sqlite/sqlite_java.htm).

To connect to a SQLite file:
```java
java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:sqlite:/my/path/to/my/file.db");
```

To connect to a SQLite file inside resource folder:
```java
java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:sqlite::resource:process.sqlite");
```

To open a new SQLite db inside memory:
```java
java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:sqlite::memory:");
```

Set database as read-only:
```java
org.sqlite.SQLiteConfig config = new org.sqlite.SQLiteConfig();
config.setReadOnly(true); 
java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:sqlite:mydb.sqlite", config.toProperties());
```

Try to lock the database in exclusive mode:
```java
org.sqlite.SQLiteConfig config = new org.sqlite.SQLiteConfig();
config.setLockingMode(org.sqlite.SQLiteConfig.LockingMode.EXCLUSIVE); 
java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:sqlite:mydb.sqlite", config.toProperties());
```

Run a query with parameters:
```java
java.util.List<String> activities = new java.util.ArrayList<String>();
String sql = "SELECT DISTINCT activity FROM diag WHERE phaseIndex = ? ORDER BY id ASC;";
java.sql.PreparedStatement stmt = this.conn.prepareStatement(sql);
stmt.setInt(1, phase);
java.sql.ResultSet rs = stmt.executeQuery();
while (rs.next())
	activities.add(rs.getString("activity"));
```

Create a table:
```java
String sql = "CREATE TABLE IF NOT EXISTS notes (id INT PRIMARY KEY NOT NULL, value text);";
java.sql.Statement stmt = conn.createStatement();
stmt.execute(sql);
```

Insert/update data:
```java
String sql = this.getNote(key) == null ? "INSERT INTO notes(note,key) VALUES(?,?)" : "UPDATE notes SET note = ? WHERE key = ?";
java.sql.PreparedStatement stmt = this.conn.prepareStatement(sql);
stmt.setString(1, note);
stmt.setString(2, key);
stmt.executeUpdate();
```

### Jade

*JADE* is a multi-agent system framework.

For documentation and downloading, see the [official web site](http://jade.tilab.com).

#### Containers

Start a main container:
```bash
java -cp <classpath> jade.Boot
```

Start a main container using the JADE management GUI:
```bash
java -cp <classpath> jade.Boot -gui
```

Start a peripheral container (-container option) on host myhost and activate an agent myname of clas MyClass:
```bash
java -cp <classpath> jade.Boot -container -host myhost -agents myname:my.package.MyClass
```

A main container holds two special agents:

 * AMS (Agent Management System): naming service. Ensures uniqueness of agent names. Creates and kills agents on remote containers.
 * DF (Directory Facilitator): yellow pages service.

#### Terminating a container

From within an agent, it is possible to ask the container to kill itself:
```java
this.getContainerController().kill();
```
Care must be taken that this action does not occure while agents are still running. First one must be sure that all agents are terminated excepted the one trying to kill the container, and then create a new thread that will kill effectively the container after the last agent has terminated properly.
If agents are still running, an exception will be thrown for each agent, but the container will be killed anyway.

#### Test suite

Use the [JADE Test Suite](http://jade.tilab.com/doc/tutorials/JADE_TestSuite.pdf).

#### Create a new agent

```java
import jade.core.Agent;
public class BookBuyerAgent extends Agent {
	protected void setup() {
		// Printout a welcome message
		System.out.println("Hello! Buyer-agent "+getAID().getName()+" is ready.");
	}
}
```

`getAID()` retrieves the agent identifier.

#### Agent identifier

Getting the agent identifier:
```java
AID aid = myagent.getAID();
```
The AID is constructed as name@platform.

Constructing a new AID:
```java
AID id = new AID("bob", AID.ISLOCALNAME);
```

#### Arguments

Arguments to an agent must be passed on the command line. They are retrieved with the getArguments() method.
```java
Object[] args = getArguments();
```

#### Terminating

In order to terminate, an agent must call its `doDelete()` method.

When terminating, the `takeDown()` method of an agent is called, allowing for running clean-up operations.

#### Behaviours

For each agent action a behaviour must be created. A behaviour is an instance of a class inheriting from `jade.core.behaviours.Behaviour` class.

Behaviours are added through method `addBehaviour()`. This is normally done inside the `setup()` method.

A behaviour class must define two methods:

	* The `action()` method, which contains the operations to execute.
	* The `done()` method, which returns true if the behaviour has completed.

Since in *JADE* each agent has its own thread, all behaviours of an agent are executed in the same thread. Behaviours are executed in sequential order, so there is no concurrency issue. This means that the developer of an agent is responsible of the switching between one behaviour to the next, i.e. that each behaviour terminates its action properly and let the next behaviour's action execute.

#### Agent life cycle

 1. The `setup()` method is called.
 2. If agent has been killed (i.e.: `doDelete()` has been called), then the `takeDown()` method is called. The agent stops running.
 3. Call the `action()` method of the next behaviour.
 4. Call the `done()` of the same behaviour, and if it returns true then the behaviour is removed from the pool of behaviours.
 5. Go to step 2.
