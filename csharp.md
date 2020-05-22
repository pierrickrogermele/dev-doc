<!-- vimvars: b:markdown_embedded_syntax={'cs':'','sh':'bash'} -->
C#
==

 * [The Mono log profiler](http://www.mono-project.com/docs/debug+profile/profile/profiler/).

## .NET

### Installing

 * [.NET Core on ArchLinux](https://wiki.archlinux.org/index.php/.NET_Core).

## Mono

 * [Mono Project](http://www.mono-project.com).

### Installing

For getting latest sources, go to <https://github.com/mono>.

On <http://mono.ximian.com/daily/> is a list of daily built source packages.

Building 64-bit version from sources on MacOS-X:
```sh
./configure --prefix=$HOME/install --with-glib=embedded --build=x86_64-apple-darwin10
```

After running configure, edit eglib/src/Makefile, and modify line 332:
```sh
#libeglib_la_LIBADD = -lm $(ICONV_LIBS) -lpsapi
libeglib_la_LIBADD = -lm -lcharset
```

Compile and if you met the following error:
	Error: Cannot load support for ResX format: Could not load file or assembly 'System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089' or one of its dependencies. The system cannot find the file specified.
	MCS     [net_2_0] System.Windows.Forms.dll
	
	Unhandled Exception: System.NullReferenceException: Object reference not set to an instance of an object
run again the `make` command.

### Running

Running a program with mono:
```sh
mono MyProg.exe
```

### Compiling

Compile source file, producing a MyProg.exe program file:
```sh
mcs MyProg.cs
```

 * mcs : C# compiler for 1.x profile (C# 1.0 and parts of C# 2.0 and C# 3.0)
 * gmcs: C# compiler for 2.0 profile (complete C# 3.0)
 * smcs: C# compiler for Silverlight/Moonlight

Specifying the language version:
```sh
gmcs -langversion:Default   # C# 3.0
gmcs -langversion:ISO-1     # restrict to 1st ISO standardized features
gmcs -langversion:ISO-2     # restrict to 2nd ISO standardized features
gmcs -langversion:3         # C# 3.0
gmcs -langversion:future    # C# 4 as released in VS2010 beta 1
```

### MonoDevelop

New Projet:
	File->New->Solution -> C# -> Console Project

Add a Library inside a project
	right click on Solution -> Add -> Add New Project -> C# -> Library

Link the library inside the executable:
	right click on References inside the project,
	select Projects tab
	select the library
Inside the source code file, in C#, write:
```cs
using My.Library;
```

## Windows Presentation Foundation (WPF)

  * [How to: Use a Grid for Automatic Layout](https://docs.microsoft.com/en-us/dotnet/framework/wpf/advanced/how-to-use-a-grid-for-automatic-layout).

## SQL

Add the assembly reference `System.Data` to the project:
```cs
// include the SQL Client header:
using System.Data.SqlClient;

// connect (for MS SQL Server)
SqlConnection myConnection = new SqlConnection("user id=<username>;" + 
                                               "password=<password>;" +
                                               "server=<serverurl>;" + 
                                               "Trusted_Connection=yes;" + 
                                               "database=<database>; " + 
                                               "connection timeout=30");
```
For MySQL, use ODBC connection or MySQL library ADO.NET.

## Access modifiers

```cs
class Toto
{
	public int i;
	private float f;
	public int foo();
	protected string name;
	internal void do_something(); // this function is only accessible from the same assembly
}
```

## Array

Defining:
```cs
int[] array = new int[10];
int[,] array2d = { { 1, 2, 3}, {4, 5, 6} };
int[,] array2d = new int[3,5];
int[][] array2d = new int[10][];
array2d[0] = new int [7] { 1, 2, 3, 4, 5, 6, 7 };
```

Getting array length:
```cs
array.Length
```

Length of multi-dimensional arrays:
```cs
array.GetLength(0);
array.GetLength(1);
```

Sorting array:
```cs
Array.Sort(my_array);
```

Looping on all elements:
```cs
foreach(int i in my_array) {
	// ...
}
```

## Built-in types

Max values:
```cs
float.MaxValue;
```

C# Type     .NET Framework Type
```cs
bool v;     System.Boolean v;
byte v;     System.Byte v;
sbyte v;    System.SByte v;
char v;     System.Char v;
decimal v;  System.Decimal v; // 128 bit with better precision than double and float, but a smaller range
double v;   System.Double v; // 64 bit
float v;    System.Single v; // 32 bit
int v;      System.Int32 v;
uint v;     System.UInt32 v;
long v;     System.Int64 v;
ulong v;    System.UInt64 v;
object v;   System.Object v;
short v;    System.Int16 v;
ushort v;   System.UInt16 v;
string v;   System.String v;
```

## String

Converting a integer to string:
```cs
int i = 12;
i.ToString(); // convert to a decimal string
i.ToString("X"); // convert to an hexadecimal string
```

## Time

Equivalent of `clock()` C function, measures CPU time used by process:
```cs
using System.Diagnostics;
Process p = Process.GetCurrentProcess();
TimeSpan t = p.TotalProcessorTime;

// Measure time spent
DateTime startTime = DateTime.Now;
DateTime stopTime = DateTime.Now;
TimeSpan duration = stopTime - startTime;
```

## Class instantiation

Creating an instance:
```cs
MyClass obj = new MyClass();
```

`new()` can be called on basic types:
```cs
int i = new int();
int i = 0; // same effect as above
```

`new()` can also be used in a request:
```cs
var query = from cust in customers select new {Name = cust.Name, Address = cust.PrimaryAddress};
```

## Class construction & destruction

Constructor:
```cs
class MyClass {
	public MyClass() {
	}
}
```

Constructor with invocation of another constructor:
```cs
class MyClass : ParentClass {
	public MyClass() : this(5) { // invoke constructor with an int
	}

	public MyClass(int n) : base(n) { // invoke mother class' constructor
	}
}
```

Finalize (called by the destructor):
```cs
class MyClass {
	protected virtual void Finalize() {
	}
}
```

Destructor:
```cs
class MyClass {
	public ~MyClass() {
		// when your application encapsulates unmanaged resources such as windows, files, and network connections, you should use destructors to free those resources.
	}
}
```

## Casting

Boxing and unboxing (i.e.: casting from/to a basic type):
```cs
int i = 123;
object o = (object)i; // boxing
int j = (int)o; // unboxing
```

## Class inheritance

Inheritance:
```cs
class MyClass : ParentClass {
	public MyClass() : base() // constructor with base class initialization {
	}
}
```

## foreach

```cs
string[] lines;
foreach (string line in lines) {
}
```

## try / catch

Catching a system exception:
```cs
float foo() {
	try {
		if (x == 0)
			throw new System.ApplicationException("My exception message.");
		return x / y;
	}
	catch (System.DivideByZeroException dbz) {
		System.Console.WriteLine("Division by zero attempted!");
		return 0;
	}
	catch (System.ApplicationException ex) {
		System.Console.WriteLine("Catched an application exception!");
		return 0;
	}
}
```

## Garbage collecting

Forcing garbage collection:
```cs
GC.Collect();
```

## I/O

Writing to STDOUT:
```cs
Console.WriteLine("Hello here is some value : {0}, and another one: {1}", myvar1, myvar2);
```

Writing to a file, line by line:
```cs
System.IO.StreamWriter file = new System.IO.StreamWriter(@"my_file");
file.WriteLine("blabla");
```

Writing a single string to a file:
```cs
string text = "blabla";
System.IO.File.WriteAllText(@"my_file", test);
```

Writing a array of lines to a file:
```cs
string[] lines = {"First line", "Second line", "Third line"};
System.IO.File.WriteAllLines(@"my_file", lines);
```

Reading lines from a file:
```cs
string s;
while (f.Peek() >= 0) {
	s = f.ReadLine();
	// ...
}
```

Reading characters from a file:
```cs
char c;
while ((c = f.Read()) >= 0) {
	// ...
}
```

Printing an object name:
```cs
using System;
Console.WriteLine("An instance: {0}", my_instance);
```

## Library

Including a library:
```cs
using mylib;
```

## List

```cs
using  System.Collections.Generic;
```

Creating a list:
```cs
List<float> my_list = new List<float>();
```

Looping on all elements:
```cs
foreach(float f in my_list) {
	// ...
}
```

Iterating:
```cs
List<float>.Enumerator i = my_list.GetEnumerator();
do {
	do_something_on_element(i.Current);
} while i.MoveNext();
```

Getting number of elements:
```cs
if (my_list.Count != 0) {
	// ...
}
```

Removing an object:
```cs
my_list.RemoveAt(3); // remove element at index 3
```

Get elements:
```cs
my_list[0]; // get first element
```

## Main method

Create main entry for a console program:
```cs
using System;

namespace MyProg {
	class Program {
		static void Main(string[] args) {
		}
	}
}
```

## Hastable (map)

Create a map:
```cs
Hashtable map = new Hashtable();
```

Add new key/value pair:
```cs
map.Add("key1", "value1");
```

Change the value of a key:
```cs
map["key1"] = "new value";
```

Test if a key exists:
```cs
if (map.ContainsKey("key2")) {
	// ...
}
```

Loop on all elements:
```cs
foreach( DictionaryEntry i in map) {
	do_something_on_pair(i.Key, i.Value);
}
```

Get all values:
```cs
ICollection values = map.Values;
```

## Math

The `Math` class contains usual mathematical functions.

Trigo functions:
```cs
double x = Math.Sin( 2.0 * Math.PI);
```

## Random

Getting random numbers:
```cs
using System;
Random rand = new Random();
int n = rand.Next(); // get number in [0;2^32[
int m = rand.Next(100); // get number in [0;99]
int x = rand.NextDouble();
```

## Profiling

Under MacOS-X with Mono 3.0:
```sh
LD_LIBRARY_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib  mono --profile=log CpuTime.exe
```
Then
```sh
mprof-report output.mlpd
```
