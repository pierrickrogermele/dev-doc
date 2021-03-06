<!-- vimvars: b:markdown_embedded_syntax={'perl':'','perl6':''} -->
# PERL

 * [Writing better Perl - Tips and tricks to make Perl easier, faster, and more fun](http://www.sourceformat.com/pdf/perl-coding-standard-robert.pdf).

## Running

Shebang:
```perl
#!/usr/bin/perl -w
```
or safer (since perl may reside in another path):
```perl
#!/usr/bin/env perl
```

Set library path:
```perl
export PERL5LIB=$HOME/install-perl/lib
```

Run with warnings on:
```bash
perl -w ...
```

Can be used in shebang:
```perl
#!/usr/bin/perl -w
#!/usr/bin/env perl -w
```

The warnings pragma is a replacement for the command line flag -w , but the pragma is limited to the enclosing block, while the flag is global:
```perl
use warnings;
use warnings "all";
```

Strict directive:
```perl
use strict; # enable all
use strict "vars"; # enable only variable declarations checking
use strict "refs"; # enable only symbolic references checking
use strict "subs"; # enable only "subs" checking
```

## Modules

To get a list of installed modules:
```bash
perldoc perllocal
```

### Installing a module

On the following error (met when trying to install `Term::ANSIScreen` module): 
	Can't locate inc/Module/Package.pm in @INC (you may need to install the inc::Module::Package module) 
the solution is to install module `Module::Install`:
```bash
perl -MCPAN -e 'install Module::Install'
```

To uninstall a CPAN module:
```bash
rm -r /path/to/My/Module
```

#### perl -MCPAN

Launching CPAN:
```bash
perl -MCPAN -e shell
```

To install all standard CPAN modules:
```bash
perl -MCPAN -e 'install Bundle::CPAN'
```

To update CPAN:
```bash
perl -MCPAN -e 'install CPAN'
```

#### cpan

| Command                                       | Description
| --------------------------------------------- | ---------------------------
| `o conf init`                                 | Run configuration.
| `o conf mbuildpl_arg "--install_base ~/perl"` | Set installation directory.
| `o conf makepl_arg "PREFIX=~/perl"`           | Set installation directory.
| `install Chocolate::Belgian`                  | Install a module.
| `o conf urllist`                              | Get configured CPAN mirror list.
| `o conf urllist push http://my.mirror/`       | Add mirror.
| `o conf urllist pop`                          | Remove the URL at the end of the mirror list.
| `o conf urllist shift`                        | Remove the URL at the front of the mirror list.
| `o conf commit`                               | Save configuration.

Install a CPAN module directly from command line: 
```bash
cpan -i Chocolate::Belgian
```

To force an install, even when tests fail:
```bash
cpan -fi 'My::Module'
```

#### cpanminus

`cpanm` seems better (more up-to-date about dependencies) than `cpan`. To get
it, install package `cpanminus`, under Debian, macos or ArchLinux.
Or downloading from site:
```bash
curl -L http://cpanmin.us | perl - App::cpanminus
```

To update installed modules easily, use `cpan-outdated` with `cpanm`:
First install `cpan-outdated`:
```bash
cpanm App::cpanoutdated
```
then run:
```bash
cpan-outdated -p | cpanm
```
See [How do I update all my CPAN modules to their latest versions?](https://stackoverflow.com/questions/3727795/how-do-i-update-all-my-cpan-modules-to-their-latest-versions).

#### Install from a downloaded package

Install from a downloaded package, and set destination:
```bash
perl Makefile.PL PREFIX=/home/stas
```

### Loading a module

To add a path to `@INC`:
```perl
use lib "my/path/";
```

Load a module whose path is in `@INC`:
```perl
use MyModule;
```

Specify which function must be imported:
```perl
use MyModule qw(myfunc1, myfunc2);
```

Load a module whose path is relative to the executed binary:
```perl
BEGIN {
	use FindBin;
	use lib "$FindBin::RealBin/my/relative/path";
}

use MyModule;
```

### Creation of a module / package

The module file extension must be `.pm`.

A package (=namespace) can be declared:
```perl
package My::New::Class;
```

It is worth declaring the following builtin diretives:
```perl
use strict;
use warnings;
```

A version can be declared and later used by some special forms of "use" statement:
```perl
our $VERSION = "1.00";
```

Inheriting from Exporter module allows to choose which functions to export:
```perl
use base 'Exporter';
our @EXPORT = qw(myfunc); # defines which functions are exported by default
```

A Perl module must end with a true value:
```perl
1;
```

Private functions: there are no private functions in Perl. The convention is to prefix the function name with an underscore, to indicate that the function is internal.

The package directive declares a namespace for all the following declarations (variables and functions).
It's mainly used for declaring modules and classes (see corresponding files).
```perl
package My::Name::Space;
```

Main package:
```perl
package main;
```

## Types and variables

 * [Arrays vs. Lists in Perl: What's the Difference?](http://friedo.com/blog/2013/07/arrays-vs-lists-in-perl).

To force declaring variables:
```perl
use strict;
```

Get variable type:
```perl
ref($v);
```

### Undef

Unset a variable with `undef()` method:
```perl
undef $myvar;
```
or
```perl
$myvar = undef;
```

Test if a variable is set with `defined()`:
```perl6
if (defined $myvar) {
}
```

An undefined variable is silently replaced by `0` in a numerical context and by `""` in a string context.

### Integers

Truncate float to integer:
```perl
int($f);
```

Rounding:
```perl
my $round = int($num + 0.5);
```
or
```perl
use Math::Round qw/round/;
my $round = round($num);
```

Ceil & floor:
```perl
use POSIX;
ceil($f);
floor($f);
```

### Strings

Get string length:
```perl
my $length = length($s);
```

Get char code:
```perl
$n = ord($c);
```

Make char from code:
```perl
$c = chr($n);
```

Multi-lines string:
```perl
my $s = <<"END";
blabla
blabla
blabla
END
```

Get sub-string:
```perl
my $sub = substr($s, 4, 10); # offset, length
```

Set to lowercase:
```perl
my $lower_case = lc($upper_case);
```

Set to uppercase:
```perl
my $upper_case = lc($lower_case);
```

Removing end of line:
```perl
chop; # remove last character of $_ (not safe).
chomp; # remove $/ at the end of $_. $/ is set to \n by default.
s/\r$//; # removes \r at the end of $_.
chomp(my $var = $line);
```

Search string:
```perl
my $i = index($s, $substr, $pos);
```

Look for all regexp matches in a string:
```perl6
while ($s =~ m/[A-Z]+/g) {
}
```

Removing trailing whitespaces: --> no trim function.

Comparing strings:
```perl
if $s1 eq $s2; # ==
if $s1 ne $s2; # !=
if $s1 lt $s2; # <
if $s1 le $s2; # <=
if $s1 gt $s2; # >
if $s1 ge $s2; # >=
$s1 cmp $s2; # compare
```

Repeating a string:
```perl
my $s = "mystring" x 4;
```

Replace:
```perl
$s =~ s/aaa/bbb/;
```

Affect and replace:
```perl
my $s =~ s/aaa/bbb/;
```

Copy and replace:
```perl
(my $s = $r) =~ s/aaa/bbb/;
```

Replace with substring:
```perl
$s =~ s/^.* (\d+)$/$1/;
```

Joining values of an array into a string:
```perl
print join("\n", keys(%ENV));
```

Split:
```perl
my @array = split(/,/, $string);
```

Split and remove spaces:
```perl
my @vals = map { s/\s+$//; s/^\s+//; $_ } split(',', $args);
```

### Lists

A list of values:
```perl
(1, 2, 3, 4);
```

Initialization of an array with a list:
```perl
my @a = (1, 2, 3, 4);
```

Initialiazation of an hash with a list:
```perl
my @h = ( a => 1, b => 2, c => 3);
my @h = ( 'a', 1, 'b', 2, 'c', 3);
```
The `=>` operator is called the "fat comma" and has the effect to transform its left side into a string and become a coma.

### Arrays

Define an array:
```perl
my @arr = (1, 2, 3);
```

Define an array of strings:
```perl
my @arr1 = ('abc', 'def');
my @arr2 = qw(abc def);
```

Get a value from an array:
```perl
my $val = $arr[0];
```

Get size of an array:
```perl
my $size = @arr;
```

Last index of an array:
```perl
$#arr;
```

Loop on indices of an array:
```perl6
for my $i (0 .. $#myarr) {
	#...
}
```

Sort:
```perl
my @sorted_array = sort @array;
```

Sorting using your own comparison:
```perl
my @sorted = sort { $a <=> $b } @not_sorted; # sorts numerically
```

Operator slice: taking a subset of an array:
```perl
@myarray[1..4];
```

Push values:
```perl
push(@myarray, $myvalue);
push(@myarray, @myotherarray);
```

Splice:
```perl
splice(@a, @a, 0, $v);  # push $v at the end of $a
splice(@a, -1);         # pop last value from @a
splice(@a, 0,  0, $v);  # insert $v at beginning of @a
```

Search for a fixed value:
```perl
my @a = grep($_ eq 'mytext', @myarray);
```

Search for a regex:
```perl
my @a = grep(/^$myregex$/, @myarray);
```

Smartmatch (experimental):
```perl6
if ($someval ~~ @myarray) {
}
```

See `map` statement for applying a function on each element of an array.

See `Array::Utils` and `List::Util` for packages providing functions on arrays.

### Hashes

 * [Perl - Hashes](http://www.tutorialspoint.com/perl/perl_hashes.htm).
 * Deep hases, see Deep::Hash::Utils module.

Define a hash:
```perl
my %myhash = ('John Paul' => 45, 'Lisa' => 30, 'Kumar' => 40);
```

Test for existence:
```perl
exists($myhash{'Lisa'});
```

Deleting a key:
```perl
delete $myhash{$k};
```

Loop on all key/value pairs, without order:
```perl6
while (my ($key, $value) = each %hash) {}
```

Loop on all key:
```perl6
for my $k (keys %myhash) {}
```

Loop on all keys, sorted:
```perl6
for my $k (sort keys %myhash) { }
```

How to place a value in a hash using a list of nested keys:
```perl
$ref = \\%my_hash;
$ref= \$$ref->{$_} foreach @keys;
$$ref = $value;
```

### Environment variables

```perl
my $path = $ENV{PATH};
```

## Operators

 * [perlop](http://perldoc.perl.org/perlop.html).
 * On UNIX, run `man perlop`.

## Statements

### For

Loop with implicit iterator:
```perl6
foreach (@array) {
	print $_;
}
```
`for` is a synonym of `foreach`.

Loop with an explicit iterator:
```perl6
foreach my $v (@array) {
}
```

One line for loop:
```perl
print $_ foreach @myarray;
```

To leave a loop:
```perl6
foreach my $v (@array) {
	if ($v->{value})  {
		# ...
		last;
	}
}
```

To process next element:
```perl6
foreach my $v (@array) {
	if (...) {
		# ...
		next;
	}
	...
}
```

C style loop:
```perl6
for (my $i = 0 ; $i < 10 ; ++$i) {
}
```

### While

Loop on all key/value pairs of a hash:
```perl6
while (my ($key, $value) = each(%hash)) {
	print "$key -> $value\n";
}
```

### Switch

An experimental switch statement has been introduced in Perl 5.10.1.

```perl6
use feature "switch";
given($var) {
	when(/^aaa/) { do_something() }
	when(/bbb$/) { do_something() }
	when('q') { do_something() }
	default { do_some_other_thing() }
}
```

### Fork

 * [perlfork](http://perldoc.perl.org/perlfork.html).

```perl6
my $pid = fork();
die "fork() failed: $!" unless defined $pid;
if ($pid) {
	# parent
} else {
	# child
}
```

### map

To apply a function on each element of an array:
```perl
my @b = map { myfunc($_) } @a;
```

To transform an array:
```perl
my @new_list = map { s/aa/bb/g; $_ } @old_list; # --> @old_list is going to be transformed too !
my @new_list = map { my $i = $_ ; $i =~ s/aa/bb/g; $i } @old_list; # --> OK
map { s/aa/bb/g } (my @new_list = @old_list); # --> OK
```

### Sort

Sort alphabetically:
```perl
sort { $a cmp $b } @myarray;
```

Sort numerically:
```perl
sort { $a <=> $b } @myarray;
```

### Grep

Grep string:
```perl
my @result = grep("some text", @an_array);
```
TODO Check that it works:

Reversed grep:
```perl
my @new_list = grep(!/mypattern/, @old_list);
```

## Functions

Calling a function using a string:
```perl
my $fct_name = "foo";
&$fct_name();
&$fct_name($param);
&$fct_name($self, $param);
```
Note: this is forbidden while "strict refs" in use.

Using a dispatch table:
```perl
my %dispatch = (
	            'add' => \&my_fct_for_adding,
	            'mult' => sub { $self->call_method( @_ ) }
	            );
$dispatch{$action}->($a, $b);
```

Different function prototypes:
```perl
sub mylink ($$)	{}			  # mylink $old, $new
sub myvec ($$$)	{}        # myvec $var, $offset, 1
sub myindex ($$;$) {}	    # myindex &getstring, "substr"
sub mysyswrite ($$$;$) {} # mysyswrite $buf, 0, length($buf) - $off, $off
sub myreverse (@)	{}      # myreverse $a, $b, $c
sub myjoin ($@) {}	      # myjoin ":", $a, $b, $c
sub mypop (\@) {}         # mypop @array
sub mysplice (\@$$@) {}   # mysplice @array, 0, 2, @pushme
sub mykeys (\%)	{}        # mykeys %{$hashref}
sub myopen (*;$) {}	      # myopen HANDLE, $name
sub mypipe (**)	{}        # mypipe READHANDLE, WRITEHANDLE
sub mygrep (&@) {}	      # mygrep { /foo/ } $a, $b, $c
sub myrand (;$)	{}        # myrand 42
sub mytime ()	{}          # mytime
```
	
Taking any type of argument:
```perl
sub myref (\[$@%&*]) {} # will allow calling myref() as:
myref $var;
myref @array;
myref %hash;
myref &sub;
myref *glob;
```


### Recursivity

We must first declare the function prototype before definning a recursive function:
```perl
sub foo($);
sub foo($) {
	# ...
	foo($x);
	# ...
}
```
## References
	
To take a reference of a variable:
```perl
my $hash_ref = \%hash;
my $array_ref = \@array;
my $scalar_ref = \$scalar;
```

To create a reference to an anonymous array or hash:
```perl6
my $array_ref = ['a', 'b'];
my $hash_ref = {'a' => 1, 'b' => 2};
```
The perl interpretor can be confused between curly braces for blocks and those for hash ref.
To disambuiguate, use `{;}` for blocks and `+{}` for hash ref, or use return statements at right place:
```perl
sub hashem {       +{ @_ } }
sub hashem { return { @_ } }
sub showem {       {; @_ } }
sub showem { { return @_ } }
```

Taking reference of a list:
```perl
my @refs = \($a, @b, %c)
```
is the same as:
```perl
my @refs = (\$a, \@b, \%c)
```

To know if a var is a reference:
```perl
ref($var);
```
It returns one of: SCALAR, ARRAY, HASH, CODE, REF, GLOB, LVALUE.

To test if it is a reference:
```perl6
if (ref($var)) {
	# it's a reference
	if (ref($var) eq 'ARRAY') {
		# ...
	}
	elsif (ref($var) eq 'SCALAR') {
		# ...
	}
}
else {
	# it's not a reference
}
```

Compare references:
```perl6
if ($r1 == $r2) {
	# only works if r1 and r2 aren't object and haven't overloaded the value they return
}
```
Or use `refaddr()` function:
```perl6
use Scalar::Util 'refaddr';
if ($obj1 && ref($obj1) && $obj2 && ref($obj2) && refaddr($obj1) == refaddr($obj2)) {
		# objects are the same...
}
```

## Regex

Regexp match:
```perl6
if (/^a.*b$/) {} # match regexp against $_
if ($string =~ /.*aa/) {} # match with a specific variable
if (/^a.*b$/i) {} # match with case insensitive on
```

Get all matches:
```perl6
while ($s =~ m/[A-Z]+/g) {
}
```

Ungreedy matching: use ? marker.
The following regexp will set $name to the basename of the file path, without the extension:
```perl
(my $name = $file) =~ s!^(.*/)?([^/]+)\..+$!$2!;
```

Translate:
```perl
$s =~ tr/A/a/;
```

Shortcuts:
Code   | Description
------ | -------------------------------------------
`\w`   | Match "word" character (alphanumeric plus `_`)
`\W`   | Match non-word character
`\s`   | Match whitespace character
`\S`   | Match non-whitespace character
`\d`   | Match digit character
`\D`   | Match non-digit character
`\t`   | Match tab
`\n`   | Match newline
`\r`   | Match return
`\f`   | Match formfeed
`\a`   | Match alarm (bell, beep, etc)
`\e`   | Match escape
`\021` | Match octal char ( in this case 21 octal)
`\xf0` | Match hex char ( in this case f0 hexidecimal)

## File system

Removing directory tree:
```perl
use File::Path;
rmtree($dir);
```

Touch a file:
```perl
use File::Touch;
$count = touch(@file_list);
```

Get dirname and basename of a path:
```perl
use File::Basename;
$basename = basename($fullname, @suffixlist);
$dirname  = dirname($fullname);
($name,$path,$suffix) = fileparse($fullname, @suffixlist);
$name = fileparse($fullname, @suffixlist);
 # @suffixlist can contain regexp match:
fileparse("/foo/bar/baz.txt", qr/\.[^.]*/);
```

Returns the path where the symbolic link points to:
```perl
readlink($f) : 
```

Test a file type:
```perl6
if (-f $f) {...}
```
as in shell :
 * -f : regular file
 * -l : symbolic link
see -X function.

Concatenate file paths:
```perl
use File::Spec::Functions 'catfile';
my $fullpath = catfile("/some/path", 'another/path/to/my/file')
```

Get current working directory:
```perl
use Cwd;
my $dir = getcwd;
```

Get absolute path:
```perl
use Cwd 'abs_path';
my $abs_path = abs_path($file);
```

Make directory:
```perl
mkdir("mydir") || die "Error";
```

Rename a file:
```perl
rename $old_name => $new_name || die "Failed.";
```

### Listing files in a directory

Opening diretory:
```perl
opendir(DIR, "mydir");
my @files = readdir(DIR);
my @html_files = grep(/\.html$/,readdir(DIR));
closedir(DIR);
```

Glob `<>` operator for listing files in a folder:
```perl
my @f = <*.jp*>;
```

Set Glob options:
```perl
use File::Glob qw(:globally :nocase);
```

## I/O

### Opening & closing a file

Open a file for reading:
```perl
open(FILE_TAG, "<:utf8", "some file");
open(FILE_TAG, "<some file");
```

Open a file with specific encoding:
```perl
open(my $fh, "<:encoding(Latin1)", 'myfile.txt');
open(my $fh, "<:encoding(Windows-1252)", 'myfile.txt');
open(my $fh, "<:encoding(UTF-8)", 'myfile.txt');
```

Open a file for writing:
```perl
open(FILE_TAG, ">:utf8", "some file");
open(FILE_TAG, ">some file");
```

Close a file:
```perl
close(FILE_TAG);
```

Use a variable for the file descriptor:
```perl
open($fd, "<some file");
close($fd);
```

### Reading file

 * [How can I read in an entire file all at once?](https://metacpan.org/pod/perlfaq5#How-can-I-read-in-an-entire-file-all-at-once).

Load an entire file content into a scalar:
```perl6
my $var;
{
	local $/;
	open my $fh, '<', $file or die "can't open $file: $!";
	$var = <$fh>;
}
```

Read line by line:
```perl6
while(<STDIN>) {
	if (/sometext/) { # $_ is the line
		do_something($_);
		print "Line number is $.\n"; # $. is the line number
	}
}
```

Reading file descriptor:
```perl6
while(<FILE>) {
}
```

Using a variable:
```perl6
while (my $line = <FILE>) {
}
```

### Standard streams

Set a file descriptor with a standard stream:
```perl
my $fd = *STDOUT;
my $fd = *STDIN;
```

### Pipe

Read the output of a command with a pipe:
```perl
my $cmd = "wget -O - http://www.ecb.int/stats/eurofxref/eurofxref-hist.zip 2>/dev/null | funzip";
open($fd, "-|", $cmd);
```

### FIFO

```perl
use File::Temp qw/ :POSIX /;
use POSIX qw(mkfifo);
my $mplayer_fifo = File::Temp::tempnam(File::Spec->tmpdir(), "mplayerfifo");
mkfifo($mplayer_fifo, 0700) || die "Cannot create FIFO $mplayer_fifo.";
open(FIFO, ">$mplayer_fifo");
print FIFO "quit\n";
close(FIFO);
```
The process that opens for writing blocks until another process opens the same FIFO for reading.
In fact both processes blocks until both of them have open the FIFO for reading and writing.

### Printing

Print to stdout:
```perl
print "blabla\n";
```

Print to file:
```perl
print FILE "blabla\n";
```

Printf strings:
```perl
printf "<%s>", "a";       # prints "<a>"
printf "<%6s>", "a";      # prints "<     a>"
printf "<%*s>", 6, "a";   # prints "<     a>"
printf "<%*2$s>", "a", 6; # prints "<     a>"
printf "<%2s>", "long";   # prints "<long>" (does not truncate)
```

## Signals

Affecting a routine to a signal:
```perl
sub SeeYa { warn"Hasta la vista, baby!" }
$SIG{'TERM'} = SeeYa;
```

## Parser generation

 * [Parser Generation in Perl: an Overview and Available Tools](http://inforum.org.pt/INForum2010/papers/compiladores-e-linguagens-de-programacao/Paper083.pdf), Hugo Areias, Alberto Simões, Pedro Henriques, and Daniela da Cruz.

## Command line arguments

Program full path, it also contains the directory taken from `PATH` envvar:
```perl
my $cmd = $0;
```

Getting directory path and name of the running program:
```perl
use File::Basename;
my $SCRIPTNAME = basename($0);
my $SCRIPTPATH = dirname($0);
```

Reading command line arguments from `@ARGV`:
```perl
my $nb_args = $#ARGV;
my $first_arg = $ARGV[0];
```

## OOP

  * [Object Oriented Exception Handling in Perl](http://www.perl.com/pub/2002/11/14/exception.html).

To declare a new class, simply declare a package:
```perl
package My::New::Class;
```
	
As for modules creation, the following declaration can be useful:
```perl
use strict;
use warnings;
our $VERSION = "1.00";
```

### Constructor

Declaration:
```perl
sub new {
	my($class, %args) = @_;

	my $self = bless({}, $class);

	my $target = exists $args{target} ? $args{target} : "world";
	$self->{target} = $target;
	
	return $self;
}
```
	
Call:
```perl
my $obj1 = new MyClass;
my $obj2 = MyClass->create();
```

### Inheritance

```perl
use AutoLoader qw(AUTOLOAD);
```

The special array `@ISA` lists in order packages/classes that have to be searched when a function isn't found.

```perl
package UNIVERSAL;
	
sub AUTOLOAD { # The special function AUTOLOAD is called when a function isn't found. It can then be dynamically loaded.
	die("[Error: Missing Function] $AUTOLOAD @_\n"); # Here we just display an error stating the function doesn't exist.
}

package A;
sub foo {
	print("Inside A::foo\n");
}

package B;
our @ISA = qw(A);
```

### Introspection

Testing inheritance:
```perl6
if ($obj->isa('AClassName')) {
	# ...
}
```

Getting class name:
```perl
use Scalar::Util 'blessed';
my $classname = blessed($obj);
```

## Errors and warnings

 * [Exception handling in Perl: How to deal with fatal errors in external modules](https://perlmaven.com/fatal-errors-in-external-modules).
 * [Try::Tiny - Minimal try/catch with proper preservation of $@ - metacpan.org](https://metacpan.org/pod/Try::Tiny).
 * [Perl - Error Handling - Tutorialspoint](https://www.tutorialspoint.com/perl/perl_error_handling.htm).

Quit immediatly the program, printing the specified message:
```perl
die "my message";  
```

Just print a warning:
```perl
warn "my message";
```

See `Carp` package for printing the callstack on failure.

Catch an exception with `eval`:
```perl6
eval {
	do_something();
	1;
} or do {
	my $error = $@ || 'Unknown failure';
	handle_error();
};
```

Catch an exception with `try`:
```perl6
use Try::Tiny;
try {
	# do something
} catch {
	# handle error
};
```

## Profiling
	
Install profiler module `Devel::NYTProf`.

Profile code and write database to `./nytprof.out`:
```perl
perl -d:NYTProf some_perl.pl
```

Convert database into a set of html files, e.g., `./nytprof/index.html` and open a web browser on the `nytprof/index.html` file:
```perl
nytprofhtml --open
```
or into comma separated files, e.g., `./nytprof/*.csv`:
```perl
nytprofcsv
```

## Unicode
	
Reading/Writing UTF8 from/to already opened streams:
```perl
binmode (STDOUT, ":utf8");
binmode (STDIN, ":utf8");
```

WARNING: coherence between input data encoding and output data encoding is essential !
So when forcing encoding for an input stream, be sure to set accordingly the output stream.
Example:
```perl6
open(FILE, "<:utf8", "some file");
while(<FILE>) {
	print $_;
}
```
will produce wrong output if
```perl
binmode (STDIN, ":utf8");
```
has not been set.
	
Decoding utf8 when not detected by Perl. This happens for instance when reading command line arguments:
```perl
use Encode;
$var = decode_utf8($var);
```

Attention, `printf` does not count correctly utf8 chars (like accentuated chars), if "%-60s" format is used and the following is not set :
```perl
use utf8;
binmode (STDOUT, ":utf8");
```

### Removing accents (in order to  sort correctly)

`Unicode::Normalize::NFD($s)` decompose the characters in character+accent.
```perl
$string = Unicode::Normalize::NFC($string);
```
then apply
```perl
$string =~ s/\pM//g;
```

More simple (and works):
```perl
use Text::Unaccent::PurePerl;
$s = unac_string('utf8', $s);
```

## Errors

### On macos, Symbol `_Perl_xs_handshake` not found

Error message is:
```
dyld: lazy symbol binding failed: Symbol not found: _Perl_xs_handshake
```

Remove multithreaded version of modules in personal Perl library:
```
rm -rf $HOME/perl5/lib/perl5/darwin-thread-multi-2level
```

### On macos, impossible to install HTTP::Date

Error message is:
```
Can't locate HTTP/Date.pm in @INC ...
```
This error comes after installing `LW::Simple` for which `HTTP::Date` is needed.

`cpan HTTP::Date` returns:
```
Reading '/Users/.../.cpan/Metadata'
  Database was generated on Sat, 16 Feb 2019 23:29:03 GMT
  HTTP::Date is up to date (6.02).
```

Use `cpanm` instead:
```bash
brew install cpanminus
```
Remove you `~/.cpan` folder, and remove all installed modules `~/.perl5`, and try:
```bash
cpanm LW::Simple
```

### Mismatched between library and binaries

After an upgrade of perl version:
`Parser.c: loadable library and perl binaries are mismatched (got handshake key 0xd880080, needed 0xdb00080)`

Recompile modules:
```bash
cpan -r
```

## Interesting packages

### Array::Utils

Intersection:
```perl
use Array::Utils;
my @isect = Array::Utils::intersect(@a, @b);
```

### Carp / error handling

Module for displaying more useful messages than die.
	
```perl
use Carp;
```

Send a warning:
```perl
carp "my message";
```

Quit:
```perl
coark "my message";
```

Quit and print the call stack:
```perl
confess "my message";
```

Warn user (from perspective of caller):
```perl
carp "string trimmed to 80 chars";
```

Die of errors (from perspective of caller):
```perl
croak "We're outta here!";
```

Die of errors with stack backtrace:
```perl
confess "not implemented";
```

`cluck` not exported by default:
```perl
use Carp qw(cluck);
cluck "This is how we got here!";
```

### Class::Date

```perl
use Class::Date;
```

Create a Date object from a string "YYYY-MM-DD":
```perl
my $date = new Class::Date("2013-01-03");
```

With time:
```perl
my $date = new Class::Date("2013-01-03 15:30:28");
```

Get UNIX epoch time:
```perl
my $time = $date->epoch;
```

Get current date:
```perl
my $today = Class::Date->now;
```

Addition:
```perl
$date= date('2001-12-11')+'3Y';
$date= Class::Date->new('2001-12-11')+Class::Date::Rel->new('3Y');
```

To change print date format:
```perl
$Class::Date::DATE_FORMAT="%Y-%m-%d";
```

### Data::Dumper

To dump a structure:
```perl
use Data::Dumper;
print(Data::Dumper->Dump([\@my_array, \%my_hash], ["array_name", "hash_name"]));
```
the second parameter (variable names) is optional.

To avoid cross-references:
```perl
$Data::Dumper::Deepcopy = 1;
```
	
Encoding issue: be careful to output data structures in ASCII, or do() function could make mistake while reading, and assume another encoding than UTF-8 for strings.
```perl
use Data::Dumper;
binmode(STDOUT, ":utf8");
print Data::Dumper->Dump([\%my_hash]);
```

### DBI / database connection

```perl
use DBI;
```

Connection:
```perl6
my $dbh = DBI->connect('DBI:mysql:mydatabase');
my $dbh = DBI->connect('DBI:mysql:mydatabase', $user, $password, { RaiseError => 1, AutoCommit => 0 });
```

Setting parameters after connection is created:
```perl
$dbh->{AutoCommit} = 1;
```

Espace and quote query string before using it:
```perl
my $quoted_string = $dbh->quote($unquoted_string);
```

Run query:
```perl
my $sth = $dbh->prepare("INSERT INTO mytable VALUES (1, 2)");
$sth->execute();
```

When `AutoCommit` is on, every query is commited. To open a transaction run:
```perl
$dbh->begin_work();
# or
$dbh->do('BEGIN TRANSACTION');
```
Then `AutoCommit` is turned off automatically.
When you are done, commit the transaction with:
```perl
$dbh->commit();
# or
$dbh->do('COMMIT');
```
Or cancel it with:
```perl
$dbh->rollback();
```
Then `AutoCommit` is turned on again.

When `AutoCommit` is off, we are always in a transaction mode. Thus opening explictly a transaction is not needed but does not harm:
However closing a transaction is needed.

### SQLite

Install:
```sh
cpan -i DBD::SQLite
```

Open an SQLite connection:
```perl
use DBI;
my $dbh = DBI->connect("dbi:SQLite:dbname=/my/db/file.sqlite", "", "");
```

### MySQL

```perl
use Mysql;
```

Connecting:
```perl
my $db = Mysql->connect($host, $database, $user, $password);
```

Selecting database:
```perl
$db->selectdb($database);
```

List databases:
```perl
my @array = $db->listdbs;
```

List tables:
```perl
my @array = $db->listtables;
```

Fields info:
```perl
my $fields = $db->listfields($table);
$fields->name;
$fields->type;
$fields->length;
$fields->isnotnull;
$fields->isprikey;
$fields->isnum;
$fields->isblob;
```

Query:
```perl
my $query = $db->query($sql_query);
mysql_fetch_row($query_id); # get one row, call again to get the next row
my %hash = $query->fetchhash; # get one row in a hash (column name as key)
$query->dataseek($row_number); # first row has index 0
```

Query Statement Statistics:
```perl
my $number = $query->numrows;
my $number = $query->numfields;
my $number = $query->affectedrows;
my $id = $query->insertid; # gives back the automatically inserted id in the new row, if there's one.
```

Espace and quote query string before using it:
```perl
my $quoted_string = $db->quote($unquoted_string);
```

Error:
```perl
$error_message = $db->errmsg();
```

Create/remove a database:
```perl
my $newdb = $dbh->createdb("database name");
my $nodb = $db->dropdb("database name");
```

### Encode::Supported

 * [CPAN Encode::Supported](http://search.cpan.org/~jhi/perl-5.8.1/ext/Encode/lib/Encode/Supported.pod).

Encodings supported by Encode.
 
### ExtUtils::MakeMaker

 * [CPAN ExtUtils::MakeMaker](http://search.cpan.org/~bingos/ExtUtils-MakeMaker-7.24/lib/ExtUtils/MakeMaker.pm).

```perl
use ExtUtils::MakeMaker;
WriteMakefile( ATTRIBUTE => VALUE [, ...] );
```
	
Put module files under lib directory. Everything will be taken.
	
Scripts:
```perl
WriteMakefile( EXE_FILES => ['scriptA', 'scriptB']);
```
	
On command line:
```bash
perl Makefile.PL
make
make test
make install
```
	
Installing in a specific directory:
```bash
perl Makefile.PL PREFIX=/path/to/your/home/dir      # will install under lib/perl5/site_perl
perl Makefile.PL INSTALL_BASE=/path/to/your/home/dir # will install under lib/perl5
```
	
For testing, add a directory named `t` and put `*.t` files inside. They will be run inside the Test::Harness framework.
For printing output of tests:
```bash
make test TEST_VERBOSE=1
```

### File::Basename

```perl
use File::Basename;
```


### GD::Image
	
To create an image:
```perl
my $im = new GD::Image($width, $height);
```
	
To load an image:
```perl
my $im = new GD::Image($filepath);
my $im = new GD::Image($file_descriptor);
```

To write text on the image:
```perl
$im->stringFT($color, $ttf_file, $point_size, $angle, $x, $y, $text);
```
angle is expressed in radians.

To write in a file:
```perl
$im->png($compression_level);
```

Allocating a color:
```perl
$im->colorAllocate($red, $green, $blue);
```

Draw a filled polygon:
```perl
$poly = new GD::Polygon;
$poly->addPt($x1 + 200, $y1 + 200);
$poly->addPt($x1 + 250, $y1 + 230);
$poly->addPt($x1 + 300, $y1 + 310);
$poly->addPt($x1 + 400, $y1 + 300);
$im->filledPolygon($poly, $color);
```

Draw a dashed line:
```perl
$im->dashedLine($x1, $y1, $x2, $y2, $color);
```

### Getopt

```perl
use Getopt::Std;

getopt('oDI');    # -o, -D & -I take arg.  Sets $opt_* as a side effect.
getopt('oDI', \%opts);    # -o, -D & -I take arg.  Values in %opts
getopts('oif:');  # -o & -i are boolean flags, -f takes an argument
                  # Sets $opt_* as a side effect.
getopts('oif:', \%opts);  # options as above. Values in %opts
```

Arguments found by getopt are removed from @ARGV.

### Getopt::Long

```perl
use Getopt::Long;
```

Read a string value:
```perl
my $s = "default value";
GetOptions("myopt1=s" => \$s);
```

Read values and put them inside a hash:
```perl
my %args = ( myopt1 => "default value 1", myopt2 => "default value 2" );
GetOptions("myopt1=s" => \$args{myopt1}, "myopt2=s" => \$args{myopt2});
```

### HotKey / input keys

```perl6
use HotKey;
use feature "switch";
$key = readkey();
given($key) {
	when('q')    { do_something(); }
}
```

### HTML::TreeBuilder::XPath

Add XPath support to `HTML::TreeBuilder`.

```perl
use HTML::TreeBuilder::XPath;
```

```perl
my $tree= HTML::TreeBuilder::XPath->new;
$tree->parse_file( "mypage.html");
```

### inc::Module::Install

 * [CPAN inc::Module::Install](http://search.cpan.org/~ether/Module-Install-1.17/lib/Module/Install.pod).

Makefile.PL:
```perl
use inc::Module::Install;
name           'DocMaking';
all_from       'lib/Your/Module.pm';
version         '1.0';
requires       'File::Spec'  => '0.80';
test_requires  'Test::More'  => '0.42';
recommends     'Text::CSV_XS'=> '0.50';
no_index       'directory'   => 'demos';
install_script 'slides-maker';
install_script 'get-code-type';
install_script 'split-code';
install_share;      # install everything that is in share directory of the distribution.
WriteAll;
```

On command line:
```bash
perl Makefile.PL PREFIX=$HOME/perl # Use PREFIX and not INSTALL_BASE, so share directory is installed under lib/perl5/site_perl and will be found by File::ShareDir.
make
make test
make install
```

Getting share directory from a program:
```perl
my $share = File::ShareDir::dist_dir('My::Module');
```

### List::Util
	
Reduce:
```perl6
use List::Util qw(reduce);
my $sum = List::Util::reduce { $a + $b } 0, @mynumbers;
```

Remove duplicates:
```perl
use List::MoreUtils qw(uniq);
my @unique = uniq( 1, 2, 3, 4, 4, 5, 6, 5, 7 ); # 1,2,3,4,5,6,7
my $unique = uniq( 1, 2, 3, 4, 4, 5, 6, 5, 7 ); # 7
```

Find maximum and minimum:
```perl
use List::Util qw(max);
my $max = max(@myarray);
my $max = min(@myarray);
```

### List::MoreUtils

```perl
use List::MoreUtils;
```

### LWP::Simple

A simplified facade to the `libwww-perl` library.

```perl
use LWP::Simple;
```

Getting a web page content:
```perl
$content = get("http://www.sn.no/");
```

### Tk
	
```perl
use Tk;
```

Create a main window:
```perl
my $mw = MainWindow->new;
```
	
Scrollbars:
```perl
my $wmain = $g_main_window->Scrolled('Pane', -height => 1, -width => 1, -scrollbars => 'e');
```

hide/show a window:
```perl
$mw->withdraw(); # hide
$mw->deiconify(); # show
```

Run the GUI:
```perl
MainLoop;
```
	
Create a button:
```perl
my $button = $mw->Button(-text => "label", -command => sub{foo()});
my $button = $mw->Button(-text => "label", -command => &foo});
```

Load a color image:
```perl
my $img = $mw->Photo(-file => "/my/file/path");
```

Set image on button:
```perl
$button->configure(-image => $img);
```
	
Grid layout:
```perl
$button->grid(-row => 2, -column => 1);
```

Pack layout:
```perl
$button->pack;
$button->pack(-side => 'bottom', -expand => 1, -fill => 'x');
$button->pack(-side => 'left', -expand => 1, -fill => 'both');
```
	
`-side` => 'left' | 'right' | 'top' | 'bottom' Puts the widget against the specified side of the window or frame
`-fill` => 'none' | 'x' | 'y'| 'both' Causes the widget to fill the allocation rectangle in the specified direction
`-expand` => 1 | 0 Causes the allocation rectangle to fill the remaining space available in the window or frame
`-anchor` => 'n' | 'ne' | 'e' | 'se' | 's' | 'sw' | 'w' | 'nw' | 'center' Anchors the widget inside the allocation rectangle
`-after` => $otherwidget Puts $widget after $otherwidget in packing order
`-before` => $otherwidget Puts $widget before $otherwidget in packing order
`-in` => $otherwindow Packs $widget inside of $otherwindow rather than the parent of $widget, which is the default
`-ipadx` => amount Increases the size of the widget horizontally by amount ✕ 2
`-ipady` => amount Increases the size of the widget vertically by amount ✕ 2
`-padx` => amount Places padding on the left and right of the widget
`-pady` => amount Places padding on the top and bottom of the widget

Label:
```perl
my $label = $mw->Label(-text => 'label text');
```

Frame:
```perl
my $frame = $mw->Frame();
```

Key presses:
```perl
$mw->bind('Q', sub{exit});
```

### XML::LibXML

 * [XML::LibXML](https://metacpan.org/pod/XML::LibXML).

Example:
```perl
use XML::LibXML;
open my $fh, '<', $myfile;
binmode $fh; # drop all PerlIO layers possibly created by a use open pragma
$doc = XML::LibXML->load_xml(IO => $fh);
$root = $doc->documentElement();
my @nodes = $root->getChildrenByTagName("mytag");
```

### XML::Simple

DRAWBACKS
 * DEPRECATED
 * Doesn't handle correctly `<?...?>` head tag. Change it in `<opt ...>...</opt>`.
 * On XMLout use option `XMLDecl => 1`.

By default it wants to put a 'name' attribute in tags, so you can't have an empty tag (with no attribute). If you read and write an XML without changing something, then the ouput will be different than the input. Typically something like `<tag1><tag2><tag3>...` becomes `<tag1 name="tag2"><tag3...`

On XMLin and XMLout use option `KeepRoot => 1` to keep root element.

See [XML::Simple](https://metacpan.org/pod/XML::Simple).

```perl
use XML::Simple qw(:strict);
```

### Parse::RecDescent

 * [Parse::RecDescent](https://metacpan.org/pod/Parse::RecDescent).
 * [Parse::RecDescent Tutorial]( https://www.perl.com/pub/2001/06/13/recdecent.html/).

### Text::CSV

 * [Text::CSV](https://metacpan.org/pod/Text::CSV).

Load a TSV file as an array of hashes:
```perl
use Text::CSV;
my $photos = Text::CSV::csv(in => "myfile.tsv", sep_char => "\t", headers => "auto");
```

### Spreadsheet::Reader::ExcelXML

 * [Spreadsheet::Reader::ExcelXML](https://metacpan.org/pod/Spreadsheet::Reader::ExcelXML).

### Spreadsheet::XLSX

 * [Spreadsheet::XLSX](https://html.duckduckgo.com/html/?q=perl%20xlsx).

### Spreadsheet::Read

 * [Spreadsheet::Read](https://metacpan.org/pod/Spreadsheet::Read).

Depends on `Spreadsheet::ParseExcel` for xls file and `Spreadsheet::ParseXLSX` for xlsx files.

--> Installation OK.

### Spreadsheet::ParseExcel

 * [Spreadsheet::ParseExcel](https://metacpan.org/pod/Spreadsheet::ParseExcel).
For Excel 95-2003 files.

### Spreadsheet::ParseXLSX

 * [Spreadsheet::ParseXLSX](https://metacpan.org/pod/Spreadsheet::ParseXLSX).

For Excel 2007 Open XML XLSX.

Depends on `Archive::Zip`.
Installation of `Archive::Zip` fails on tests when install with cpan ==> try to install it directly from system package.

### Excel::Writer::XLSX

 * [Excel::Writer::XLSX](https://www.geeksforgeeks.org/perl-creating-excel-files/).

For creating Excel files.

### YAML::XS
 
 * [YAML](https://metacpan.org/pod/YAML::XS).

Load a YAML file:
```perl
use YAML::XS;
my $data = YAML::XS::LoadFile('myfile.yml');
```

Create a YAML file:
```perl
YAML::XS::DumpFile('output.yml', $data);
```

### JSON

 * [JSON](https://metacpan.org/pod/JSON).

Convert to JSON using OOP model:
```perl
print JSON->new->pretty->canonical->utf8([0])->encode(\%myhash);
```

Converting to JSON using old `to_json()` method (slower):
```perl
print JSON::to_json(\%myhash, {utf8 => 0, pretty => 1, cannoncal => 1});
```

Using new method `encode_json()`, no parameters:
```perl
print JSON::encode_json(\%myhash);
```
