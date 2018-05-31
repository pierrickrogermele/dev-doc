BASH
====

## `.bashrc`, `.bash_profile`, `.bash_logout`

`.bashrc`:
bash run command file ("rc" stands for "run command", which means that the file is executed/read when bash command is run/started) when invoked as an interactive non-login shell.
i.e.: .bashrc is read when bash is executed or when a new terminal/shell window is opened under the window system --> = new bash instance

`.bash_profile`:
personal initialization file
Sourced when started in interactive login mode (from ssh login or OS login in console mode).
/etc/profile is read first, then :  first of ~/.bash_profile, ~/.bash_login, or ~/.profile.
executed/loaded when run as interactive login shell.

`~/.bash_logout`:
executed when exiting from login shell


Use code from another file:
```bash
. myfile
source myfile
```

## History

To call the last command begining with a sequence of chars:
```bash
!mycmd
```

To call the last command containing a sequence of chars:
```bash
!?sometext
```

To search in history: ctrl-r

To list all commands with their history number:
```bash
history
```

To run a command by its history number:
```bash
!<history number>
```

## `ulimit`

To run a program without stack limit:
```bash
ulimit -s unlimited ; ./myprog
```

## `trap`

Define a command to execute when receiving a signal:
```bash
trap "rm $my_file; exit" SIGHUP SIGINT SIGTERM
```

## Timeout

In order to run a program and kill after some time, run:
```bash
myprog & sleep 5 ; kill $!
```

See <http://stackoverflow.com/questions/687948/timeout-a-command-in-bash-without-unnecessary-delay> for a generic script.

## Debugging a script

THe `-x` option displays each line of the script:
```bash
bash -x myscript.sh
```

## Program name

```bash
script_name="${0##*/}"
script_dir="${0%/*}"
```

## Prompt

```bash
PS1="\[\033[0;33m\][\$(date +%H%M)][\u@\h:\w]$\[\033[0m\] "
export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
```
Backslashed brackets are here to enclose command characters that control coloring. This allows bash to isolate those characters and do not count them when computing prompt length. Prompt length is needed when going backward into previous commands, searching into previous commands, wraping and going to the beginning of line.

Escape sequence | Description
--------------- | ----------------------
`\w`            | Full path of current directory.
`\W`            | Current directory.
`\u`            | User name.
`\h`            | Host name.

## `echo`

 * [Moving cursor](http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x361.html).

To print in color, one must the -e option and the escape character (`\e`, `\033` or `\x1B`):
```bash
echo -e "\e[31mHello World\e[0m"
echo -e "\033[31mHello\e[0m World"
```
The escape sequence `\e[0m` disable coloring.

If the -e option does not work in the terminal (like in OS-X), use the $'' feature of bash:
```bash
echo $'\e[34mCOLORS\e[0m'
```

Dark color  | Value | Light color  | Value
----------- | ----- | ------------ | -----
Black       | 0;30  | Dark Gray    | 1;30
Red         | 0;31  | Light Red    | 1;31
Green       | 0;32  | Light Green  | 1;32
Brown       | 0;33  | Yellow       | 1;33
Blue        | 0;34  | Light Blue   | 1;34
Purple      | 0;35  | Light Purple | 1;35
Cyan        | 0;36  | Light Cyan   | 1;36
Light Gray  | 0;37  | White        | 1;37

