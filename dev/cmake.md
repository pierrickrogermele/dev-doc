CMAKE
=====

## Running

Default project file is `CMakeLists.txt`.

Using building is done by creating a `build` directory from inside the source code root directory:
```bash
mkdir build
cd build
cmake ..
```

Using generator:
```bash
cmake .. -G Xcode
```

Compiling in debug mode (default):
```bash
cmake .. -DCMAKE_BUILD_TYPE=DEBUG
```

Compiling in release mode:
```bash
cmake .. -DCMAKE_BUILD_TYPE=
```

Set directories where to look for include and libs:
```bash
export CMAKE_PREFIX_PATH=/opt/local:$HOME/install
```

Get full help manual, with description of all commands:
```bash
cmake --help-full
```

Print available modules:
```bash
cmake --help-module-list
```

Print CMake commands:
```bash
cmake --trace
```

Print build commands (from Makefile):
```bash
cmake -DCMAKE_VERBOSE_MAKEFILE=true ...
```

### Curses interface for cmake

```bash
ccmake ..
```
### Generators

Get a list of available generators:
```bash
cmake
```
	
Specify a generator:
```bash
cmake .. -G "Unix Makefiles"
```
	
Compile for MSVS 10 and 64 bit:
```bash
cmake .. -G "Visual Studio 10 Win64"
```

### Command mode

For true platform independence, CMake provides a list of commands that can be used on all systems.
Commands available are:
	chdir
	compare_files
	copy
	copy_directory
	copy_if_different
	echo
	echo_append
	environment
	make_directory
	md5sum
	remove
	remove_directory
	rename
	tar
	time
	touch
	touch_nocreate

In addition, some platform specific commands are available.
On Windows:
	comspec
	delete_regv
	write_regv
On UNIX:
	create_symlink

CMake command mode:
```bash
cmake -E
```

Get help:
```bash
cmake -E help
```

