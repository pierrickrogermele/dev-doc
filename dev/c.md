<!-- vimvars: b:markdown_embedded_syntax={'c':''} -->
# C

 * [Rationale for International Standard— Programming Languages— C](http://www.open-std.org/jtc1/sc22/wg14/www/C99RationaleV5.10.pdf).

## Compilers

 * [Clang Static Analyzer](http://clang-analyzer.llvm.org/).

Vectorization (SIMD):
 * [GCC SSE code optimization](https://stackoverflow.com/questions/7919304/gcc-sse-code-optimization).
 * [Auto-Vectorization in LLVM](https://llvm.org/docs/Vectorizers.html).

## Preprocessor

 * [The GNU C Preprocessor](http://tigcc.ticalc.org/doc/cpp.html).

### Error & warning messages

Error:
```c
#error "An error !"
```

Warning (non standard):
```c
#warning "Some warning message."
```

### Macros

Concatening strings in a macro:
```c
#define TOTO(index, name) name##_##index
```

Transform a macro value into a C string:
```c
#define TOTO(param) # param
#define TOTO(param) #param
```

Use of semi-colon with multi-lines macros:
```c
#define CMDS \
 do { \
   a = b; \
   c = d; \
 } while (0)

if (var == 13)
	CMDS;
```

### Compiler built-in macros

Macro          | Compiler | Description
-------------- | -------- | -----------------------
`__clang__`    | Clang    | Clang compiler.
`__APPLE__`    | Clang    | Apple computer.
`__APPLE_CC__` | Clang    | Apple C compiler version.

### Conditions (if else endif)

```c
 #ifdef MY_MACRO
 #elif
 #else
 #endif

 #ifndef MY_MACRO
 #endif

 #if defined MY_MACRO
 #endif

 #if ! defined MY_MACRO
 #endif

 #if defined MACRO_1 && defined MACRO_2
 #endif
```

## Built-in types

### Declaring constant

```c
1234; /* int */
123456789l; /* long */
123456789L; /* long */
037; /* octal, starts with 0 */
0x1f; /* hexadecimal int, starts with 0x or 0X */
0X1f; /* hexadecimal int, starts with 0x or 0X */
0xFUL; /* unsigned long with decimal value 15 */
123.4; /* double */
123.4f; /* float */
123.4F; /* float */
123.4l; /* long double */
123.4L; /* long double */
```

### Limits (max and min)

Compute maximum of built-in types:
```c
#define MAX_UINT (~(unsigned int)0)
#define MAX_INT ((int)(MAX_UINT >> 1))
#define MIN_INT (- MAX_INT - 1)
```
In a 32-bit machine:
 * `MAX_UINT = 2^32 - 1`
 * `MAX_INT = 2^31 - 1`
 * `MIN_INT = -2^31`

Limits:
```c
#include <limits.h>
LONG_MAX;
LONG_MIN;

#include <float.h>
FLT_MAX;
DBL_MAX;
```

### Char

Lower/upper case:
```c
#include <ctype.h>
char C = 'A';
char c = tolower(C); /* c = 'a' */
char D = toupper(c); /* D = 'A' */
```

Special escaped characters:
```c
'\012'; /* character of octal code 012 */
'\x4b'; /* character of hexadecimal code 0x4b */
'\a'; /* alert (bell) */
'\b'; /* backspace */
'\f'; /* formfeed */
'\n'; /* newline */
'\r'; /* carriage return */
'\t'; /* horizontal tab */
'\v'; /* vertical tab */
'\\'; /* backslash */
'\?'; /* question mark */
'\''; /* single quote */
"\""; /* double quote */
```

### String

String constant:
```c
"hello," "world"
```
is equivalent to
```c
"hello, world";
```

## Variables & types

### Initialization

An automatic variable is one that is automaticaly created and destroyed.
Function parameters and other local variables are automatic variables.

Automatic variables are never initialized (Except in debug mode of some compilers ; be careful !).
Extern and static variables are initialized to zero by default.
Extern and static variables are only initialized once, and before program starts executing.

Array initialization:
```c
int arr[10]; /* not initialized */
int arr[10] = {0}; /* first and all following values are initialized to 0 */
```

### Volatile

A *volatile* specified is a hint to a compiler that an object may change its value in ways _NOT_ SPECIFIED BY THE LANGUAGE so that aggressive optimizations must be avoided. For example a real time clock might be declared:
```c
extern const volatile clock;
```

### Enum

Defining an enumeration:
```c
enum days {mon, tues, wed, thu, fri, sat, sun};
```

Declaring a variable:
```c
enum day a_day;
```

### Struct

Define a structure:
```c
struct my_struct {
	int a;
	float x;
};
```

Define a structure and name it with typedef:
```c
typedef struct my_struct {
	int a;
	float x;
} tMyStruct;
```

## Statements

### Operators

Precedence and associativity of operators.
From high precedence (top) to low (bottom).

Operators                                                                | Associativity
------------------------------------------------------------------------ | -------------
`()`, `[]`, `->`, `.`                                                    | Left to right.
Unary ops:`!`, `~`, `++`, `--`, `+`, `-`, `*`, `&`, `(type)`, `sizeof()` | Right to left.
`*`, `/`, `%`                                                            | Left to right.
`+`, `-`                                                                 | Left to right.
`<<`, `>>`                                                               | Left to right.
`<`, `<=`, `>`, `>=`                                                     | Left to right.
`==`, `!=`                                                               | Left to right.
`&`                                                                      | Left to right.
`^`                                                                      | Left to right.
`|`                                                                      | Left to right.
`&&`                                                                     | Left to right.
`||`                                                                     | Left to right.
`?:`                                                                     | Right to left.
`=`, `+=`, `-=`, `*=`, `/=`, `%=`, `&=`, `^=`, `|=`, `<<=`, `>>=`        | Right to left.
`,`                                                                      | Left to right.

Unary `+`, `-`, and `*` have higher precedence than the binary forms.


### Extern

Accessing outside global variables:
```c
int max;

void foo() {
	int i;
	extern int max; /* declare outside of function.
	                 * This is necessary if 'max' is defined in another source
	                 * file, or in the same source file but after this
	                 * function. */

	/* ... */
}
```

Using header file to declare extern variables:
In `file.c`:
```c
int max;
```

In `file.h`:
```c
extern int max;
```

### Static

Static keyword is only used inside a .c source file.

A static external (i.e.: global) variable is invisible outside the source file where it is defined:
```c
static int my_global_var = 3;
```

A static internal (i.e.: local) variable is kept alive between all the calls of the function:
```c
int foo() {
	static int my_static_var = 1; /* created only once */
	/* At each call of foo, my_static_var keeps the same value it had at the last call of foo. */
}
```

A static function cannot be seen outside the source file where it is defined:
```c
static int foo() {}
```

### Label

Using a label:
```c
goto my_label;
/*...*/
my_label:
```

### Functions

```c
Function pointers:
void foo(int(*fct_ptr)(char), char c) {
	int i = (*fct_ptr)(c);
}
```

#### Main

The `main()` function is the entry point of the program.

Skeleton for a main function:
```c
int main(int argc, char *argv[]) {
	return 0;
}
```

## Standard Library

 * [C Standard Library](http://www.cs.unibo.it/~sacerdot/doc/C/stdlib.html).

### Malloc, free & memory

sizeof operator:
```c
 #include <stdlib.h>
int n;
size_t sz = sizeof(n);
```

Create an array of n int:
```c
 #include <stdlib.h>
 #include <stdlib.h>
int *v = (int*)malloc(sizeof(int)*n);
```

#### Reseting & copying

Write n time the same byte value at pointer p:
```c
 #include <string.h>
memset(p, byte_value, n);
```

#### Double freeing a block of memory

The behavior of the free() function is implementation specific.
In case of freeing twice the same memory block, your application may crash, but if you're lucky it may also print you a useful warning message like:
	doublefree(79833,0x7fff77cc3310) malloc: *** error for object 0x7fb3ebc03a50: pointer being freed was not allocated, set a breakpoint in malloc_error_break to debug.

So if your compiler is not helping you, I suggest that either you change it use some analysis tools to help you debugging.

The reason behind this behaviour is the way the malloc/free functionality is usually implemented. 
To understand it, read the section 8.7 of the famous "The C Programming Language", Second Edition, by K&R. It illustrates with a simple example the basic principle of, I suppose, the real implementations (glibc is at least implemented this way). Each block of memory (freed or allocated) is preceded by a header. The headers of the freed block form a chained list. The headers of the allocated blocks are out of this list. When you free an allocated block, the free() function looks at its header and put it back to the list of headers of freed blocks. So if you try to free again the same block, and if no checks are done inside the free() implementation, bad things can easily happen.

To see a real implementation of malloc/free and new/delete, have a look at the gcc (https://gcc.gnu.org) source code and the glibc (downloadable at http://ftp.gnu.org/gnu/glibc/) source code for malloc/free only. Since the glibc is smaller, it may be easier to locate the right files to look at. 

### Assert

```c
 #include <assert.h>

assert(i == 2);
```

If macro `NDEBUG` is defined, then all assert macro are disabled.

### Strings

Standard header:
```c
 #include <strings.h>
```

To get help in UNIX:
```bash
man string
```

Transform string to integer:
```c
 #include <stdlib.h>
int i = atoi(s);
int i = (int)strtol(s, (char **)NULL, 10);
```

Search for a character in a string:
```c
 #include <strings.h>
char* p = index(s, 'a');    /* index() is not standard anymore, and isn't recognized by MSVC. */

 #include <string.h>
char* p = strchr(s, 'a');    /* strchr() is the current standard, and is recognized by MSVC. */
```


### I/O

#### Stdin

Getting a char:
```c
 #include <stdio.h>
int c = getchar(); /* read a character from STDIN */
if (c == EOF)
	do_something_on_end_of_file();
```

#### Stdout
Putting/writing a char:
```c
 #include <stdio.h>
if (putchar(c) == EOF) /* write char c on STDOUT */
	something_wrong_happened();
```
`putchar()` returns the character written if everything went right, otherwise it returns EOF.

#### Reading from a file

Open a file for reading:
```c
 #include <stdio.h>
fd = fopen(file, "r");
```

Close a file:
```c
fclose(fd);
```

Read all float values from a file:
```c
 #include <stdio.h>
while (EOF != fscanf(fd, "%f", p++))
	;
```

#### Writing to a file

Open a file for writing:
```c
 #include <stdio.h>
fd = fopen(file, "w");
```

write to a file:
```c
 #include <stdio.h>
fprintf(fd, "%.3f\n", x);
```

#### Printf

Flag | Description
---- | -----------
`c`  | Character.
`s`  | String.
`d`  | Decimal.
`h`  | Hexadecimal.
`e`  | Double with exponent style.
`f`  | Plain double (no exponent).
`g`  | Double, choose between e and f, which is the best.

`L` is a modifier to `e`, `f` and `g`, for `long double`:
```c
printf("%Lf", mylongdouble);
```

`l` and `ll` are modifiers for `d` and `h`, for respectively `long` and `long long`:
```c
printf("%ld", mylong);
printf("%lld", mylonglong);
```

### File system

Test if a folder exists:
```c
#include <sys/types.h>
#include <sys/stat.h>

struct stat info;

if (stat(mypath, &info) == 0 && (info.st_mode & S_IFDIR))
	/* Is a directory */
```

Maximum number of characters a path can have:
```c
 #include <limits.h>
char file[MAX_PATH];
```

Character position in file:
```c
 #include <stdio.h>
fpos_t file_pos;
```

#### Current working directory (CWD)

```c
 #include <unistd.h>

/* get current working directory */

/* under Linux */
char *cwd = get_current_dir_name();
/* do my stuff */
free(cwd);

/* getcwd (BSD & XOPEN), deprecated */
 # define MYBUFSIZE 1024
char *mybuf = malloc(sizeof(char) * MYBUFSIZE);
char *cwd = getcwd(mybuf, MYBUF_SIZE);
if ( ! cwd)
	error_occured(); /* buf is not big enough ! */

/* getwd */
char *cwd = getwd(buf); // size of buf must be at least PATH_MAX
if ( ! cwd)
	error_occured(); /* buf is not big enough ! */
```

### Environment variables

```c
 #include <stdlib>

/* get an environment variable value */
const char *myenvvar_value = getenv("MYENVVAR");

/* create an environment variable (no value) */
if ( ! putenv("MYENVVAR"))
	something_went_wrong();

/* set an environment variable with a value */
if ( ! setenv("MYENVVAR", "MYVALUE", 1 /*overwrite*/))
	something_went_wrong();
```

### Time

Header:
```c
 #include <time.h>
```

`clock()` measures the amount of processor time used since the invocation of the process. It doesn't take idle time into account.
To take into account idle time (like when blocking in a thread, or waiting for network answer, etc), one must measure wall clock time (see `gettimeofday()`).
```c
clock_t t = clock();
```

Compute the number of seconds elapsed since the start of the program:
```c
float seconds = t / CLOCKS_PER_SEC;
```

For measuring wall clock time, one must use the `time()` function. It returns the value of time in seconds since 0 hours, 0 minutes, 0 seconds, January 1, 1970, Coordinated Universal Time, without including leap seconds. It returns -1 if an error occured.
```c
time_t t = time(NULL);
```
or
```c
time(&t);
```

To get microseconds resolution, use `gettimeofday()` function:
```c
 #include <sys/time.h>
struct timeval tp;
gettimeofday(&tp, NULL);
time_t      seconds_since_1st_jan_1970 = tp.tv_sec;
suseconds_t microseconds               = tp.tv_usec;
```

### Getopt

#### Short options

```c
 #include <unistd.h>

int main(int argc, char *argv[]) {
	int c;
	int flag;

	while ((c = getopt(argc, argv, "ab:")) != -1) {
		switch (c) {
			case 'a':
				flag = 1;
				break;

			case 'b':
				printf("a string argument: %s\n", optarg);
				break;
		}
	}
}
```

#### Long options

```c
 #include <iostream>
 #include <getopt.h>
using namespace std;

int main(int argc, char *argv[])
{
	int c;
	int iterations = 0;
	float decay = 0.0f;
	int option_index = 0;
	static struct option long_options[] =
{
	        {"decay",  required_argument, 0, 'd'},
		                {"iteration_num",  required_argument, 0, 'i'},
		                        {0, 0, 0, 0}
	            };

    while ((c = getopt_long (argc, argv, "d:i:",
                                             long_options, &option_index)  ) !=-1)
{
	        /* getopt_long stores the option index here. */

	        switch (c)
{
	        case 'i':
		                //I think issue is here, but how do I typecast properly? 
		                // especially when my other argument will be a float 
		                iterations  = static_cast<int>(*optarg);    
		                        cout<<endl<<"option -i value "<< optarg;
		                                break;

										        case 'd':
		                                        decay = static_cast<float>(*optarg);
		                                                cout<<endl<<"option -d with value "<<optarg;
		                                                        break;

																     }
    }//end while
    cout << endl<<"Value from variables, which is different/not-expected";
        cout << endl<< decay << endl << iterations <<  endl;
        return(0);
        }
```

## Technics

### Vectorization

Using SSE instructions, we can write a matrix sum example that uses vectorization:
```c
 #include <xmmintrin.h>

mm_c = (__m128*)c;
mm_b = (__m128*)b;
mm_a = (__m128*)a;
for (int i = 0 ; i < N / 4 ; ++i) {
	*mm_c = _mm_add_ps(*mm_a, *mm_b);
	mm_c++;
	mm_a++;
	mm_b++;
}
```

## Libraries

### ASCII / terminal libraries

 * [ncurses](https://invisible-island.net/ncurses/announce.html).
 * [aalib](http://aa-project.sourceforge.net/aalib/).
 * [libcaca](http://caca.zoy.org/wiki/libcaca). An improvement of aalib, with colors.

### wxWidgets

 * [Hello World Example](http://docs.wxwidgets.org/trunk/overview_helloworld.html).

### Windows API

 * [Making client and server using win32 socket](http://www.go4expert.com/articles/client-server-using-win32-socket-t19761/).

#### API version

To use the highest available Windows platform:
```c
 #include <SDKDDKVer.h>
```

To use another version:
```c
 #include <WinSDKVer.h>
 #define _WIN32_WINNT <myversion>
 #include <SDKDDKVer.h>
```

#### CreateProcess

Makes a system call.

[CreateProcess function](https://msdn.microsoft.com/en-us/library/windows/desktop/ms682425(v=vs.85).aspx).

```c
 #include <Windows.h> /* for Winbase.h */
```

DLL: `Kernel32.dll`.

```c
if (CreateProcess(NULL, "/the/path/to/my/programm")) {
	/*...*/
}
```

#### Error reporting

When an application crashes, the default behaviour of Windows is to display the [error reporting](https://msdn.microsoft.com/en-us/library/bb513641.aspx) (one of the window popups that appear on the screen).

To avoid the display of this window, you can call the [`WerAddExcludedApplication()`](https://msdn.microsoft.com/en-us/library/bb513617.aspx) function from within your application.

#### GetLastError

Returns code of last error met by the Windows API:
```c
DWORD err = GetLastError();
```

A string message associated to the error code can be retrived using the `FormatMessage` function:
```c
LPTSTR errorText = NULL;
DWORD len = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS, NULL, err, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&errorText, 0, NULL);
if ( NULL != errorText ) {
	/*...*/
	LocalFree(errorText);
}
```
See [How should I use FormatMessage() properly in C++?](http://stackoverflow.com/questions/455434/how-should-i-use-formatmessage-properly-in-c).

Macro                     | Code      | Description
------------------------- | --------- | ----------------------------------
`ERROR_INVALID_PARAMETER` | 87 (0x57) | The parameter is incorrect.

### Random numbers

Get a random number between `0` and `RAND_MAX` included:
```c
 #include <stdlib.h>
int n = rand();
```
	
Set the seed, using current time in seconds (`unsigned integer`):
```c
 #include <time.h>
 #include <stdlib.h>
srand(time(NULL));
```
	
`random()` gives better random numbers than `rand()`.
```c
 #include <stdlib.h>
long n = random(); /* [0, (2**31)-1] */
```
`random()&01` will produce a random binary value.

### Sleep

Sleep n seconds:
```c
 #include <unistd.h>
int n = 10;
if (int unslept = sleep(n))
	printf("Sleep has been interrupted by a signal after %d seconds.", n - unslept);
```

Sleep n micro-seconds sleep:
```c
 #include <unistd.h>
if (usleep(300))
	/* some error occured */;
```

### zfp & fpzip

 * [zfp & fpzip: Floating Point Compression](https://computing.llnl.gov/projects/floating-point-compression).

## IDEs

### Xcode

 * [Installing the Xcode Command Line Tools (Xcode CLT)](https://developer.xamarin.com/guides/testcloud/calabash/configuring/osx/install-xcode-command-line-tools/).

Get path to the Xcode command line tools:
```bash
xcode-select -p
```

Install the Xcode command line tools:
```bash
xcode-select --install
```

#### xcodebuild

`xcodebuild` is a command line tool to build an Xcode project.

Code signing error:
```
/Users/eatoni/v3/applications/iphone/twitter/build/Release-iphoneos/twitter.app: User interaction is not allowed.
** BUILD FAILED **
```
run:
```bash
Security unlock-keychain /Users/eatoni/Library/Keychains/login.keychain
```

#### How to change "__MyCompanyName__" ?

Where does ProjectBuilder (Xcode) stores the string to use as `__MyCompanyName__` ? 

Open the ProjectBuilder preferences file (~/Library/Preferences/com.apple.ProjectBuilder.plist) or the Xcode one (~/Library/Preferences/com.apple.Xcode.plist) and edit the dictionary associated with the key PBXCustomTemplateMacroDefinitions (create one if it does not exist, as child of the root node), edit or add the key ORGANIZATIONNAME, the associated string value will be used when PB creates new source files.

You could also do it via Terminal.app:

```bash
Defaults write com.apple.ProjectBuilder PBXCustomTemplateMacroDefinitions '{ "ORGANIZATIONNAME" = "My Company";}'
```
Or
```bash
Defaults write com.apple.Xcode PBXCustomTemplateMacroDefinitions '{ "ORGANIZATIONNAME" = "My Company";}'
```

#### Error messages

```
ERROR: a signed resource has been added, modified or deleted
```
	Build -> Clean All Targets
	Build and Go

## Debugging

### LLDB

The debugger for the LLVM (clang) compiler.

 * [LLDB](http://lldb.llvm.org) official site.

Run:
```bash
lldb -f my_prog -- arg1 arg2 arg3 ...
```

Command     | Description
----------- | -------------------------------------
`h`         | Help.
`h b`       | Help on breakpoint command.
`b main`    | Set a breakpoint on main() function.
`br del 2`  | Delete breakpoint 2.
`r`         | Run.
`n`         | Step.
`s`         | Step in.

## Profiling

### Valgrind

`valgrind` is an emulator. So it doesn't need to instrument code, but is very very slow.
`helgrind` is used for detection of synchronization errors between threads in the POSIX pthreads.

Memory checking:
```bash
valgrind --tool=memcheck <program>
valgrind <program>  # memcheck is the default tool
valgrind  --leak-check=full <program> # to get a detailed list of leak errors
```

Profiling:
```bash
valgrind --tool=callgrind <program>
valgrind --tool=callgrind --cache-sim=yes <myprog> # Simulate cache
```

For visualizing an output file from Valgrind, use `kcachegrind` or
`qcachegrind`:
```bash
kcachegrind callgrind.out.<pid>
qcachegrind callgrind.out.<pid>
```
If you want a text output, use `callgrind_annotate`:
```bash
callgrind_annotate  # Text output
```

For profiling the cache:
```bash
valgrind --tool=cachegrind <myprog>
cg-annotate cachegrind.out.<PID>
```
