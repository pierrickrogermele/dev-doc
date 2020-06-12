RUBY
====

## Installation

macOS: Ruby is already installed, but you can install a more recent version using brew:
```bash
brew install ruby
```

## Packages (Ruby gems)

```bash
sudo gem install mypackage
sudo gem uninstall mypackage
```

Quick help:
```bash
gem help
```

List all commands:
```bash
gem help commands
```

Help about one command:
```bash
gem help the_command
```

## Running

Interactive session:

```bash
irb
```

## Style conventions

 * [Ruby style guide](https://github.com/bbatsov/ruby-style-guide).

For indentation, use 2 spaces, no tabs.

## Types & variables

### Get or test type

Test type
```ruby
if myvar.kind_of?(String)
	do_something
end
```

### Global variables

Declare a global variable:
```ruby
$myglobalvar = 1
```

### Nil

Set a variable to nil:
```ruby
myvar = nil
```

Test if a variable is set to nil:
```ruby
if myobj.nil?
  do_something
end
```

### Environment variables

```ruby
myenvvar = ENV['MY_ENV_VAR']
```

### Strings

Put in lowercase:
```ruby
s = 'My String'.lowercase
```

Test string equality:
```ruby
s == 'bof'
```
or
```ruby
s.eql? 'bof'
```

String interpolation:
```ruby
s = "Using some var inside a literal string: #{some.other.string.var}."
```

Split string into array:
```ruby
s.split(',')
s.split(/[a-z]/)
```

Regex match:
```ruby
s = 'My string'[/^.* (.*)$/, 1]
```

### Arrays

Create an array:
```ruby
myarray = ['1', '2', 'a']
```

Check if a value is inside an array:
```ruby
is_in_array = ['zap', 'hop', 'plouf'].include? 'zap'
```

Push in an array:
```ruby
myarray.push('x', 'y')
```

## Dictionnaries

Define a dictionary:
```ruby
mydict = {
	'mykey' => 23
}
```

Access a key:
```ruby
mydict['mykey']
```

Test if a key exists:
```ruby
mydict.key?('mykey')
```

## Operators

 * [Ruby Operators](https://www.tutorialspoint.com/ruby/ruby_operators.htm).

Ternary operator:
```ruby
x = a == 1 ? a : a * 2  
```

And:
```ruby
myvar1 and myvar2
myvar1 && myvar2
```

Or:
```ruby
myvar1 or myvar2
myvar1 || myvar2
```

Not:
```ruby
not myvar
! myvar
```

## Statements

### If

```ruby
if somecond
  do_something
elsif someothercond
  do_something_else
else
  do_something_else_else
end
```

### Loop

For loop:
```ruby
s = 0
for i in myarray
	s += i
end
```

Ruby style loop:
```ruby
myarray.each do |i|
	s += i
end
```
or
```ruby
myarray.each { |i| s += i }
```

### Logical operators

```ruby
enabled = ! a.nil? and a == 5
```

### Function

Simple function:
```ruby
def envvar_enabled(x)
  x + 5
end
```
The returned value is the result of the last evaluated statement.

Explicit returned value:
```ruby
def envvar_enabled(x)
  x + 5
  return x
end
```

### System call

Call program:
```ruby
system "myprog", "arg1", "arg2"
```

## Printing text

```ruby
puts('My text')
```

## File system

Create a file:
```ruby
File.open('myfile.txt', 'w') { |file| file.write("mytext") }
```

List files matching pattern:
```ruby
Dir.glob('*.txt') { |file| do.something(file) }
```

## Include a file

Use `require` (as for library), to load a file only once even if `require` is called more than once:
```ruby
require 'my_file' # File `my_file.rb` will be loaded.
```

`load` includes a file each time it is called:
```ruby
load 'my_file.rb'
```
