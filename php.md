PHP
===

 * [Language Reference](http://php.net/manual/en/langref.php).

## Installing and running

### Installation

On macos, if you want to use gettext functionalities in PHP, you must install it from Homebrew :
```bash
brew install gettext php
```

See Apache for configuring the path toward PHP. The line to set should be something like:
```apache
LoadModule php7_module /usr/local/opt/php/lib/httpd/modules/libphp7.so
```
See `brew info php` for exact details.
Also you must add, the following lines:
```apache
<IfModule dir_module>
	DirectoryIndex index.html index.php
</IfModule>
<FilesMatch \.php$>
	SetHandler application/x-httpd-php
</FilesMatch>
```
See [macOS 10.14 Mojave Apache Setup: Multiple PHP Versions](https://getgrav.org/blog/macos-mojave-apache-multiple-php-versions).

### Execution

Embedding PHP code inside an HTML page:
```html
<html>
	<head>
		<title>My first PHP Page</title>
	</head>
	<body>
		This is normal HTML code
		<?php 
				// php code goes here
		?>
		Back into normal HTML
	</body>
</html>
```
Short open tag `<?` is also tolerated, if enabled using the `short_open_tag` in `php.ini`.
```html
<html>
	<? printf('hello') ?>
</html>
```
The `<?=` tag, on the contrary, is always available:
```html
<html>
	<?= sprintf('hello') ?>
</html>
```

If a file contains only PHP code, then it is preferable to omit the closing tag `?>`, since it could introduce white space characters at the end of your output:
```php
<?php
printf('Hello')
```

Given the following PHP script `myscript.php`:
```php
<?php
$s = shell_exec('ls'); echo "$s";
```
You can execute it like this:
```bash
php -f myscript.php
```

Using a shebang, you can make the script executable:
```php
#!/usr/bin/php
<?php
$s = shell_exec('ls'); echo "$s";
```

### Configuration

Configuration file `php.ini` is looked for in different directories.

Environment variables `PHPRC` and `PHP_INI_PATH` control where PHP looks first for `php.ini`.

In a Homebrew installation, you will find it at `/usr/local/etc/php/7.3/php.ini`.

### Modules installation

Two systems exist in PHP: pear and pecl.

Update PEAR system:
```bash
sudo pear upgrade PEAR
```

Re-install PEAR:
```bash
wget http://pear.php.net/go-pear.phar
php -d detect_unicode=0 go-pear.phar
```

Search for a package:
```bash
pear search mypkg
```

Install a package:
```bash
pear install mypkg
```

Uninstall a package:
```bash
pear uninstall mypkg
```

Modules are installed inside `ext` folder. Example:
```
/usr/local/Cellar/php/7.3.2/include/php/ext
```

### Modules loading

Including a PHP module:
```php
<?php
require_once "a_module.php"; // stops if error
include_once "a_module.php"; // goes on if error (prints warning)
```

To include a web page part:
```php
<?php
require "my_web_page_part.inc";
include "my_web_page_part.inc";
```

The include path is defined inside `/etc/php.ini`:
```
include_path = .:/usr/local/lib/php:./include
```

To get a list of all included files:
```php
get_included_files();
```

### PHP version

Version can be accessed through a constant or a method:	
```php
<?php
$version = PHP_VERSION;
$version = phpversion();
```

Running different code depending on version:
```php
<?php
switch(true) {
case (version_compare("5", phpversion(), "<=")):
	//do php5 code
	break;
case (version_compare("5", phpversion(), ">")):
	//do php4 code
	break;
}
```
	
On some website (like free.fr), PHP4 is used by default. In order to use PHP5, one needs to create a `.htaccess` file at site root and write inside:
```
php 5
```

### Debugging and errors

Report all errors, including variable use before declaration:
```php
<? error_reporting(E_ALL|E_STRICT);
```
Note: `E_STRICT` is included inside `E_ALL`, starting from PHP 5.4.
See [error_reporting](http://php.net/manual/en/function.error-reporting.php) and its [Predefined Constants](http://php.net/manual/en/errorfunc.constants.php).

Print system information:
```php
<? phpinfo();
```

## Declare directives

Set encoding:
```php
<? declare(encoding='ISO-8859-1');
```

Enable strict mode for types:
```php
<? declare(strict_types = 1);
```
With this option, PHP will not try to convert basic types (`int`, `float`, `string` and `bool`) silently.

## Types

Get type:
```php
<? $type = gettype($myvar) ?>
```

Get the class of an object:
```php
<? $type = get_class($myvar) ?>
```

### Constants

Define a constant:
```php
<?php
define("MY_CONST", "my value");
define("MY_NUM_CONST", 25);
const MY_CONST = 'my value';
?>
```

Use a constant:
```php
<?php
echo MY_CONST;
echo constant("MY_CONST");
?>
```

Verify constant existence:
```php
<?php
if (defined('TEST'))
	echo TEST;
?>
```

### Booleans

```php
<?php
$flag = True;
$flag = False;
?>
```

### Strings

Accessing the character at index 4:
```php
<?php
$c = $string{4};
?>
```

Substring:
```php
<?php
$rest = substr("abcdef", 1);    // returns "bcdef"
$rest = substr("abcdef", 1,2);    // returns "bc"
$rest = substr("abcdef", -1);    // returns "f"
$rest = substr("abcdef", -2);    // returns "ef"
$rest = substr("abcdef", -3, 1); // returns "d"
?>
```

String length:
```php
<?php
$l = strlen($string);
?>
```

Concatenate strings:
```php
<?php
$s = 'a' . 'b' . $t;
$s .= $u;
?>
```

Using a variable inside a string:
```php
<?php $s="My phrase with a $var inside it."
```

Uppercase & lowercase:
```php
<?php
$uc_str = strtoupper($s);
$lc_str = strtolower($s);
?>
```

Strip characters at end and beginning of a string:
```php
<?php
$new_str = trim($s); // strip spaces by default
$new_str = trim($s, "#@$"); // strip the listed characters
?>
```

To convert from numeric to string and vice-versa:
```php
<?php
$str = strval($number);
$number = intval($str);
?>
```

Repeat:
```php
<?php
$s_3_times = str_repeat($s, 3);
?>
```

Character code:
```php
<?php
$c = chr(0x20);
$char_code = ord('A');
?>
```

Join elements:
```php
<?php
$string = implode(':', $array);
$string = join('/', $array);    // join is an alias of implode
?>
```

Split string:
```php
<?php
$my_array = explode(',', $string);
$my_array = preg_split("/,/", $string);
$my_array = preg_split("/,/", $string, $max_elem);
list($user, $pass, $uid, $gid, $extra) = preg_split("/:/", $passwd_line, 5);
$chars = preg_split('//', 'string', -1, PREG_SPLIT_NO_EMPTY);
?>
```

Print a string in hexadecimal form:
```php
<?php
$hex_str = bin2hex($s);
?>
```

Using variables into strings:
```php
<?php
$str = "my_var = $my_var";
$str = "my_array_elem_val = {$my_array['elem']}";
$str = "my_object_member_val = $object->member";
?>
```

Replace:
```php
<?php
$mynewvar = str_replace("old", "new", $myvar);
$mynewvar = str_replace(["aa", "bb"], "cc", $myvar);
$mynewvar = str_replace(["aa", "bb"], ["cc", "dd"], $myvar);
?>
```

Translate:
```php
<?php
$addr = strtr($addr, "äåö", "aao");
$trans = array("hello" => "hi", "hi" => "hello");
echo strtr("hi all, I said hello", $trans);
?>
```
Warning: strtr doesn't work in UTF-8.
However `str_replace` works in UTF-8:
```php
<?php
$texte = str_replace(
	    array(
	        'à', 'â', 'ä', 'á', 'ã', 'å',
	        'î', 'ï', 'ì', 'í', 
	        'ô', 'ö', 'ò', 'ó', 'õ', 'ø', 
	        'ù', 'û', 'ü', 'ú', 
	        'é', 'è', 'ê', 'ë', 
	        'ç', 'ÿ', 'ñ', 
	    ),
	    array(
	        'a', 'a', 'a', 'a', 'a', 'a', 
	        'i', 'i', 'i', 'i', 
	        'o', 'o', 'o', 'o', 'o', 'o', 
	        'u', 'u', 'u', 'u', 
	        'e', 'e', 'e', 'e', 
	        'c', 'y', 'n', 
	    ),
	    $texte
	                 );
?>
```

### Date

Convert a English/US date string into a UNIX timestamp date:
```php
<?php
$mydate_in_seconds_from_1970 = strtotime("11/29/2010");
?>
```

### Array

Declaring an array:
```php
<?php
$my_array = array();
$my_array = [];
array_fill(0, 10, 'NaN');
?>
```

Get array size:
```php
<?php count($array);
```

Printing an array:
```php
<?php
print_r($array);
?>
```

Test if a variable is an array:
```php
<?php
if (is_array($my_var)) ...;
?>
```

Tests if array is empty:
```php
<?php
empty($my_array);
?>
```

Looping on all elements of an array:
```php
<?php
foreach ($my_array as $elem) {
}
?>
```

Looping & modifying:
```php
<?php
foreach ($my_array as &$elem)
	$elem = $elem . "foo";
?>
```

Join & split: see strings.

Max & min values:
```php
<?php
$max = max($array);
$min = min($array);
?>
```

Search:
```php
<?php
$bool = in_array($val, $array);
$index = array_search($val, $array);
?>
```

Map elements:
```php
<?php
array_map("my_func", my_array);
?>
```

Slice (extract a part of an array):
```php
<?php
$input = array("red", "green", "blue", "yellow");
$output = array_slice($input, -2 /*offset*/, 1 /*length*/);
array_splice($input, 1/*offset*/, -1/*length*/); // $input is now array("red", "yellow")
array_splice($my_array, 3/*offset*/, 5/*length*/, $new_elem/*replacement array*/);
?>
```
Note: negative values are used to count from the end of the array.

Push & pop:
```php
<?php
array_push($stack, "apple", "raspberry"); // put last
$fruit = array_pop($stack); // take last
$fruit = array_shift($stack); // take first
array_unshift($queue, "apple", "raspberry"); // put first
?>
```

Merge:
```php
<? $a = array_merge($b, $c); ?>
```

Append:
```php
<? $a[] = 12; ?>
```

Sort:
```php
<?php
sort($array);
?>
```

Compare:
```php
<?php
$diff_array = array_diff($array1, $array2);
?>
```

### Associative array (Dictionary)

```php
<?php
$array = [
	"foo" => "bar",
	"bar" => "foo",
];
```

Build an associative array from a list of keys and a list of values:
```php
<?php array+combine($keys, $values);
```

Test if a key exists:
```php
<?php array_key_exists($key, $array);
```

Get keys:
```php
<?php $keys = array_keys($array);
```

Looping:
```php
<?php
foreach ($a as $k => $v)
	echo "\$a[$k] => $v.\n";
```

Tests if element exists:
```php
<?php
isset($my_array['foo']);
?>
```

Removes an element:
```php
<?php
unset($my_array['foo']);
?>
```

### Object

Access an object property:
```php
<?php $x = $myobj->myfield ?>
```

A variable can be used to access a property:
```php
<?php
	$f = 'myfield';
	$x = $myobj->$f;
?>
```

Test if an object has a property:
```php
<?php
	if (property_exists($myobj, 'myfield'))
		$x = $myobj->myfieldProtocoles;
?>
```

## Variables

Print a variable information (type and value):
```php
<?php
var_dump($var);
?>
```

Print variable value:
```php
<?php
print($var);
?>
```

Set a variable to null:
```php
<?php
$myvar = NULL;
?>
```

Test if a variable is null:
```php
<?php
if (is_null($myvar)) {
}
?>
```

Testing if a variable is defined:
```php
<?php
if (isset($my_var)) {
	//...
}
?>
```
	
Accessing a global variable from inside a function:
```php
<?php
global $toto;
?>
```

Getting a variable value by dynamic variable name:
```php
<?php
$val = $$name; // get value of variable named $name
?>
```
	
Static variable:
```php
<?php
function foo() {
	static $myvar = 1;
}
?>
```
	
Variable reference inside a loop:
```php
<?php
foreach ($text_array as &$t)
	$t = ...;
?>
```
Only available starting from PHP version 5.

## Built-in constants & variables

Current directory of execution:
```php
<?php __DIR__ ?>
```

`$_SERVER` contains many context variables:
```php
<?php
$_SERVER['_']; // name of the PHP program
$_SERVER['DOCUMENT_ROOT'];
?>
```

`$_SERVER['DOCUMENT_ROOT']` empty issue:
`$_SERVER['DOCUMENT_ROOT']` is null in CGI version of IIS PHP, use ISAPI version: `php5isapi.dll`.

Global variables:
```php
<?php
$GLOBALS;
?>
```

## Environment variables

Array of environment variables:
```php
<?php
$_ENV;
?>
```
	
Get an env var:
```php
<?php
$home = getenv('HOME');
?>
```

Set an env var:
```php
<?php
putenv("UNIQID=$uniqid");
?>
```

## Operators

 * [Operators](https://www.php.net/manual/en/language.operators.php).

Testing equality after transtypage (both side of the equality are converted to the same type):
```php
<?php
$a == $b
"1001" == 1001 // true
"1001asjdh" == 1001 // true
"00001001" == 1001 // true
"100" == 1e2 // true
"1002" == 1001 // false
"1002" != 1001 // true
"1002" <> 1001 // true
?>
```

Testing equality without transtypage. Test first the equality of types, then test values:
```php
<?php
"1001" === 1001 // false
"1001" !== 1001 // true
?>
```

Inequality:
```php
<?php
"1001" < 1002
"1001" > 1002
"1001" <= 1002
"1001" >= 1002
?>
```

Ternary operator is available:
```php
<?php
$a = $b == $c ? 10 : 20;
?>
```

Assignment:
```php
<?php
$s .= $t + 'a';
$i += 12;
?>
```

## Statements and control structures

### If / elseif / else

```php
<?php
if ($myvar == 2)
	do_something();
elseif ($myvar > 2)
	do_something();
else
	do_something_even_different();
?>
```

### eval

Evaluate string as code:
```php
<?php
eval('$my_array = ["a" => "blabla", "b" => "tagazou"];');
?>
```

### for & foreach loops

For loop:
```php
<?php
for ($i = 1; $i <= 10; $i++)
	echo $i;
?>
```

Foreach loop:
```php
<?php
foreach($myarray as $val)
	do_something($val);
?>
```

Foreach with key/values:
```php
<?php
foreach($myarray as $key => $value)
	do_something($key, $value);
?>
```

Foreach with modification of elements:
```php
<?php
foreach ($arr as &$value)
	$value = $value * 2;
?>
```

Break and continue:
```php
<?php
foreach($myarray as $val)
	if ($val == $v)
		break;
?>
```

### Switch

With an integer:
```php
<?php
switch ($i) {
	case 0:
		doSomething();
		break;
	case 1:
		doSomething();
		break;
	default:
		doSomething();
}
```

With a string:
```php
<?php
switch ($s) {
	case 'a':
		doSomething();
		break;
	case 'b':
		doSomething();
		break;
	default:
		doSomething();
}
```

### Alternate syntax with `:`

 * [Alternative syntax for control structures](http://php.net/manual/en/control-structures.alternative-syntax.php)

Instead of using curly brackets for grouping code in control structures, one can use the syntax `:` / `end*` that exists for `if`, `while`, `for`, `foreach` and `switch`.

Example:
```php
<?php
if ($myvar == 2):
	do_something();
elseif ($myvar == 3):
	do_something_else();
else:
	do_another_thing();
endif;
?>
```

This construct is particularly useful for enabling or disabling HTML code:
```php
<?php if ($myvar == 2): ?>
	<p>Some text.</p>
<?php elseif ($myvar == 3): ?>
	<p>Some other text.</p>
<?php else: ?>
	<p>Some different text.</p>
<?php endif; ?>
```

## Functions

Defining a function:
```php
<?php
function my_func($param1, $param2) {
	// ...
	return $ret_val;
}
```

Using parameter types:
```php
<?php
function my_func(int $param1, string $param2) {
}
```
Possible types:
 * `array`.
 * `callable`.
 * `bool`.
 * `float`.
 * `int`.
 * `string`.
 * `iterable` (array or instance of Traversable).
 * `object`.
 * `self` (same class as this class).
 * The name of a valid class.

Passing a parameter by reference:
```php
<?php
function my_func(&$param_by_ref) {
}
```

Default values:
```php
<?php
function my_func($param1, $param2, $param3 = array('toto', 'titi'), $param4 = 1) {
}
?>
```

Static function:
```php
<?php
static function my_func() {}
?>
```
Be careful to not use static keyword for functions with some versions of PHP. It's not supported by old version of PHP, they will issue a "Parse error".

`create_function`:
```php
<?php
$newfunc = create_function('$a,$b', 'return "ln($a) + ln($b) = " . log($a * $b);');
?>
```

Inline function (PHP 5.3):
```php
<?php
$map = function ($text) use ($search, $replacement) {
	if (strpos ($text, $search) > 50) {
	  return str_replace ($search, $replacement, $text);
	} else {
	  return $text;
	}
  };
?>
```

## Regex

Test if it matches:
```php
<?php
if (preg_match('/abc/', $text)) {
}
?>
```

Case insensitive search:
```php
<?php
if (preg_match('/abc/i', $text)) {
}
?>
```

Look for a match:
```php
<?php
if (preg_match('/^\s*\[(.+)\]\s*$/', $line, $matches)) {
	// ...
}
?>
```

Replace:
```php
<?php
$new_string = preg_replace("/([to]+) ([0-9]+)/i", "$2 --- $1", $string);
?>
```

Filter & replace:
```php
<?php
$ids = preg_filter('/^(\d+).html.ref$/', '$1', scandir("files"));
?>
```
## Math

Ceil:
```php
<?php
echo ceil(4.3);    // 5
echo ceil(9.999);  // 10
echo ceil(-3.14);  // -3
?>
```

Floor:
```php
<?php
echo floor(4.3);   // 4
echo floor(9.999); // 9
echo floor(-3.14); // -4
?>
```

Round:
```php
<?php
echo round(3.4);         // 3
echo round(3.5);         // 4
echo round(3.6);         // 4
echo round(3.6, 0);      // 4
echo round(1.95583, 2);  // 1.96
echo round(1241757, -3); // 1242000
echo round(5.045, 2);    // 5.05
echo round(5.055, 2);    // 5.06
?>
```

## I/O

Print a string with `echo`:
```php
<?php
echo 'Blabla';
echo('Blabla');
echo 'Blabla', 'blibli', $myvar;
```
`echo` returns nothing.

`print` takes only one argument and always returns `1`:
```php
<?php
print($mystring);
```

## File system

Open a file:
```php
<?php
$handle = fopen("/home/rasmus/file.txt", "r");
?>
```

List files using pattern:
```php
<?php
foreach (glob("*.txt") as $filename) {
	// ...
}
?>
```

Getting file size:
```php
<?php
filesize($filename);
?>
```

Getting file base name:
```php
<?php
$path = "/home/httpd/html/index.php";
$file = basename($path);         // $file is set to "index.php"
$file = basename($path, ".php"); // $file is set to "index"
$dir = dirname($path);
?>
```

Get file extension:
````php
<?php pathinfo($path, PATHINFO_EXTENSION);
```

Getting dir name:
```php
<?php
$path = "/etc/passwd";
$dir = dirname($path); // $dir is set to "/etc"
?>
```

Getting current working directory:
```php
<?php
$curdir = getcwd();
?>
```

Test file or directory existence:
```php
<?php
if (file_exists($filename)) {
	//...
}
?>
```

Concatenate file path:
```php
<?php $mypath = '/some/path/' . 'myfile';
```

File type:
```php
<?php
is_dir($file);
is_file($file);
is_link($file); // test if symbolic link
?>
```

Create a directory:
```php
<?php
mkdir("/path/to/my/dir");
mkdir("/path/to/my/dir", 0700);
?>
```

## Exceptions

 * [Exceptions](https://www.php.net/manual/en/language.exceptions.php).

Throw an exception:
```php
<?php throw new Exception("Error !");?>
```

Define a new exception:
```php
<?php
class MyException extends Exception {

	// Constructor {{{1
	////////////////////////////////////////////////////////////////

	public function __construct($message, $code=0, Exception $previous=null) {
		parent::__construct($message, $code, $previous);
	}
}
```

Throw an exception:
```php
<?php throw new MyException();
```

Catch an exception:
```php
<?php 
```

## Images
	
Get image size:
```php
<?php
$size = getimagesize($filename);
?>
```
`$size` is an array:
```php
<?php
array(6) { [0]=> int(805) [1]=> int(242) [2]=> int(3) [3]=> string(24) "width="805" height="242"" ["bits"]=> int(8) ["mime"]=> string(9) "image/png" }
?>
```

Create an image from scratch:
```php
<?php
$im = @imagecreate($width, $height) or Process::die_with_error("Unable to create new image !");
?>
```

Set background color, the first allocated color is considered as the background color:
```php
<? $bg = imagecolorallocate($im, 0xff, 0xff, 0xff);
```

## Multilingual web site

 * [How to Build a Multilingual App: A Demo With PHP and Gettext](https://www.toptal.com/php/build-multilingual-app-with-gettext).

## Namespace

Namespace (PHP 5.3):
```php
<?php
namespace My\Name;
namespace My::Name;
?>
```

A class can also be used as a namespace, in older versions of PHP:
```php
<?php
class A {
	...
}
?>
```
Be careful to not use static keyword for functions. It's not supported by old version of PHP, they will issue a "Parse error".

## OOP

 * [Classes and Objects](http://php.net/manual/en/language.oop5.php).
 * [Class iterator](https://www.php.net/manual/en/class.iterator.php).

Inheritance:
```php
<?php
class A extends B {
}
?>
```

Constructor:
```php
<?php
class A extends B {
	public function __construct() {
		parent::__construct();
	}
}
?>
```

Interface implementation:
```php
<?php
class A implements I {
}
?>
```

### Properties (aka member variables)

 * [Properties](https://www.php.net/manual/en/language.oop5.properties.php).

Member variables are declared with visibility level:
```php
<?php
public $myvar = 1;
protected $myvar2 = 1;
private $myvar3 = 1;
```

A member variable is accessed using the `->` operator:
```php
<?php $myobj->myvar; ?>
```

Static member variables can be defined:
```php
<?php
class MyClass {
	public static $myvar = 1;
}

MyClass::$myvar;
$myclass='MyClass';
$myclass::$myvar;
```

*Attention !* Using a **constructor** call to set a variable inside the variable member declaration is not allowed.

It is possible to write a multilines string when declaring a member:
```php
<?php
public $myvar2 = <<<EOD
My text
on multiple
lines
EOD;
```

## Command line arguments

Getting arguments:
```php
<?php
$_SERVER['argv'];
?>
```

Using `getopt`:
```php
<?php
$shortopts  = "";
$shortopts .= "f:";  // Required value
$shortopts .= "v::"; // Optional value
$shortopts .= "abc"; // These options do not accept values

$longopts  = array(
	"required:",     // Required value
	"optional::",    // Optional value
	"option",        // No value
	"opt",           // No value
);
$options = getopt($shortopts, $longopts);
?>
```

## URL

Getting URL arguments:
```php
<?php
// If the URL is `http://..../script.php?arg1=val1&arg2=val2`:
$arg1 = $_GET['arg1'];
$arg2 = $_GET['arg2'];
?>
```

Simulating URL arguments on the command line:
```bash
php -e -r 'parse_str("id=12134", $_GET); include "display-molecule.php";'
```

Getting a URL content:
```php
<?php
$xml = file_get_contents("http://www.example.com/file.xml");
?>
```
See [file_get_contents](http://php.net/manual/en/function.file-get-contents.php).

Build a query string:
```php
<?php http_build_query(['param1' => 'value1', 'param2' => 'value2']);
```

## Generating HTML

### Set encoding

```php
<?php
header('Content-type: text/html; charset=utf-8');
?>
```

### Generate file download

For downloading a file instead of displaying an HTML page:
	
First, set the content type.
For a CSV file:
```php
<?php
header("Content-Type: text/csv");
?>
```
For an Excel file:
```php
<?php
header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
?>
```

Then:
```php
<?php
header("Content-Disposition: attachment; filename=$filename");
header("Content-Length: ".filesize($tmp_file));
$fp = fopen("$tmp_file","r");
fpassthru($fp); // fpassthru returns the number of characters written.
fclose($fp);
?>
```

## Networking

 * [WOL (Wake-on-LAN) example](http://www.hackernotcracker.com/2006-04/wol-wake-on-lan-tutorial-with-bonus-php-script.html).

## Composer

 * [Composer](https://getcomposer.org/).

Composer is a dependency manager.

## Writing a web service

 * [Creating a RESTful API with PHP](http://coreymaynard.com/blog/creating-a-restful-api-with-php/).

BOF:
 * [Build your first web service with PHP, JSON and MySql](https://trinitytuts.com/build-first-web-service-php/).
 * [Creating a simple REST API in PHP](https://www.leaseweb.com/labs/2015/10/creating-a-simple-rest-api-in-php/).

## PhpDoc

 * [PHPDoc reference](https://docs.phpdoc.org/references/phpdoc/index.html).
 * [Introduction to PhpDoc](https://www.sitepoint.com/introduction-to-phpdoc/).
 * [Documenting code in phpDoc for Laravel 4](https://stackoverflow.com/questions/28292447/documenting-code-in-phpdoc-for-laravel-4).

## Authentication

 * [Secure Login System with PHP and MySQL](https://codeshack.io/secure-login-system-php-mysql/#authenticatinguserswithphp).

## Interesting modules
### PHPUnit

[PHPUnit](https://phpunit.de) is a testing framework.

 * [Getting Started with PHPUnit 8](https://phpunit.de/getting-started/phpunit-8.html).
 * [Assertions](https://phpunit.readthedocs.io/en/8.4/assertions.html).

Install PHPUnit with PEAR system:
```bash
pear config-set auto_discover 1
pear install pear.phpunit.de/PHPUnit
```

Writing a test class:
```php
<?php
use PHPUnit\Framework\TestCase;

final class MyTest extends TestCase {

	public function testSomething(): void {
	}
}
```

### cURL

The [Client URL Library](http://us3.php.net/curl).

### Artichow

[Artichow](http://www.artichow.org/) is a librairy using GD2 for drawing graphics: curves, histograms, anti-spam images, ...

To change background color of a graph, don't forget to put the grid transparent:
```php
<?php
$graph->setBackgroundColor($bkg_color);
$group->grid->setBackgroundColor(New Color(0, 0, 0, 100)); // make grid transparent
?>
```

Make background transparent using color replancement in GD:
```php
<?php
$color_gd = imagecolorallocate($graph->getDriver()->resource, 0xff, 0xff, 0xff);
imagecolortransparent($graph->getDriver()->resource, $color_gd);
?>
```

### MongoDB

 * [MongoDB PHP library](https://docs.mongodb.com/php-library/current/).
 * [MongoDB driver library](http://php.net/manual/en/book.mongo.php).
 * [executeQuery](http://php.net/manual/en/mongodb-driver-manager.executequery.php).

Installation with pecl:
```bash
pecl install mongodb
```

Installation on ArchLinux with pacman:
```bash
pacman -S php-mongodb
```

### Gettext

Internationalization of applications.

 * [Gettext](https://www.php.net/manual/en/book.gettext.php).

How to install gettext module for PHP on macos?

Do we need to enable the following line inside `php.ini`?:
```
;extension=gettext
```

### SOAP

 * [Massbank PHP example](http://www.massbank.jp/manuals/api-doc_en/getRecordInfo.php).

Getting message sent:
```php
<?php
	$soap = new SoapClient(my_wsdl_url, array('trace' => 1));
	$res = $soap->SomeFunction($params);
	echo "REQUEST:\n" . $soap->__getLastRequest() . "\n";
	echo "REQUEST HEADERS:\n" . $soap->__getLastRequestHeaders() . "\n";
?>
```

### MySQL

Connecting:
```php
<?php
mysql_connect("hostname","username","password");
?>
```

Selecting database:
```php
<?php
mysql_select_db("database name", $link_id);
?>
```

List databases:
```php
<?php
$result = mysql_list_dbs($link_id);
?>
```

List tables:
```php
<?php
$result = mysql_list_tables("database name", $link_id);
?>
```

Fields info:
```php
<?php
$field = mysql_list_fields("database name", "table name", $link_id);
mysql_field_flags($field);
mysql_field_len($field);
mysql_field_name($field);
mysql_field_type($field);
?>
```

Query:
```php
<?php
$query_id = mysql_query("MySQL Query", $link_id);
mysql_fetch_row($query_id);
mysql_fetch_array($query_id);
mysql_data_seek($query_id, $row_number); // first row has index 0
?>
```

Query Statement Statistics:
```php
<?php
mysql_num_rows($query_id);
mysql_num_fields($query_id);
mysql_affected_rows($query_id);
mysql_insert_id($query_id); // gives back the automatically inserted id in the new row, if there's one.
?>
```

Escape query string before using it:
```php
<?php
$string = addslashes($string);
?>
```

Error:
```php
<?php
mysql_error($link_id);
?>
```

Create/remove a database:
```php
<?php
mysql_create_db("database name", $link_id);
mysql_drop_db("database_name", $link_id);
?>
```

### ODBC

Open & close connection:
```php
<?php
$connect = odbc_connect("mydb", "mylogin", "mypasswd");
odbc_close($connect);
?>
```

Perform a query:
```php
<?php
$result = odbc_exec($connect, "SELECT name, surname FROM users");
?>
```

Fetch the data from the database:
```php
<?php
while(odbc_fetch_row($result)) {
	$name = odbc_result($result, 1);
	$surname = odbc_result($result, 2);
	print("$name $surname\n");
}
?>
```

