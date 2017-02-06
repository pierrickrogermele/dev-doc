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

## Style conventions

 * [Ruby style guide](https://github.com/bbatsov/ruby-style-guide).

For indentation, use 2 spaces, no tabs.

## Types & variables

### Nil

Test if an object is nil:
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

### Arrays

Check if a value is inside an array:
```ruby
is_in_array = ['zap', 'hop', 'plouf'].include? 'zap'
```

## Operators

 * [Ruby Operators](https://www.tutorialspoint.com/ruby/ruby_operators.htm).

Ternary operator:
```ruby
x = a == 1 ? a : a * 2  
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

### Logical operators

```ruby
enabled = ! a.nil? and a == 5
```

### Function

```ruby
def envvar_enabled(x)
  x + 5
end
```

### System call

Call program:
```ruby
system "myprog", "arg1", "arg2"
```

## File system

Create a file:
```ruby
File.open('myfile.txt', 'w') { |file| file.write("mytext") }
```
