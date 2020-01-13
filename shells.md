SHELLS
======

 * [Interactive and non-interactive shells and scripts](http://www.tldp.org/LDP/abs/html/intandnonint.html).

`~/.xessionrc` is read when loging graphically under Debian familly systems.
 * [Difference between .xinitrc, .xsession and .xsessionrc](https://unix.stackexchange.com/questions/281858/difference-between-xinitrc-xsession-and-xsessionrc).

## SH

sh doesn't accept `for ((...` statement structure. It's reserved to bash.

## ZSH

`which` is a built-in command in zsh, that returns "<command> not found" on stdout when failing.

## SHEBANG

Shebang (SHarp BANG or haSH BANG) is the first line in script, indicating the interpreter to run:
```bash
#!/bin/bash
```

One can pass arguments to the interpreter:
```python
#!/usr/bin/python -c
```

Full path of the interpreter is compulsory.

In order to avoid specifying full path for the interpreter, one can invoke it through the env command which most of the time resides in /usr/bin/env (except in Unicos and OpenServer)
```perl
#!/usr/bin/env perl
```

## CMD

See this [A-Z Index](http://ss64.com/nt/) for a list of all commands.

### Run

Get list of options:
```dosbatch
CMD /?
```

Run a command and exit:
```dosbatch
CMD /C my command ...
```

### Command line arguments

To get the path used to execute the script:
```dosbatch
%0
```

To know the directory of the executing script:
```dosbatch
%~dp0
```

Arguments:
```dosbatch
%1
%2
rem ...
%9
```

All parameters:
```dosbatch
%*
```

Shift the position of replaceable parameters in a batch file (internal command):
```dosbatch
shift
shift /5
```

### Current directory

Get current directory:
```dosbatch
echo %cd%
```

### Change directory

Change Directory - move to a specific Folder (internal command):
```dosbatch
cd mynewdir
```

Move to current disk root:
```dosbatch
cd \
```

Using current directory stack:
```dosbatch
pushd mytemporarydir
rem do some stuff
popd
```

### If

Test if a file or directory exists:
```dosbatch
if exist "C:\My\Path\To\A\File.txt" ...
```

Use quotes for variables, in case there are special characters like spaces:
```dosbatch
if exist "%my_file%" ...
```

Negate condition:
```dosbatch
if not exist "%my_file%" ...
```

Test variable:
```dosbatch
if "%myvar%" == "value" ...
if not "%myvar%" == "" ...
```

### Strings

When defining a string, you can escape some special characters `[()>< ]` by using caret `^`:
```dosbatch
set myvar=Some^ Value
```

### Set

`set` definition can be enclosed in quotes.
Be careful not to put space before the equal sign:
```dosbatch
set "myvar=some value"
```

### Echo

Setting command echoing off:
```dosbatch
@echo off
```

### Loop

For loop on command line:
```dosbatch
for %i in (1 2 3 4) do echo %i
```

For loop in a batch file:
```dosbatch
for %%i in (1 2 3 4) do echo %%i
```

For loop on multiple lines:
```dosbatch
for %%i in (1 2 3 4) do (
echo %%i
some_program %%i
)
```

Appending value to a variable inside a for loop doesn't work by doing it directly like:
```dosbatch
for %%f in (*.jar) do (set CLASSPATH=%CLASSPATH%;%%f)
```
It must be done by definning a function:
```dosbatch
for %%f in (*.jar) do (call :set_classpath "%%f")

:set_classpath
        (set CLASSPATH=%CLASSPATH%;%1)
:EOF
```

### Environment variables

Display variables:
```dosbatch
set
```

Changes will disappear after script finishes:
```dosbatch
SET myvar
SET myvar=somevalue
```

Permanent changing of environment variables. Changes will stay after end of script:
```dosbatch
SETX myvar myvalue
SETX myvar myvalue -m
```

### Comments

```dosbatch
rem mycomment
:: another comment
```

### Function

```dosbatch
for %%i in (1 2 3 4 5) do CALL:MYFUNC %%i
GOTO:EOF

:MYFUNC
echo %~1

:EOF
```

### Where

Find an executable in the PATH (equivalent of UNIX which command).

### Copy & xcopy

Copy one or more files to another location (internal command):
```dosbatch
COPY myfile1.txt ..\toto\myfile1_renamed.txt
```

Copy into a directory:
```dosbatch
xcopy /Y myfile1 mydir
```
`/Y` avoid prompting if destination file exists.

### Remove, delete

Remove file:
```dosbatch
DEL myfile
```

Remove a directory:
```dosbatch
RD mydir
RMDIR mydir
RMDIR /Q mydir		REM /Q: do not ask confirmation
```

Delete a directory tree:
```dosbatch
RMDIR /S /Q mydir		REM >= Windows 2000
DELTREE mydir			REM < Windows 2000
```

### Start

Start an application:
```dosbatch
START /WAIT /MIN myapp
```