## Built-in variables

 * [CMake Useful Variables](https://cmake.org/Wiki/CMake_Useful_Variables).

```cmake
CMAKE_BINARY_DIR
CMAKE_CURRENT_LIST_FILE     # Path of current CMake file.
CMAKE_CURRENT_LIST_DIR      # directory of current CMakeLists.txt file.
CMAKE_CURRENT_BINARY_DIR    # directory of compilation of the current CMakeLists.txt processed.
CMAKE_CURRENT_SOURCE_DIR
PROJECT_BINARY_DIR          # directory of compilation of the project.
PROJECT_NAME                # project name as declared with the project() command
```

Set directories where to find .cmake files used to locate packages.
It has to be set inside cmake file.
```cmake
set(CMAKE_MODULE_PATH /opt/local/share/CMakeModules)
```

### Installing

`cpack` is the packaging driver provided by CMake.
It is run when a project uses the `INSTALL_*` commands.

#### Installation destinations

Files are installed relatively to `CMAKE_INSTALL_PREFIX` path.
On UNIX systems `CMAKE_INSTALL_PREFIX` is set to `/usr/local`, and `C:\Program Files` on Windows.

It is this variable that must be changed on command line in order to target another destination:
```bash
cmake -DCMAKE_INSTALL_PREFIX=/opt/local ..
```

### Operating system

```cmake
message(STATUS ${CMAKE_SYSTEM_NAME})
```

System   | `CMAKE_SYSTEM_NAME` value
-------- | -------------------------
macOS    | Darwin
Windows  | Windows

### Compiler

Compiler          | `CMAKE_CXX_COMPILER_ID` value
----------------- | -------------------------
Clang             | Clang 
GCC               | GNU    
Intel C++         | Intel
Visual Studio C++ | MSVC

## Defined macros

When making libraries, cmake defines the following macro:
	<Library_name>_EXPORTS
So you can define the right export declarations `(__decl)` for Windows platform.

## Statements

### If

 * [If](https://cmake.org/cmake/help/v3.0/command/if.html).

Regex test:
```cmake
if(MYVAR MATCHES "AAA.*$")
	message("TRUE")
endif()
```

String test:
```cmake
if(MYVAR STREQUAL ANOTHERVAR)
	message("TRUE")
endif()
if(MYVAR STREQUAL "some text")
	message("TRUE")
endif()
```

`else` and `elseif`:
```cmake
if(MYVAR STREQUAL ANOTHERVAR)
	message("TRUE")
elseif(MYVAR NOT STREQUAL "some text")
	message("ANOTHER TRUE")
else
	message("FALSE")
endif()
```

## Version

Version is compulsory, and must be the first of the file:
```cmake
cmake_minimum_required(VERSION 2.8)
```

## Tuning compiler

Setting compiler options:
```cmake
add_definitions(-std=c++11)
```

Enabling C++ 11 features:
```cmake
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
	add_definitions(-std=c++11)
endif()
```

Choosing C/C++ compiler at command line:
```bash
cmake .. -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DCMAKE_C_COMPILER=/usr/bin/clang
```

Setting required features:
```cmake
target_compile_features(mylib PRIVATE cxx_constexpr)
```
This will tell cmake to set the required compiler flags (here: C++11).
However this functionality only works for CMake 3.0.2 and higher, so it's very recent. No list of features has been defined for Clang compiler, so it's not portable.

## Targets

### Making a library

Add a library target
```cmake
add_library(my_lib_target a.cpp b.c)
```

It's possible to specify an "IMPORTED" library that doesn't go generated:
```cmake
add_library(my_imported_target_lib SHARED IMPORTED)
set_property(TARGET my_imported_target_lib PROPERTY IMPORTED_LOCATION  /some/path/to/imported/library)
```
But then it's impossible to modify certain porperties. The following line will issue an error message:
```cmake
target_include_directories(my_imported_target_lib PUBLIC /some/path/to/include/files)
```

### Making an executable

```cmake
add_executable(prg main.c)
```

### Running tests

 * [CMake/Testing With CTest](https://cmake.org/Wiki/CMake/Testing_With_CTest).

`ctest` is the testing driver provided by CMake.
It is run when a project uses `enable_testing` and `add_test` commands.

## File system

Getting name of file without extension, from a path:
```cmake
get_filename_component(myvar /some/path/to/file.ext NAME_WE)
```
Get path of current cmake file:
```cmake
get_filename_component(myPath ${CMAKE_CURRENT_LIST_FILE} PATH)
```

List files inside a directory:
```cmake
file(GLOB myvar /some/path/with/widlcard/*.c)
```

List files inside a directory, with relative path:
```cmake
file(GLOB myvar RELATIVE /some/path/with/widlcard *.c)
file(GLOB myvar RELATIVE ${CMAKE_CURRENT_LIST_DIR} *.c)
file(GLOB myvar RELATIVE ${CMAKE_CURRENT_LIST_DIR} src/*.c)
```

## Set

Define a variable:
```cmake
set(myvar MyValue)
``

Append to a variable:
```cmake
set(test_prg ${test_prg} ${prg_file})
```

## Strings

Regex replace:
```cmake
string(REGEX REPLACE "^test/(.*).cpp$" "\\1" prg_file ${src_file})
```

## Foreach

```cmake
foreach(myvar val1 val2 val3)
	message(STATUS ${myvar})
endforeach(myvar)
```

## Get property

Get a property value:
```cmake
get_property(MY_VAR TARGET some_target PROPERTY INCLUDE_DIRECTORIES)
```
The value of the property `INCLUDE_DIRECTORIES` is written into the variable `MY_VAR`.

## Add subdirectory

Adding a subdirectory in which another CMakeLists.txt is defined
```cmake
add_subdirectory(my_sub_project)
```
It will create a subdirectory `my_sub_project` inside the `build/bin` directory of the super-project.

Adding a directory which resides outside the source tree:
```cmake
add_subdirectory(../my_sub_project)
```
Won't work, will complain that it needs an explicit binary (output) directory:
```cmake
add_subdirectory(../my_sub_project toto)
```
The explicit binary directory will be created under the super-project binary directory.

## Find package

Define a configuration cmake file to load:
```cmake
find_package(eveBIM REQUIRED)
```
If env var `eveBIM_DIR` is defined, this is where cmake will look for eveBIMConfig.cmake file.
After `find_package` has found the `.cmake` file, the following variables are set:
	<NAME>_FOUND
	<NAME>_INCLUDE_DIRS or <NAME>_INCLUDES
	<NAME>_LIBRARIES or <NAME>_LIBS
	<NAME>_DEFINITIONS 

## Packages

### Boost

To add whole boost package:
```cmake
find_package(Boost 1.59.0 REQUIRED)

if(Boost_FOUND)
  include_directories(${Boost_INCLUDE_DIRS})
endif()
```

To add only some libraries from the boost package:
```cmake
find_package(Boost 1.55.0 REQUIRED COMPONENTS system filesystem)
```

## Exec program

Run program and get output:
```cmake
exec_program(executable [directory in which to run]
             [ARGS <arguments to executable>]
             [OUTPUT_VARIABLE <var>]
             [RETURN_VALUE <var>])
```

## Include directories

Add include directories:
```cmake
include_directories(/my/path/to/include/dir)
```

## Find library

Look for libraries:
```cmake
find_library(MY_LIBS
             NAMES toto titi tata
             PATHS /opt/local/lib/somelib/lib)
```

## Target link libraries

Set used libraries:
```cmake
target_link_libraries(${PROJECT_NAME} ${MY_LIBS})
```

Add debug/release versions of libraries:
```cmake
target_link_libraries(${PROJECT_NAME} ${MY_LIBS}
                      debug     my_debug_lib1 my_debug_lib2
                      optimized my_release_lib1 my_release_lib2)
```

## I/O, Printing


Print an important message on stderr:
```cmake
message("Something important happened")
```

Print information message on stdout:
```cmake
message(STATUS "Some information")
```

Print a variable:
```cmake
message("some text and some var = ${SOME_VAR}")
```

Print a variable dynamically:
```cmake
message("value of some dynamic var = " ${${SOMEOTHERVAR}_VALUE})
```

## Environment variables

Access an env var:
```cmake
$ENV{PATH}
```

Set an env var:
```cmake
set(ENV{MYVAR} "some value")
```

## Errors

### Target "..." of type MODULE_LIBRARY may not be linked into another target

Error obtained when using a library of the projet inside another library or executable:
	CMake Error at src/EnergyPlusPerspective/CMakeLists.txt:74 (TARGET_LINK_LIBRARIES):
	 Target "CLIMBPlugin" of type MODULE_LIBRARY may not be linked into another
	 target.  One may link only to STATIC or SHARED libraries, or to executables
	 with the ENABLE_EXPORTS property set.

Solution.
Inside the CMakeLists.txt of the used library, specify that the library is SHARED (or STATIC) by changing line:
```cmake
add_library(${PROJECT_NAME} MODULE ${TARGET_H} ${TARGET_SRC})
```
into:
```cmake
add_library(${PROJECT_NAME} SHARED ${TARGET_H} ${TARGET_SRC})
```
