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

### System call

Call program:
```ruby
system "myprog", "arg1", "arg2"
```

## Nil

Test if an object is nil:
```ruby
if myobj.nil?
  do_something
end
```

## File system

Create a file:
```ruby
File.open('myfile.txt', 'w') { |file| file.write("mytext") }
```
