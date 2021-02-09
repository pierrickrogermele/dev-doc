<!-- vimvars: b:markdown_embedded_syntax={'make':''} -->
# Make

## Running

Default project file is `Makefile`.

Options:

Option flag | Description
----------- | ---------------------------------------------
`-d`        | Debug (very verbose).
`-n`        | Print commands that would be run, don't run anything.
`-p`        | Print database.

Printing database (i.e.: list of all rules):
```bash
make -p
make -p -f/dev/null # don't try to remake any files
```

Run make in a directory:
```bash
make -C my_dir
```

## ifeq, ifdef, else

Testing value:
```make
ifeq ($(shell uname -s),Darwin)
#...
else
#...
endif
```
Be careful that no spaces are put around values, before/after the parenthesis and around the comma.

Testing if a file exists:
```make
ifneq (,$(wildcard /my/file))
endif
```

Testing variable definition:
```make
ifdef MY_VAR
#...
else
#...
endif
```
Or for testing if variable does not exist:
```make
ifndef MY_VAR
endif
```

## if

True if the condition results in a non-empty string.

```make
$(if $(var),$(my_then_var))
$(if $(var),$(my_then_var),$(my_else_var))
$(if $(or $a, $b, $c, $(and $d, $e)),$(my_then_var),$(my_else_var))
```

## foreach

```make
dirs := a b c d
files := $(foreach dir,$(dirs),$(wildcard $(dir)/*))
```

## sort

Sorting:
```make
sorted_list = $(sort $(files))
```

## lastword

Take last:
```make
last_file = $(lastword $(files))
```

## filter

Filtering object files from a list:
```make
objs=$(filter %.o,$(files))
```

Filtering out some files from a list:
```make
objects=main1.o foo.o main2.o bar.o
mains=main1.o main2.o
$(filter-out $(mains),$(objects))
```

## firstword

Take first:
```make
first_file = $(firstword $(files))
```

## Built-in variables

Current directory of makefile:
```make
$(CURDIR)
```

Get list of included makefile from first to last:
```make
list = $(MAKEFILE_LIST)
```

Get current makefile path:
```make
current_makefile_path = $(lastword $(MAKEFILE_LIST))
```

List of goals/targets specified on command line:
```make
$(MAKECMDGOALS)
```

Make command that has been used to run this session:
```make
$(MAKE)
```

## Compiler variables

CC          C Compiler
CPP         C PreProcessor
CXX         C++ Compiler
CFLAGS
CPPFLAGS
CXXFLAGS
LDFLAGS     Linker

## Variables

Assignment operators:
```make
CC = gcc3 # Override any definition in the environment but is overriden by any definition on make command line like `make CC=gcc4`.
CC ?= gcc3 # This is a GNU Make specific operator. It only sets CC localy if it hasn't been set in the environment, so it is overriden by the command `CC=gcc4 make` and also by `make CC=gcc4`.
myvar := ... # No recursive expansion.
myvar ::= ... # No recursive expansion.
myvar != ls *.txt # Set to the output of a shell command.
```

Define a variable on multiple lines:
```make
define two-lines
echo foo
echo $(bar)
endef
```

Override command-line variable definitions:
```make
override myvar = toto
```

Automatic variables:

Var  | Description
---- | ----------------
`$@` | Target.
`$%` | The target member name. If the target is `foo.a(bar.o)` then `$%` is `bar.o` and `$@` is `foo.a`.
`$<` | First prerequisite.
`$?` | Prerequisites newer than target.
`$^` | All prerequisites.
`$+` | All prerequisites, including duplicated ones, with preserved order.
`$*` | The stem for an implicit rule. If the target is `dir/a.foo.b` and the target pattern is `a.%.b` then the stem is `dir/foo`.

Target specific variables:
```make
prog: CFLAGS = -g
prog: prog.o foo.o bar.o
```

Printing variables:
```make
print-%:
	@echo $* = $($*)
```
To use it, run:
```bash
make print-myvar
```

Export variables:
```make
export myvar=blabla
export var1 var2 var3 ...
```

