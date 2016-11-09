AUTOTOOLS
=========

 * [Autotools - a guide to autoconf automake libtool](http://www.freesoftwaremagazine.com/books/autotools_a_guide_to_autoconf_automake_libtool).
 * [A tutorial for porting to autoconf & automake](http://mij.oltrelinux.com/devel/autoconf-automake/).
 * [Les outils Automake et Autoconf....](http://www-igm.univ-mlv.fr/~dr/XPOSE/Breugnot/).

Languages supported by the autotools:

 * C.
 * C++.
 * Objective C.
 * Fortran.
 * Fortran 77.
 * Erlang.

## Autoconf
	
### `autoconf`

Used to generate a `configure` script.
It is better to use `autoreconf` than `autoconf`, see below.
	
### `autoreconf`

Regenerate everything that needs to be regenerated from the `configure.ac` file.
It runs all programs from Autotool, Automake and Libtool packages that need to be run.

### `autoheader`

Generates a `config.h.in` header file from `configure.ac`.

### `autom4te`

Cache manager that speeds up access to `configure.ac` for other scripts.

### `autoscan`

Helps generating a "reasonable" `configure.ac` file for a new project.
From an existing `configure.a`c file, it scan all source files and creates the following files: `configure.scan` and `autoscan.log`.
It doesn't alter any existing file. In particular in doesn't touch `configure.ac`, but instead create `configure.scan` that you can use in replacement of your `configure.ac`.
	
### `autoupdate`

Update `configure.ac` and template (`*.in`) files to the syntax of the current version of Autotools.
	
### `ifnames`

Scan a list of source files and displays found `C` preprocessor definitions.
	
## Automake
	
### `automake`

Generates makefile templates (`Makefile.in`) from `Makefile.am`.
	
### `aclocal`

Generates `aclocal.m4` for `autoconf`. `aclocal.m4` file was originaly designed for defining user-provided extension macros. Now that it is used by `aclocal`, there's a new file name `acinclude.m4` for the purpose of the user.

Today the `aclocal`/`acinclude` pardigm is obsolete. The current recommandation is to make a `m4` directory in the project, and place in it all `.m4` files. All these `m4` files will be gathered into one `aclocal.m4` file before Autoconf processes the `configure.ac` file.
	
## Libtool

Provides :
 * a set of Autoconf macros that hide library naming differences in makefiles.
 * an optional library of dynamic loader functionality that can be added to your programs, allowing you to write more portable runtime dynamic shared object management code.

### `libtool` (program)

### `libtoolize` (program)

Generates a custom version of libtool script.
This script is then used by Automake-generated makefiles.

### `ltdl` (static and shared libraries) & `ltdl.h` (header)

Provides a consistent run-time shared object manager across platforms.
May be linked statically or dynamically.
	
## `configure` generated script

When run, `configure` checks system and generates `config.status` which is a script that generates the `config.h` and the makefiles from `config.h.in` and `Makefile.in` files.
`configure` also writes a `config.log` file.
`configure` calls `config.status` just after having created it.

### Remote building

`configure` can be called from a different place that the sources tree.
Example:
```bash
tar -zxvf doofabble-3.0.tar.gz
mkdir doofabble-3.0.debug
cd doofabble-3.0.debug
../doofabble-3.0/configure --enable-debug
make
```

## Example: a simple scripts project
	
How to use autotools with a simple projects containing only script files ?
	
Run autoscan:
```bash
autoscan
mv configure.scan configure.ac
```

Edit `configure.ac`, and find `AC_INIT` line. Replace text with project name, version number and email address for bugs.
	
Create makefile `Makefile.am`:
```make
AUTOMAKE_OPTIONS = foreign
bin_SCRIPTS = <list of scripts (separated by spaces)>
```
The "foreign" values is for telling `aclocal` that this is not a GNU project (a GNU project requires certain folders and files to be present, such as `doc`, `src`, `INSTALL`, `COPYING`, etc.)
	
Edit `configure.ac` again. Initialize `automake`, right after `AC_INIT`, by adding the following line:
```
AM_INIT_AUTOMAKE(<project_name>, <version_number>)
```
Create `Makefile` by adding the following line:
```
AC_OUTPUT(Makefile)
```

Run aclocal:
```bash
aclocal
```
It generates `aclocal.m4` (macros for `automake`).
	
Run `automake`
```bash
automake --add-missing
```
It creates `Makefile.in` files.

Run `autoconf`:
```bash
autoconf
```
It creates the `configure` script.
	
Remark: the steps (`aclocal`, `automake` and `autoconf`) can be replaced by the single command `autoreconf`.