Printing in italics:
```bash
echo $'\E[3m some text in italics \E[23m'
```
Not all terminals can handle italics. MacOS-X Terminal cannot. However iTerm2 is replacement to Terminal that handles italics.
However the terminal info bust be changed in order to achieve italics handling with iTerm2 :
  1. Choose a font in iTerm2 that provides italics.
  2. Create a file `xterm-256color-italic.terminfo` and paste the following text in it:
		xterm-256color-italic|xterm with 256 colors and italic,
		sitm=\E[3m, ritm=\E[23m,
		use=xterm-256color,
  3. run `tic xterm-256color-italic`.
  4. Modify iTerm2 settings, and set terminal to `xterm-256color-italic`.
`screen` cannot handle italics, even inside iTerm2.

## Redirections

Redirection and pipe:
```bash
myprogram < somefile		# redirect STDIN
myprogram > someotherfile	# redirect STDOUT
myprogram | someotherprogram	# pipe STDOUT
myprogram 2>err.log		# redirect STDERR
myprogram 2>/dev/null		# discard STDERR (put into null device)
myprogram >myfile.log 2>&1	# redirect both STDOUT and STDERR into a log file
myprogram 2>&1 >myfile.log 	# redirect STDOUT to a file and STDERR to original STDOUT (not to the file)
myprogram >&2			# redirect STDOUT to STDERR
myprogram &>somefile		# redirect all outputs to a file
myprogram &>/dev/null		# silence all outputs
```

## Alias

Creating an alias:
```bash
alias blabla='echo coucou'
```

Removing an alias:
```bash
unalias blabla
```

## Variables

Declaring a typed variable:
```bash
declare -r CST=12   # read-only variable (= constant)
declare -i n        # integer variable
declare -a arr      # indexed array
declare -A arr      # associative array (not available in bash 3.2)
declare -f fct      # function
declare -x VAR      # export variable in environment
```

Declaring a local variable:
```bash
function myfct {
	local i=0
}
```

Default value set if variable is unset or null:
```bash
myvar2=${myvar1:-default value}
```
If the colon is omitted, the default value is set only if the variable is unset:
```bash
myvar2=${myvar1-default value}
```

Value replaced if variable is neither unset nor null:
```bash
myvar2=${myvar1:+value}
```
If the colon is omitted, the value is replaced also if the variable is null:
```bash
myvar2=${myvar1+value}
```

Dereferencing a variable:
```bash
toto=coucou
varname=toto
echo ${!varname}
eval echo '$'$varname
```

Dynamic variable names:
```bash
toto_email=zozo@gmail.com
account=toto
varname=${account}_email
email=${!varname}
```
See example `examples/bash/dyn_ref_var`.

It's also possible to use the `declare` keyword:
```bash
declare "${account}_email=zozo@gmail.com"
```

## Arrays

 * [The Ultimate Bash Array Tutorial with 15 Examples](http://www.thegeekstuff.com/2010/06/bash-array-tutorial).

Declaring an array:
```bash
my_array=(apple pear lemon "pink lady")
```
or
```bash
declare -a my_array=(apple pear lemon)
```

Push a value into an array:
```bash
myarr+=('newval')
```

Getting first value of an array:
```bash
${my_array[0]}
```

Getting all values of an array:
```bash
${my_array[@]}
```

Getting number of values (length, size) of an array:
```bash
${#my_array[@]}
```

Iterate over all elements of an array:
```bash
for e in ${my_array[@]} ; do
	# ...
done
```

Read an array from a file:
```bash
myarr=($(cat myfile))
```

Use quotes if elements contain spaces:
```bash
for e in "${my_array[@]}" ; do
	# ...
done
```

It's also possible to define associative arrays (from bash 4):
```bash
declare -A my_array
my_array[some_key]=some_value
echo ${my_array[some_key]}
keys=${!my_array[@]}
```

Join elements of an array (see [Join elements of an array?](https://stackoverflow.com/questions/1527049/join-elements-of-an-array)):
```bash
function join_by { local IFS="$1"; shift; echo "$*"; }
join_by , a "b c" d #a,b c,d
join_by / var local tmp #var/local/tmp
join_by , "${FOO[@]}" #a,b,c
```

## Strings

Remove a part of a string:
```bash
echo ${MYVAR#a*o}	# Remove the shortest string a*o at the beginning of MYVAR
echo ${MYVAR##a*o}	# Remove the longest string a*o at the beginning of MYVAR
echo ${MYVAR%.*}	# Remove the shortest string .* at the end of MYVAR
echo ${MYVAR%%.*}	# Remove the longest string .* at the end of MYVAR
```

Test if a string contains another string:
```bash
if [[ $s1 == *$s2* ]] ; then
	# ...
fi
```

String extraction with regexp:
```bash
echo `expr match "$stringZ" '\(.[b-c]*[A-Z]..[0-9]\)'`
echo `expr "$stringZ" : '\(.[b-c]*[A-Z]..[0-9]\)'`
```

Convert a string to lowercase:
```bash
echo $MY_VAR | tr '[:upper:]' '[:lower:]'
```

Get the length of string variable:
```bash
str=abcd
echo ${#str}
```

## Pattern expansion

To set a variable to a path with expansion:
```bash
mypath=$(echo /my/path/to/some/text/file/*.txt)
```

By default:
```bash
for f in *.txt ; do
		echo $f
done
```
will print `*.txt` literaly if no `.txt` file exists.
To get an empty string when no file exists, the following option must be set:
```bash
shopt -s nullglob # make glob pattern yelds empty string if no file exists.
```

## [[ Test operator - Double bracket

Bash defines a special double bracket `[[` operator for testing, similar to the `[` (or `test`) command line program.

Quoting of variable is not required with bash `[[` operator:
```bash
[[ -z $MYVAR ]] || exit 1
```

The logical AND and OR binary operator are the same than in C language:
```bash
[[ -z $MYVAR1 && -n $MYVAR2 ]] || exit 1
[[ -z $MYVAR1 || -n $MYVAR2 ]] || exit 1
```

## Command line arguments

Several variables allow to access command line arguments:

Variable | Description
-------- | ------------------------------------------
`$#`     | The number of arguments.
`$*`     | 
`"$*"`   | All of the positional parameters, seen as a single word.
`$@`     |
`"$@"`   | Same as `$*`, but each parameter is a quoted string, that is, the parameters are passed on intact, without interpretation or expansion. This means, among other things, that each parameter in the argument list is seen as a separate word.

Shift command line arguments:
```bash
shift # shift by 1
shift 3 # shift by 3
```

Using getopts:
```bash
function read_args {
	while getopts "hm:o:" flag ; do
		case $flag in
			h) print_help ; exit 0 ;;
			m) msg=$OPTARG ;;
			o) origin=$OPTARG ;;
		esac
	done
	shift $((OPTIND - 1))
}
```
Then you can use this function as is:
```bash
read_args "$@"
```

Unfortunately `getopts` is limited to short options.
There is a unix tool (`getopt`) that is able to parse long options, however it fails on arguments containing spaces. Moreover implementations differ between Linux and BSD, and only the GNU version works.
A better (and more common) approach is to implement the parsing (see <http://mywiki.wooledge.org/BashFAQ/035>):
```bash
function get_opt_val {
	if [ -z "$2" ] ; then
		printf "ERROR: \"$1\" requires a non-empty option argument.\n" >&2
		exit 1
	fi
	echo $2
}

while true ; do
	case $1 in
		-f|--file) g_param_file=$(get_opt_val $1 $2) ; shift 2 ;;
		*) break
	esac
done
```

## Get directory of executing script

```bash
scriptdir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
```

## Arithmetic operator `((...))`

Compute an equation:
```bash
((y=x*4+1))
```
or
```bash
y=$((x*4+1))
```

Rename files with numbers:
```bash
i=0 ; for f in *.JPG ; do ((i=i+1)) ; g=`printf p%03d.jpg $i` ; mv "$f" "$g" ; done
```

## Random numbers

Get a random number between 0 and 32767:
```bash
n=$RANDOM
```

## `if`, `then`, `else`

```bash
if [ -f $file ] ; then
	# some code...
elif [ -d $dir ] ; then
	# some other code...
else
	# ...
fi
```

## `while`

```bash
while true ; do
	if [ -z "$var" ] ; then
		break;
	fi
done
```

## `for`

For loop:
```bash
for f in $files ; do
	# some code...
done
```

Looping with a number:
```bash
for((i=0;i<10;++i)) ; do echo $i; done
```

Continue & break:
```bash
for f in $files ; do
	# some code...
	if ... ; then
		continue
	fi
	if ... ; then
		break
	fi
done
```

Change of character separator in a loop:
`IFS` is a built-in variable that stores the characters used to separate elements of a list. By default it is set to space, tabulation and new line, but it can be set to any value.

To loop on elements of a list separated by colon (like in `PATH`):
```bash
oldifs=$IFS
IFS=:
for p in $PATH ; do
	echo $p
done
IFS=$oldifs
```

## `case`

Case statement:
```bash
case $var in
		45 ) echo case number 1;; # test figure
		[AaBbCc] ) echo case number 2;; # characters
		[1-6] ) echo case number 1;; # test figures range
		toto | titi) echo case number 1;; # test string
		* ) echo default case;;
esac
```

## `read`

reading a file inside current bash instance:
```bash
while read line ; do
	# do something with $line
done < $myfile
```
or using a subshell (variables set inside the while loop will not be available outside):
```bash
cat $myfile | while read line ; do
	# do something with $line
done
```

Reading a variable containt:
```bash
while read line ; do
	# do something with $line
done <<< $lines
```

Read an answer:
```bash
while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
```

## `select`

Select (user choice):
```bash
echo "Do you wish to install this program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install; break;;
        No ) exit;;
    esac
done
```

## Exit status

Test command exist status:
```bash
if my_command ; then
		# do something on success
else
		# do something on failure
fi

if ! my_command ; then
		# do something on failure
fi

if [ $? -gt 0 ] ; then
		# an error occured
fi
```

## Functions

Define function:
```bash
function my_func {
		var1=$1
		var2=$2
}
```

Call function:
```bash
my_func arg1 arg2
my_func "$@" # calls with all arguments from command line
```

Function returning a string:
```bash
function my_func {
	echo "my string"
}
```

Function returning a status:
```bash
function my_func {
	return 1
}
```
status testing is done with `$?`.

Function returning nothing:
```bash
function foo {
	if [ -z "$myvar" ] ; then
		return
	fi

	# do something
}
```

Calling a function and testing the value returned:
```bash
if [ `my_func` = "some string" ] ; then
		echo yes
fi
```

## Evaluation

Backticks and $() are used to run a command and get its output:
```bash
a=`ls -1`
b=$(ls -1)
```
Bash introduced $() format instead of backsticks because it allows multiple nesting.

## `eval`

`eval` is a POSIX keyword (see [POSIX man page](http://www.unix.com/man-page/posix/1posix/eval/)) which evaluates an expression, replacing variables in it.

```bash
x=12
y='$'x
echo $y # will print '$x'
```

```bash
x=12
y='$'x
eval echo $y # will print '12'
```

## `bind`

To list all possible Readline functions:
```bash
bind -l
```

To list all possible Readline functions along with their key bindings:
```bash
bind -P
```

To bind C-b to beginning of line (in addition to C-a):
```bash
bind '"\C-b":beginning-of-line'
```