Write a big variable inside a file:
```make
objects.lst:
	$(foreach OBJ,$(OBJECTS),$(shell echo "$(OBJ)">>$@))
```
Or (but doesn't work for me):
```make
objects.lst:
	echo > $@ <<EOF      $(OBJECTS)
```

## value

The value function provides a way for you to use the value of a variable without having it expanded.
```make
FOO = $PATH
all:
	@echo $(FOO)        # Prints "ATH".
	@echo $(value FOO)  # Prints content of PATH env var.
```

Can be use to get a variable's value by constructing dynamically its name:
```make
joe_arg=--optimize
william_arg=--debug
name=joe

all:
	@echo $(value $(name)_arg)
```

## eval

Define new makefile constructs that are not constant; which are the result of evaluating other variables and functions. The argument to the eval function is expanded, then the results of that expansion are parsed as makefile syntax. The expanded results can define new make variables, targets, implicit or explicit rules, etc.
```make
generated-file.cpp: some-data-file
	generate-file <$< >$@
	$(eval sources+=$@)
```

Secondary Expansion:
```make
.SECONDEXPANSION:
ONEVAR = onefile
TWOVAR = twofile
myfile: $(ONEVAR) $$(TWOVAR)
```

## Target commands

```make
mytarget:
	-rm -f somefile				# '-' tells to not stop if command fails
	@echo toto            # '@' tells to not print the command
```

## shell

```make
myvar2=$(shell uname)
```

The variable SHELL is set by default to /bin/sh.
To change the default shell used by make, one must update the value of the SHELL variable inside a Makefile.
The value of the SHELL environment variable isn't used and doesn't affect the SHELL make variable. The SHELL environment variable is however exported to recipe lines make invokes.

## VPATH

VPATH (Virtual search PATH) is used by make to find dependencies when it can't find them relative to current directory.

```make
VPATH=/some/dir:/another/path/to/a/dir
```

## Strings

```make
objs=a.o b.o c.o
sources=$(objs:.o=.c)
sources=$(objs:%.o=%.c)
sources=$(patsubst %.o,%.c,$(objs))
sources=$(addprefix src/,foo bar) # produces 'src/foo src/bar'
sources=$(addsuffix .o,foo bar) # produces 'foo.o bar.o'
first = $(firstword $(sources)) # get first string
last = $(lastword $(sources)) # get last string
cleaned = $(strip $(sources)) # Removes leading and trailing whitespace and replaces each internal sequence of one or more whitespace characters with a single space.
```

Substituting characters:
```make
$(subst :, ,$(VPATH))
```

Joining (concatenating) space separated strings inside a variable:
```make
comma:= ,
empty:=
space:= $(empty) $(empty)
foo:= a b c
bar:= $(subst $(space),$(comma),$(foo))
```
bar is 'a,b,c'.

## File system

```make
myvar1=$(wildcard *.jpg)
dir = $(dir $(file))
filename = $(notdir $(file))
suffix = $(suffix file1.c file2.o file3.c) # --> .c .o .c
basename = $(basename file1.c titi/file2.o file3.c) # --> file1 titi/file2 file3
current_dir = $(dir $(lastword $(MAKEFILE_LIST)))
```

Get real path (remove `.`, `..`, repeated `/` and resolve symlinks. It also checks for path existence and returns the empty string if it does not exist:
```make
myrealpath=$(realpath $(CURDIR)/../zap)
```

Get absolute path. Like `realpath` but without resolving symlinks and without checking for existence:
```make
myabspath=$(abspath $(CURDIR)/../zap)
```

## Functions

Functions are defined as variables, but use `$(*)` parameters:
```make
reverse = $(2) $(1)
```
Call the function:
```make
foo = $(call reverse,a,b)
```

Use a function to generate rules:
```make
define PROGRAM_template
$(1): $$($(1)_OBJS) $$($(1)_LIBS:%=-l%)
ALL_OBJS   += $$($(1)_OBJS)
endef
```
Run the function:
```make
$(foreach prog,$(PROGRAMS),$(eval $(call PROGRAM_template,$(prog))))
```

## include

Include another makefile:
```make
include toto.mk
include mymakefile
```

Generating a makefile and loading it:
```make
include mymakefile
mymakefile:
	create-my-makefile
```
or
```make
include *.d
%.d: %.c
	create-dependencies <$< >$@
```

## Intermediate files

Intermediate files are files that are produced only to produce other files, and are not asked to be produced explicitly.
Common intermediate files are the ones produced by chain of implicit rules.

Such intermediate files are removed by make when the final target has been produced.

To keep intermediate files, they can listed as prerequisites of the special target `.SECONDARY`, or of the special target `.PRECIOUS`.

On the contrary, if an explicitly produced file is not wanted, it can be marked as intermediate by setting it as prerequisite of the special target `.INTERMEDIATE`.

## Generic rules

```make
PROGRAMS    = server client

server_OBJS = server.o server_priv.o server_access.o
server_LIBS = priv protocol

client_OBJS = client.o client_api.o client_mem.o
client_LIBS = protocol

 # Everything after this is generic
.PHONY: all
all: $(PROGRAMS)

define PROGRAM_template
$(1): $$($(1)_OBJS) $$($(1)_LIBS:%=-l%)
ALL_OBJS   += $$($(1)_OBJS)
endef

$(foreach prog,$(PROGRAMS),$(eval $(call PROGRAM_template,$(prog))))

$(PROGRAMS):
	$(LINK.o) $^ $(LDLIBS) -o $@

clean:
	rm -f $(ALL_OBJS) $(PROGRAMS)
```

## Error, warning, info

Can be called outside target commands:
```make
$(error text...)
$(warning text...)
$(info text...)
```

## Example of Makefile for a unix software distribution

Project with a main Makefile and one inside src sub-directory.

The main Makefile:
```make
package = jupiter
version = 1.0
tarname = $(package)
distdir = $(tarname)-$(version)
export prefix = /usr/local
export exec_prefix = $(prefix)
export bindir = $(exec_prefix)/bin

all clean check install uninstall jupiter:
	$(MAKE) -C src $@

dist: $(distdir).tar.gz

$(distdir).tar.gz: FORCE $(distdir)
	tar chof - $(distdir) |\
	gzip -9 -c >$(distdir).tar.gz
	rm -rf $(distdir)

$(distdir):
	mkdir -p $(distdir)/src
	cp Makefile $(distdir)
	cp src/Makefile $(distdir)/src
	cp src/main.c $(distdir)/src

distcheck: $(distdir).tar.gz
	gzip -cd $+ | tar xvf -
	$(MAKE) -C $(distdir) all check
	$(MAKE) -C $(distdir) DESTDIR=$${PWD}/$(distdir)/_inst install uninstall # not the of use of DESTDIR for staged installation.
	$(MAKE) -C $(distdir) clean
	rm -rf $(distdir)
	@echo "*** Package $(distdir).tar.gz ready for distribution."

FORCE:
	-rm $(distdir).tar.gz &> /dev/null
	-rm -rf $(distdir) &> /dev/null

.PHONY: FORCE all clean check dist distcheck
.PHONY: install uninstall
```


The `src/Makefile` file:
```make

CC     = gcc
CFLAGS = -g -O2
 # CPPFLAGS =						# for C Pre-processsor

all: jupiter

jupiter: main.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $+ 

clean:
	-rm jupiter

check: all
	./jupiter | grep "Hello from .*jupiter!"
	@echo "*** ALL TESTS PASSED ***"

install:
	install -d $(DESTDIR)$(bindir)								# DESTDIR is used for staged installation (like when building a rpm package)
	install -m 0755 jupiter $(DESTDIR)$(bindir)

uninstall:
	-rm $(DESTDIR)$(bindir)/jupiter

.PHONY: all clean check install uninstall
```

## Pattern rule

```make
%.o : %.c ; command...
```

`%` is called the stem. It is at least one character long.

Prerequisite with no stem:
```make
%.t : data.txt ; command ...
```

Mix:
```make
%.a : %.b %.c data.txt ; command ...
```

The stem can be anywhere:
```make
uzn-%.o : %.c ; command ...
```

Example with multiple files to produce:
```make
%.tab.c %.tab.h: %.y
        bison -d $<
```
        
## Static pattern rules

```make
objects = foo.o bar.o

all: $(objects)

$(objects): %.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@
```

## Old fashioned suffix rules

```make
.c.o:
	$(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<
```

## Double-colon rules

Double-colon rules allows to generate the same target in different ways. The double-colon rules generating the same target are independent of each other.
They provide a mechanism for cases in which the method used to update a target differs depending on which prerequisite files caused the update, and such cases are rare.

When a target appears in multiple rules, all the rules must be the same type: all ordinary, or all double-colon. 

## Prerequisites generation

C compilers allow to generate header dependencies in make-style, using -M option.
The command:
```make
	cc -M main.c
```
will generate:
```make
main.o : main.c defs.h
```

Example:
```make
%.d: %.c
	set -e; $(CC) -M $(CPPFLAGS) $< \
	| sed 's/\($*\)\.o[ :]*/\1.o $@ : /g' > $@; \
	[ -s $@ ] || rm -f $@

sources = foo.c bar.c

include $(sources:.c=.d)
```

## Dot-rule targets

targets declared as phony (`.PHONY`) tell make that they don't generate files
```make
.PHONY: all clean dist
```

Targets declared as precious (`.PRECIOUS`) aren't deleted in case make is killed and/or the target is an intermediate file.

## FORCE phony target

Force rebuild of a target, and run some commands before.

```make
mytarget: FORCE

FORCE:
	run_some_commands

.PHONY: FORCE
```
