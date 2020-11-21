<!-- vimvars: b:markdown_embedded_syntax={'sh':'bash','bash':'','awk':''} -->
# awk

## Running

Run an Awk script:
```bash
awk -f myscript.awk
```

Run on a file:
```bash
awk '// { print $0 }' myfile
```

Passing variables:
```bash
awk -v var=value ...
```

Using a shebang:
```awk
 #!/usr/bin/env awk -f
{ print $1 }
```

## Records and rules

Rules apply on record (a record is a line, by default, depending of the definition of the record separator (`RS`)).

General form of a rule is `[pattern] [{ action }]`.

All rules are processed in order, one after the other.
The 'next' statement can be used to stop processing rules and pass to the next record.
```awk
/some regexp patterm/ { next }
```

Any expression can be used for a pattern, if it is true, the rule is executed:
```awk
expression {}
```

A pattern can be a regular expression:
```awk
/regular expression/ {}
```

Range pattern:
```awk
pat1, pat2 {}
```

Start and end patterns:
```awk
BEGIN { print "START !" }
END { print "DONE !" }
```

The null pattern matches every input record:
```awk
{print} 
```

A pattern can be negated:
```awk
! /regexp/
```

Patterns can be combined:
```awk
/regexp1/ && /regexp2/
/regexp1/ || /regexp2/
```

## Regex

The match function can be used in a pattern expression to get captured group in a regular expression:
```awk
match($NF, /^([0-9]+)h$/, g) { time += g[1] }
```

Regexp on a particular field:
```awk
$2 ~ /ddd/
$3 !~ /aa/
```

## Strings

Getting length:
```awk
{ l = length(s) }
```

Lowercase:
```awk
{ lc = tolower(s) }
{ uc = toupper(s) }
```

Split a string:
```awk
{ number_of_elements = split(string, array, fieldsep) }
```

## Function

Declaration:
```awk
function name (parameters) {
	# body
}
```	
All other variables (global) are normally accessible from inside a function body, and thus can be modified.

The parameters contain : the arguments passed to the function AND the local variables declaration.

The parameters declared (arguments and local variables) hide the global variables of the same name.

The parameters that don't receive a value from the function caller, are set to the null string.

A common practice is to separate arguments and local variables declarations by spaces in the function header.

```awk
function abs(v) { return v < 0 ? -v : v }
```

## Built-in variables

`FILENAME` is the name of the current file:
```awk
{print FILENAME;}
```

`NR` is the row number (from the start of input):
```awk
{if (NR!=1) {print}}
```

`NFR` is the row number inside the current file:
```awk
{print FILENAME, FNR;}
```

`NF` is the number of fields in a record (i.e.: row):
```awk
{print NF;}
```

Input field separator (space by default):
```awk
BEGIN{FS = "\t"}
```

Input record separator (end-of-line by default):
```awk
BEGIN{RS = ";\n"}
```

Output field separator (space by default):
```awk
BEGIN{OFS = "\t"}
```

Output record separator (end-of-line by default):
```awk
BEGIN{ORS = ";\n"}
```

## Getting command line arguments

For Awk, the command line arguments are a list of files.
To get the filename currently being processed by Awk, use the built-in variable `FILENAME`:
```awk
{ print FILENAME }
```

Reading command line arguments:
```awk
BEGIN {
	for (i = 1; i < ARGC; i++)
		printf "%s ", ARGV[i]
	printf "\n"
}
```

The problem is that awk interprets command line arguments as files, and try to open them.
The only exception is when a argument is of the form `var=value`, in which case awk will set the variable `var` to the value "value".
A cleaner way to do this is to use the `-v` option:
```bash
awk -v var=value
```

## Statements

### If

```awk
{ if (NR == 3) { print } }
{ if (NR > 1 && ) { print } }
```

### Switch
	
The switch statement is an optional statement for the GNU version of Awk, that must be included at compile time with the option --enable-swtich passed to configure script.

## Removing columns

Removing two first columns:
```awk
{$1=$2="";sub("  "," ")}1
```

Removing 8th column, using tabulation as a separator:
```awk
BEGIN{FS=OFS="\t"} {$8="";sub("\t\t","\t")}1
```

## Print

Printing fields:
```awk
print a, b, c, d
```

Print fields and strings:
```awk
print $2":"$3":"$4" "$5"-"$6
```

Extract first column:
```bash
awk '{print $1}' spiid-inchi.txt >myids.txt
```

Remove duplicates on output:
```bash
awk '!x[$0]++'
```

## Mathematical operations

Take absolute value:
```awk
function abs(v) { return v < 0 ? -v : v }
{ printf("%f\n", abs($1-$2)) }
```

Summing on a column:
```awk
{ sum += $2 }
END { print sum }
```

Taking the integer part of float:
```awk
{ i = int(f) }
```

Rounding a float to an integer:
```awk
{ i = int(f + 0.5) }
```

## Arrays

In awk arrays are associative.
	
Looping on an (numerically) indexed array:
```awk
for (i = 1 ; i <= size_of_array ; ++i)
	print array[i]
```

Looping on array indexes:
```awk
for (k in array)
	print k
```

Sorting an array (the array must be numerically indexed):
```awk
{ n = asort(array) } # n is the number of elements of the array
{ n = asorti(array) } # case insensitive
```


