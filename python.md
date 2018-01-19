PYTHON
======

 * [Cheat Sheet: Writing Python 2-3 compatible code](http://python-future.org/compatible_idioms.html).

## Installing

### Virtual environments

 * [Installing virtualenv](http://virtualenv.readthedocs.org/en/latest/installation.html).

```bash
pip install virtualenv
```

Create a virtual env:
```bash
virtualenv my/venv/dir
```

Specify a python version:
```bash
virtualenv -p python2.7 my/venv/dir
```

Activating a virtual env:
```bash
source my/venv/dir/bin/activate
```

Deactivating a virtual env:
```bash
deactivate
```

### Installing different versions of Python

Installating specific versions of Python in Homebrew:
```bash
brew update
brew install pyenv
pyenv install 3.3.6
pyenv versions
```

For activating a virtual environment:
```bash
. .venv/bin/activate
```

 * [Installing Python 3.6 on Debian](https://unix.stackexchange.com/questions/332641/how-to-install-python-3-6).

## Running

It is possible to write a python file that can be either imported as a module or run as a script. For this you have to test the `__name__` built-in variable:
```python
if __name__ == '__main__':
    # Running as a script
```
	
On Windows OS:
 1. `.py` files are associated with `python.exe`.
 2. `.pyw` extension specifies that this is a Python GUI app, so the console is hidden.

Interactive mode:
```python
python
```
`sys.argv[0]` is set to "-".
Variable `_` stores the last result.

## Debugging

 * [pdb - The Python Debugger](https://docs.python.org/2/library/pdb.html).

To run `pdb` on a script:
```bash
python -m pdb myscript.py
```

Command | Description
------- | -----------------------------
`r`     | Run the script.

## Source file encoding

[PEP 263 -- Defining Python Source Code Encodings](https://www.python.org/dev/peps/pep-0263/).

To set encoding of the source code in a Python script, put one of the following lines (compatible with popular editors like emacs and vim) at the first or second line of the file:
```python
# -*- coding: <encoding> -*-
# coding=<encoding>
# vim: set fileencoding=<encoding> :
```
Where `<encoding>` can be any valid encoding name (`iso-8859-15`, `utf8`, ...).
The line must match the regular expression `^[ \t\v]*#.*?coding[:=][ \t]*([-_.a-zA-Z0-9]+)`.

If your editor supports saving files as UTF-8 with a UTF-8 byte order mark (aka BOM), you can use that instead of an encoding declaration.

## Types & variables

Getting the type of a variable:
```python
type(myvar)
```
Returns an object of type `type`.

Testing the type:
```python
if isinstance(myvar, str):
	do_something()
```

### Constants

There are no constants in Python.

### Mutability

 * [PYTHON OBJECTS: MUTABLE VS. IMMUTABLE](https://codehabitude.com/2013/12/24/python-objects-mutable-vs-immutable/).

### None

None is the equivalent of NULL in Python:
```python
myvar = None
```

A None value is of type NoneType.

Testing if a variable is None:
```python
if myvar is None:
	do_something()
```

Testing if a variable is NOT None:
```python
if myvar is not None:
	do_something()
```

### Boolean
	
```python
flag = True
on = False
bool_val = bool(v)
```
	
### Complex

Complex numbers are written with j or J as suffix for the imaginary part, or with the constructor `complex()`:
```python
z1 = 1j
z2 = 3+2J
z3 = complex(3,4)
```

Get real and imaginary parts:
```python
z1.real
z1.imag
```
	
### Integer

Convert a string into an integer:
```python
i = int("-120")
```

### Strings

Unicode string:
```python
u'My unicode string: voilà \u1234 !';
```
Encoding a unicode string into utf-8:
```python
u"äöü".encode('utf-8') # gives '\xc3\xa4\xc3\xb6\xc3\xbc'
```
Decoding from utf-8 to unicode:
```python
unicode('\xc3\xa4\xc3\xb6\xc3\xbc', 'utf-8') # gives u'\xe4\xf6\xfc'
```

Writing a string on multiple lines using backslash:
```python
hello = "This is a rather long string containing\n\
	 several lines of text just as you would do in C.\n\
	 Note that whitespace at the beginning of the line is\ significant."
```

Convert a value/object into a human readable string:
```python
str(v)
```

Convert a value/object into a interpreter-compatible string:
```python
repr(v)
```
For instance, for a string repr() adds quotes and backslashes.
There exists another version of repr which abbreviates the display in case of large container:
```python
import repr
repr.repr(set(’supercalifragilisticexpialidocious’))
```

Multi-lines string:
```python
s = """
Usage: thingy [OPTIONS]
	-h			Display this usage message
	-H hostname		Hostname to connect to
"""
```

Raw string:
```python
# no backslashes are interpeted
s = r"ABCD\n\EFG"
# can be used in conjuncion with multi-lines string:
s = r"""ABC\n
EFG"""
```

Concatenation:
```python
s = 'AB' + 'CD'
```

Append characters to the end of a string:
```python
s += 'blabla'
```

Repeat a string:
```python
s = s * 10
```

Substring:
```python
s[3] # index of char
s[2:5] # two indices defining a substring (last index is excluded)
s[2:]
s[:5]
```
Negative indices start counting from the right:
```python
s[-1] # last char
s[-3]
s[-2:]
s[:-3]
```

Strings are read-only:
```python
s[2] = 'z' # ILLEGAL !
```

Split a string into a list:
```python
mylist = s.split(',')
```

Split all characters of a string (i.e.: transform a string into a list of its characters):
```python
chars = list('My string text')
```

Join:
```python
import string
s = ','.join(mylist)
s = string.join(mylist, ',')	# <--- not portable ?
```

Template strings:
```python
from string import Template

t = Template('${village}folk send $$10 to $cause.')
s = t.substitute(village='Nottingham', cause='the ditch fund')

t = Template('Return the $item to $owner.')
d = dict(item='unladen swallow')
s = t.substitute(d)	# Raises an KeyError exception because no value is provided for the key 'owner'.
s = t.safe_substitute(d) # Raises no exception.

# Template subclasses can specify a custom delimiter.
class MyTemplateClass(Template):
	delimiter='%'
t = MyTemplateClass("Hello %name !")
```

Stripping white spaces (trip spaces, tabs, new lines, ...):
```python
s2 = s.strip()	# strip at both end
s2 = s.lstrip()	# strip at left
s2 = s.rstrip()	# strip at right
```

Uppercase and lowercase:
```python
s2 = s.lower()
```

To string function `str()`:
```python
def __str__(self):
	# ...
	return some_string
```

Char functions:
```python
i = ord('A') # return the unicode code point of the character
c = unichr(i) # return the unicode character corresponding to the unicode code ppoint
c = chr(115) # return the characters corresponding to the ASCII code specified
```

Convert integer to string:
```python
s = str(10)
```

### Lists

 * [Data Structure](https://docs.python.org/3/tutorial/datastructures.html).
	
A list, as a string, is a sequence.
	
Declare a list:
```python
a = [’spam’, ’eggs’, 100, 1234]
```
	
Use the `range` function to create a list:
```python
range(10)           # --> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
range(1, 11)        # --> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
range(0, 30, 5)     # --> [0, 5, 10, 15, 20, 25]
range(0, 10, 3)     # --> [0, 3, 6, 9]
range(0, -10, -1)   # --> [0, -1, -2, -3, -4, -5, -6, -7, -8, -9]
range(0)            # --> []
range(1, 0)         # --> []
```
In Python 2 `range()` returns a list. However in Python 3 it returns an iterator (same as function `xrange()` in Python 2). See [Python’s range() Function Explained](http://pythoncentral.io/pythons-range-function-explained/).

Access:
```python
a[0]
a[-2] # start from end
a[1:3] # both are indices
```
	
Test if an element is in a list:
```python
if x in my_list:
	pass
```

Concatenate:
```python
a + b
```
	
Repeat:
```python
a * 10
```
	
Assignment:
```python
a[3] = 18
```
	
Replace:
```python
a[1:3] = [3, 4]
```
	
Remove elements:
```python
a[0:2] = []
a.remove(x)	# remove the first item whose value is x
a.pop()		# removes and returns last element
a.pop(i)	# removes and returns element at index i
del a[i]	# removes element at index i
del a[3:7]	# removes range
del a[:]	# clear list
del a		# deletes variable
```
	
Append:
```python
a[len(a):] = [x]
a.append(a_single_item)
a.extend(another_list)
a[len(a):] = another_list
```
	
Insert:
```python
a[1:1] = ['ABC', 14]
a.insert(1, x)
```
	
Clear:
```python
a[:] = []
```
	
Search:
```python
a.index(x)	# returns the index of the first item whose value is x
a.count(x)	# returns the number of times x appears in the list
```
	
Length:
```python
len(a)
```

Modifyng functions:
```python
a.sort()	# sort, in place
a.reverse()	# reverse list, in place
```
	
Filter:
```python
filter(myfunc, mylist)	# returns elements for which myfunc evaluates to true
map(myfunc, mylist)	# returns a list of elements myfunc(mylist[i])
reduce(myfunc, mylist, starting_value)	# returns the result of applying myfunc on all the list
def add(x,y): return x+y
reduce(add, range(1,11)) # returns 1+2+3+...+11
```
	
Stack & queue:
```python
a.pop() a.append(x)	# functions to use for a stack
a.pop(0) a.append(x)	# functions to use for a queue
```
	
Nested lists:
```python
q = [2, 3]
p = [1, q, 4]
```
`p[1]` and `q` point to the same object.
	
Create a list of numbers:
```python
range(stop)
range(start, stop, step)
range(5, 10) # [5, 6, 7, 8, 9]
range(0, 10, 3) # [0, 3, 6, 9]
range(-10, -100, -30) # [-10, -40, -70]
```

Iterate over indices of a list:
```python
for i in xrange(len(data)):
	data[i] = ...
```

Iterate over indices and elements of a list:
```python
for i, x in enumerate(data):
	data[i] = "something" if x > 24 else "something else"
```

Iterate over indices of a list with enumerate but forget about the elements:
```python
for i, _ in enumerate(data):
	data[i] = "something"
```
	
List comprehension is a concise way to transform a list:
```python
[3*x for x in vec]
[s.strip() for s in mylist]
```
Nested list comprehensions for swapping rows and columns:
```python
mat = [
	[1, 2, 3],
	[4, 5, 6],
	[7, 8, 9],
	  ]
[[row[i] for row in mat] for i in [0, 1, 2]] [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
```

#### Yield

The `yield` statement creates a generator function to iterate over a list.
The function issuing the `yield` is frozen and will be resumed after the end of the iteration or if something wrong happens and if the `yield` is put inside a try statement, the finally clause will be executed.

 * [What does the yield keyword do in Python?](http://stackoverflow.com/questions/231767/what-does-the-yield-keyword-do-in-python).
 * [The yield statement](https://docs.python.org/2/reference/simple_stmts.html#yield).
	
Generators are a simple and powerful tool for creating iterators.
Defining a generator consists only in defining a function which uses the yield statement instead of the return statement:
```python
def reverse(data):
	for index in range(len(data)-1, -1, -1):
		yield data[index]
```
Usage:
```python
for char in reverse(’golf’):
	print char,
```
This code will print "flog".
	
A generator expression defines a generator inplace. It looks a bit like list comprehensions, but with parentheses instead of brackets:
```python
sum(i*i for i in range(10))		# sum of squares
sum(x*y for x,y in zip(xvec, yvec))	# dot product
sine_table = dict((x, sin(x*pi/180)) for x in range(0, 91))
unique_words = set(word for line in page for word in line.split())
valedictorian = max((student.gpa, student.name) for student in graduates)
list(mystring[i] for i in range(len(,mystring)-1,-1,-1)) # make a list of characters of mystring in reverse order
```

### Sets
	
Construct a set from a list, eliminating all duplicates:
```python
myset = set(mylist)
```

Construct a set of characters from a string:
```python
myset_of_chars = set('astring')
```

Test presence of an element in a set:
```python
myelem in myset
```

Operations of set:
```python
a - b		# elements in a but not in b
a | b		# elements in either a or b
a & b		# elements in both a and b
a ^ b		# elements in a or b but not both
```

Add an element:
```python
myset.add(elem)
```

### Deque
	
```python
from collections import deque
```
	
Deque are like list objects, but with faster append and pop from the left, and slower lookups in the middle.
```python
d = deque(["task1", "task2", "task3"]) >>> d.append("task4")
print "Handling", d.popleft()
```

### Tuples

Tuples are small sequences that are not modifiable:
```python
t = 12345, 54321, ’hello!’
u = t, (1, 2, 3, 4, 5)
empty = ()
singleton = ’hello’,	# <-- note trailing comma
x, y, z = t
```

They can be accessed like lists:
```python
coord = (10, 11) # x,y coordinates
coord[0]
```

### Arrays

Arrays are not available by default. They are plain C-arrays, provided by the array standard library:
```python
from array import array
```

Create an array from a range:
```python
range(start, stop[, step])    # step = 1 by default
```
or
```python
range(length) --> = range(1, length, 1)
```

Create an array of 2 byte unsigned integers (instead of the usual 16 byte int objects):
```python
a = array(’H’, [4000, 10, 700, 22222])
```

Get last element:
```python
a[-1]
```

Get size/length:
```python
n = len(A)
```

Summing an array:
```python
s = sum(a)
```

Summing two arrays of same length:
```python
[A[i]+B[i] for i in range(len(A))]
```

max/min:
```python
m = max(a)
n = min(a)
```

Append:
```python
a.append(4)
```

Pop elements:
```python
a.pop()     # pop last item
a.pop(3)    # pop 3 last items
a.pop([i])  # remove and return element i
```

Replace range of elements:
```python
a[i:j] = x
a[i:j] = [1, 10, 20]
```

Remove elements or range of elements:
```python
a[i:j] = []
del a[i:j]
```

Reverse array:
```python
a.reverse()
```

Insert element:
```python
s.insert(i, x)
s[i:i] = x
```

Count elements:
```python
s.count(x)      # return number of elements such that s[i]==x
```

Search for an element:
```python
s.index(x[, i[, j]])    # return smallest k such that s[k] == x and i <= k < j
```

### Dictionaries

Keys can be string, number of tuple (if the tuple contains only strings, numbers and tuples)

Creation:
```python
mydic = {}
mydic = {'a': 234, 'b': 121, 'c': 1244}
mydic = dict([('a', 23), ('b', 34)]) # use tuples with dict() constructor
mydic = dict([(x, x**2) for x in (2, 4, 6)]) # use a list comprehension
mydic = dict(sape=4139, guido=4127, jack=4098) # use keyword arguments in dict() constructor
```

Access:
```python
mydic['b']
```

Modify:
```python
mydic['c'] = 455
```

Remove:
```python
del mydic['a']
```

Get a list of the keys:
```python
mydic.keys()
```

Search a key:
```python
'e' in mydic
```

Looping:
```python
for k, v in mydic.iteritems():
	print k, v
```

Split a string of key values into a dictionary:
```python
s = 'a=3,b=9,c=10'
mydict = dict(u.split("=") for u in s.split(","))
```

### Structure

To create a struture, one uses an empty class:
```python
class Employee:
	pass
john = Employee()
john.name = 'John'
john.dept = 'compute lab'
```

`struct` module provides pack() and unpack() functions.
"H" and "I" represent two and four byte unsigned intergers.
"<" means little-endian byte order.
```python
import struct
# ...
fields = struct.unpack('<IIIHH', string_with_binary_data[offset:offset+16])
```

## Statements
	
Indentation, instead of curling braces in C, is used to control the grouping of blocks.

### `pass`

The pass statement does nothing. It can be used when a statement is required syntactically but the program requires no action (No-op or NOP).

```python
def myfunc(param1):
	pass
```

### Operators

Operator | Description
-------- | -----------------------
`+`      | Addition (unary plus), or concatenation for strings.
`-`      | Subtraction (unary minus).
`*`      | Multiplication.
`**`     | Exponentiation (raise to the power).
`/`      | Division.
`//`     | Integer division (floor).
`%`      | Modulo.
`<`      | Less than.
`>`      | Greater than.
`<=`     | Less than or equal to.
`>=`     | Greater than or equal to.
`==`     | Equal to.
`!=`     | Not equal to.
`<>`     | An obsolete form of 'not equal to'.

No `--` and `++` operators exist.

Ternary expression:
```python
value = MyVarIsTrue and 'yes' or 'no'
```
In more modern version (>=2.5 ?):
```python
value = 'yes' if MyVarIsTrue else 'no'
```

### Functions

Defining a function:
```python
def myfunc(n):
	# ...
	return some_value
```

For returning several values, use a tuple:
```python
def myfunc():
	return a, b
# ...
x, y = myfunc()
```

Default values for arguments:
```python
def myfunc(n = 2):
	# ...
```
Default values are evaluated at the point of function definition, so they don't need to be constants:
```python
i = 5
def myfunc(n = i):
	# ...
```

Arbitrary number of arguments:
```python
def myfunc(arg1, arg2, *args):
	# ...
```

Argument names can be used as keys to set explicitly each or part of them:
```python
def myfunc(arg1, arg2):
	# ...

myfunc(100, arg2='yesh')
myfunc(arg2='no', arg1=5)
```

To put all keyword arguments (not associated with a formal parameter) inside a dictionary:
```python
def myfunc(**keywords):
	# ...
myfunc(n=1, name='otto')
```
The dictionary can be put after a list, so the list get first all non-keywords arguments first:
```python
def myfunc(arg1, *args, **keywords)
	# ...
```

Passing arguments from a list/tuple as individual arguments:
```python
args = [3, 6]
range(*args)	# The * operator unpack the elements of the list
somefunc(**some_dictionary)	# The ** operator unpack the elements of the dictionary, passing them as keyword/value couples to the function
```

Lamdba function:
```python
lambda a,b: a+b

def make_incrementor(n):
	return lambda x: x + n
f = make_incrementor(42)	# return a lambda function
f(0)	# gives 42
f(1)	# gives 43
```

Inline documentation:
```python
def my_function():
	"""Do nothing, but document it.

	No, really, it doesn’t do anything.
	"""
	pass

print my_function.__doc__
```

Get function reference:
```python
my_func = globals().get('my_func_name')
my_func(arg1, arg2)
```

### Conditions

Boolean operators:
```python
a or b
a and b
not a
```

Tests can be chained:
```python
a < b == c	# tests if a < b and b == c
```

Sequences can be compared:
```python
list1 < list2
list1 == list2
tuple1 == tuple2
string1 > string2
```

Presence of an element in a sequence:
```python
elem in mylist
elemen not in mylist
```

Testing if two objects are the same object (useful for mutable objects like lists):
```python
obj1 is obj2
obj1 is not obj2
```

### If then else
	
```python
if x < 0:
	z = -1
elif x == 0:
	z = 0
else:
	z = 1
```

### For loop

```python
for x in a:	# a is a list
	print x
```

If you need to modify elements, it's safer to make a copy before:
```python
for x in a[:]:
	if len(x) > 6: a.insert(0, x)
```

Iterating on indices:
```python
for i in range(len(a)):
	print i, a[i]
```

to work on a copy:
```python
for x in a[:]: # make a slice copy of the entire list
	if len(x) > 6: a.insert(0, x)
```
	
The break statement, like in C, breaks out of the smallest enclosing for or while loop.
 The continue statement, also borrowed from C, continues with the next iteration of the loop.
	
Loop statements may have an else clause; it is executed when the loop terminates through exhaustion of the list (with for) or when the condition becomes false (with while), but not when the loop is terminated by a break statement.
	
Looping on index and value at the same time:
```python
for i, v in enumerate([’tic’, ’tac’, ’toe’]):
	print i, v
```

Looping on several sequences at the same time:
```python
for i, j in zip(list1, list2):
	# ...
```

Loop in reverse oder:
```python
for i in reversed(range(1,10,2)):
	print i
```

Loop in sorted order:
```python
for f in sorted(set(basket)):
	print f
```

### While loop
	
```python
while i < 100:
	# do something
```

Break, continue and else:
```python
while i < 100: # or a for statement
	# do something
	if condition:
		break
	elif other_condition:
		continue
	# do something else
else:
	# do something when while loop finishes normally (not because of a break statement)
```

### Exceptions
	
Try block:
```python
try:
	# ...
	break
except ValueError:	# catch exception whose type is ValueError
	print "Some error occured !"
except (RuntimeError, TypeError, NameError):
	pass
except:			# catch all exceptions
	print "Unexpected error"
	raise		# throw the exception again
else:
	# put here some code that will be executed only if the try clause doesn't raise an exception
```

The finally clause (clean-up) is always executed, if exceptions occurred in the try clause and aren't caught by the except clauses, if no exceptions occurred, or if an exception occurred inside an except clause or the else clause.
```python
try:
	raise KeyboardInterrupt
finally:				
	print 'Goodbye, world!'
```

One can associated multiple arguments to an exception. However a better practice is to pass only one argument, which may be a tuple. 
```python
try:
	raise Exception('spam', 'eggs')
except Exception as inst:
	print type(inst)
	print inst.args	# arguments stored in .args
	print inst	# __str__ allows args to printed directly
	x,y=inst 	# __getitem__ allows args to be unpacked directly
```

Raising an exception:
```python
raise NameError('This is an error')
raise SomeClass, instance	# where instance must of class SomeClass or class derived from SomeClass.
raise instance	# calls `raise instance.__class__, instance`
```

User-defined exceptions:
```python
class MyError(Exception):
	def __init__(self, value):
		self.value = value
	def __str__(self):
		return repr(self.value)
```
Usage:
```python
try:
	raise MyError(2*2)
except MyError as e:
	print 'My exception occurred, value:', e.value
```

### With

 * [The with statement in Python 2](https://docs.python.org/2/reference/compound_stmts.html#with).

```python
with open(myfilepath, 'rb') as csvfile:
	...
```

The expression between `with` and `as` must return a [context manager](https://docs.python.org/2/reference/datamodel.html#context-managers).

## OOP

Public/private:
All methods and attributes are public in Python.
A common convention is to prefix by an underscore all methods and attributes that we want to be private.
See [Private Variables](https://docs.python.org/3/tutorial/classes.html#private-variables).
	
### Definition

Class definition:
```python
class MyClass:
	"""A simple example class"""
	i = 12345
	def f(self):
		return ’hello world’
```

### Instantation

Class instantiation:
```python
obj = MyClass()
```

Initialization method:
```python
class MyClass:
	def __init__(self):
		self.data = []
class MyComplex:
	def __init__(self, realpart, imagpart):
		self.r = realpart
		self.i = imagpart
```

### Inheritance

Calling mother class' constructor:
```python
class B(A):
	def __init__(self, arg1):
		super(self.__class__, self).__init__(arg1)
```
Does not work in Python 2, but the following works:
```python
class B(A):
	def __init__(self, arg1):
        super(B, self).__init__(arg1)
```
or
```python
class B(A):
	def __init__(self, arg1):
        A._init__(arg1)
```
To pass all parameters to mother class without knowing them use `**kwd`:
```python
class B(A):
	def __init__(self, **kwd):
        super(B, self).__init__(**kwd)
```

You can't define multiple constructors, `__init__()` method is unique.
Solutions are:
 1. Accept different arguments, and test their type inside `__init__()` in order to decide what to do.
 2. Define a factory method using the `@classmethod` attribute.

Reference to class object:
```python
myobject.__class__
```
	
Declaring a method that is defined outside the class:
```python
def myfunc(self, x, y) # absolutely awful !
	return x+y
class MyClass:
	myfunc_in_class = myfunc
```

Inheritance:
```python
class MySubClass(MyBaseClass):
	# ...
```

Testing inheritance:
```python
issubclass(myobj, myclass)
issubclass(bool, int)	 # <-- True
issubclass(unicode, str) # <-- False
```

Multiple inheritance:
```python
class MyDerivedClass(Base1, Base2, Base3):
```
Old-style classes: rule for searching an attribute or method is depth-first, then left-to-right.
New-style classes: the method resolution order changes dynamically to support cooperative calls to super(). --> TODO: search for more explanations.

### Methods

Class method:
```python
@classmethod
def make_from_file(cls, filename):
	# ...
```

Calling a method of a base class:
```python
MyBaseClass.method_name(self, arg1, arg2)
```

Virtual methods: all methods are virtual in Python.

Instance method objects have two attributes:
```python
m.im_self	# The instance object
m.im_func	# the function object
```

### Attributes

Adding a property dynamically to an instance:
```python
setattr(self, property_name, property_value)
```

Testing if an attribute exists:
```python
hasattr(obj, 'name')
```

Looping on all attributes of an object:
```python
for attr, value in myobj.__dict__.iteritems():
	print(str(attr) + ': ' + str(value))
```
`__dict__` is of type `dict`.

### Introspection

Getting class information:
```python
type(myinstance)
```

Getting the class name:
```python
type(myinstance).__name__
```

Testing the class/type of an object:
```python
isinstance(obj, int) # is True if obj.__class__ is int.
```

### Iterators

On an iterable object, one can call `next()` to get the next object in interation:
```python
try:
	x = obj.next()
except StopIteration: # Raised in case no more objects are avaible in the iteration.
	do_something()
```

When looping with for statement, as in:
```python
for element in [1, 2, 3]:
	# do something
```
the interpreter calls `iter()` on the container object, which returns an iterator object that defines method `next()`. `next()` returns the next object of the collection, and when no more objects are available it raises a `StopIteration` exception.

Thus for any user-defined class, one can define an iterator function `__iter__` that will allow to iterate on any instance of that class, using the `for` statement.
The returned iterator instance can be the class instance itself, if it defines the method `next()`, or a specific iterator class.
For instance:
```python
class MyClass:
	def __init__(self, data)
		self.data = data
		self.index = len(data)
	def __iter__(self):
		return self
	def next(self):
		if self.index == 0
			raise StopIteration
		self.index = self.index - 1
		return self.data[self.index]
```
Of course, using the container class as the iterator class isn't satisfactory, since it raises the issue of the index. Only one iteration can be done at a time on a container instance.
Thus using a specific iterator class, and returning a new instance on each `iter()` call, is always a best approach.
		
## System

Run a command:
```python
import os
os.system("C:\\Temp\\a b c\\Notepad.exe")
```

Run a command and get the output:
```python
import subprocess
batcmd="dir"
result = subprocess.check_output(batcmd, shell=True)
```

## File system and I/O

Open a file:
```python
f = open(’/tmp/workfile’, ’w’)
```
Modes are r, w, a and r+ (both reading and writing)
Under Windows OS, there's also the b modifier for binary files: rb, wb, r+b

Close a file:
```python
f.close()
f.closed	# Is set to true when file is closed
```

With statement:
```python
with open('/my/file', 'r') as f:
	read_data = f.read()
```
File is automatically closed when leavin with block.

Read a number of bytes/chars:
```python
f.read(n)
f.read()	# read all file
```
Returns an empty string if EOF is reached.

Read a single line:
```python
s = f.readline()
s1 = s.strip()	# string new line char
```
It doesn't eat the newline character.
Return an empty string when EOF is reached.

Read all lines:
```python
mylist = f.readlines()	# Returns a list of all lines
```

Read lines one by one:
```python
for line in f:
	print line,
```

Write:
```python
f.write(s)
f.write(str(42))
```

Position in a file:
```python
f.seek(n)	# moves
f.tell()	# gives position
```

Pickling: this means the use of the standard module pickle to serialize automatically some arbitrary object:
```python
pickle.dump(x, f)	# serialize object x inside f
x = pickle.load(f)	# unserialize object x from f
```

Standard streams:
```python
sys.stdin
```

Path manipulation:
```python
import os.path
os.path.dirname(path)	# git directory part
(dirname, filename) = os.path.split(path)
path = os.path.join(dirname, filename)
(root, ext) = os.path.splitext(path)
```

Test if file exists:
```python
import os.path
os.path.exists("/my/path/to/file")
```

Glob:
```python
import glob
glob.glob('./[0-9].*')
```

Current working directory:
```python
import os
os.getcwd()
```

## Tail call recursion

If the recursion call is well written, a jump can be used instead of a call. This way there's no stack growth.
```python
def binary_search(x, lst, low=None, high=None) :
	(low, high) = (low or 0, high or len(lst)-1)
	mid = low + (high - low) // 2
	if low > high :
		return None
	elif lst[mid] == x :
		return mid
	elif lst[mid] > x :
		return binary_search(x, lst, low, mid-1)
	else :
		return binary_search(x, lst, mid+1, high)
```

## Reduce

```python
def factorial(num):
	return reduce(lambda x, y: x*y, xrange(1,num), 1)
```

## Command line

Command line arguments are stored inside sys.argv list:
```python
sys.argv[0] # contains the program's name
```

To parse command line, use `argparse`:
```python
import argparse
```
See [argparse](https://docs.python.org/3/library/argparse.html#module-argparse).

Create parser:
```python
parser = argparse.ArgumentParser(description='Some description.')
```

Add argument:
```python
parser.add_argument('box_file', metavar='boxfile', type=str, default=None, help="Box file.", nargs="?")
parser.add_argument('-p', help='prefix for cell names', dest='cell_prefix', required=True)
```
Argument | Description
-------- | ---------------------
metavar  | The name of the argument in the help message.
help     | The help message.
nargs    | Number of time the argument value may appear: `"?"` means 0 or 1, `"*"` means 0 or plus, `"+"` means 1 or plus, or a number for an exact number of times.

Parsing the arguments:
```python
args = parser.parse_args()	# args is an object of type argparse. To access an argument type args.myargname
args_dict = vars(args)		# transform args into a dictionary. To access an argument type args_dict['myargname']
```

## Printing

In Python v3 the parenthesis are compulsory for print function.
In Python version 2.7.2, `print` is a statement and doesn't need parenthesis. However it supports them and they are needed in Python 3, since print becomes a function.
Thus it is always preferable to put parenthesis.
```python
print(mylist, sep=',', end="\n")
```
To get the behaviour of the Python 3 `print()` function into Python 2, use the `__future__` library:
```python
from __future__ import print_function
print(mylist, sep=',', end="\n")
```

Format:
```python
print '{0:2d}'.format(x)
print '{0} {1}'.format(s1, s2)
print '{tag} {0}'.format(v, tag='mystring')
print '{0:.3f}'.format(x)
print '{0:10} {1:8d}'.format(s, i)	# field 0 is 10 columns wide, and field 1 is 8 columns wide.
```

Giving a dictionary to format:
```python
table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
print ('Jack: {0[Jack]:d}; Sjoerd: {0[Sjoerd]:d}; Dcab: {0[Dcab]:d}'.format(table))
```
OR
```python
table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
print 'Jack: {Jack:d}; Sjoerd: {Sjoerd:d}; Dcab: {Dcab:d}'.format(**table)
```

`printf` style:
```python
print 'The value of PI is approximately %5.3f.' % math.pi
```

Space is inserted automatically between two comma separated items:
```python
print 'The value of i is', i
```
OUTPUT: The value of i is 234

a comma at the end avoid automatic insertion of a new line:
```python
i = 0
while i < 2:
	print "yesh",
```
OUTPUT: yesh yesh

Justification:
```python
print s.rjust(6)	# right justify a string in a field of width 6
print s.ljust(5)	# left justify a string
print s.center(4)	# center a string
```

Padding a numeric string:
```python
print '12'.zfill(5)	# Pads 3 zeros before the number 12
print '-3.14'.zfill(7)
```

Prints an object with indentation and line breaks:
```python
import pprint
pprint.pprint(mycontainer, width=30)
```

Text WRAP:
```python
import textwrap
print textwrap.fill(mystring, width=40)
```

## Regex

Regex library:
```python
import re
```

Match --> checks for a match only at the beginning of the string:
```python
re.match("c", "abcdef")  # No match
```

Search --> checks for a match anywhere in the string (like in Perl):
```python
re.search("c", "abcdef") # Match
```

Grouping:
```python
m = re.search('(?<=abc)def', 'abcdef')
m.group(1)	# first group
m.group(0)	# whole matched string
```

Compile --> compile a regexp into an object, so evaluation is faster:
```python
compiled_re = re.compile(pattern)
result = compiled_re.match(string)
```

## Conda

For installing miniconda see [Miniconda](https://conda.io/miniconda.html). On macos you can also use Homebrew:
```bash
brew cask install miniconda
```

### Bioconda recipes

 * [Contributing a recipe](https://bioconda.github.io/contribute-a-recipe.html).

## Packages and modules

A module is a file with `.py` and whose name is the module's name.

Within a module, the module's name can be access thanks to the variable `__name__`.

Importing a module:
```python
import mymodule
```

Accessing a function or a variable of a module:
```python
mymodule.myfunc()
mymodule.__name__
```

Importing a function of a module directly into the local symbol table:
```python
from mymodule import myfunc, myfunc2
from mymodule import *			# import all names except those beginning with an underscore
```
Then the functions are directly accessible, and the imported module itself isn't included inside the local symbol table:
```python
myfunc()
```

Renaming a function of a module:
```python
myfunc_localname = mymodule.myfunc
```

Reload a module:
```python
reload(mymodule)
```

List of defined names in a module:
```python
dir(sys)	# list names of sys library
dir()		# list names of current library
dir(__builtin__)	# list names of built-in functions and variables
```

### Using a module as a main program

It's possible to run a module as program with the command:
```python
python mymodule.py <arguments>
```
In that case it is possible for the module to know that it's running as a script by testing the `__name__` variable which will be set to `__main__`:
```python
if __name__ == "__main__":
	import sys
	myfunc(int(sys.argv[1]))
```

### Search path

When importing a module the directories contained in `sys.path` are searched.
`sys.path` is initialized to:
 * `.` (local directory).
 * Directories in env var `PYTHONPATH`.
 * Python installation directory (e.g.: `/usr/local/lib/python`).
`sys.path` is modifyable at run-time.

Compiled version of a module:
Module files `.py` are compiled as `.pyc`. If a `.pyc` is present, and up-to-date compared to the `.py`, then it is loaded instead of the `.py`.
Code run at the same speed, but the module loading is faster with `.pyc` than with a `.py`.
It is possible to distribute `.pyc` instead of `.py`, in order to avoid easy reading of the code.
The module `compileall` can create `.pyc` files for all modules in a directory.

### Modules installation
	
Getting list of modules from inside python:
```bash
python -c "help('modules')"
```

Installing a new module (from UNIX shell):
```bash
tar -xzf some-package.tar.gz
cd some-package
python setup.py install
```

Other ways:
```bash
easy_install <package>
```

New way with `pip`:
```bash
easy_install pip
pip install <package>
pip uninstall <package>
```

In Homebrew, type `brew info python` for more information.

Upgrade `setuptools` & `pip`:
```bash
pip install --upgrade setuptools
pip install --upgrade pip
```

See [Installing Python Modules](https://docs.python.org/2/install/) for installing packages in the user home directory. For installing in `/.local`, use `--user` option:
```bash
pip install --user mymodule
```

How to install from a GitHub repos:
```bash
pip install --user git+https://github.com/ISA-tools/isa-api@develop
```

### Packages
	
A package is a directory containing module files or other package directories.
It also contains a `__init__.py` file, which in its simplest form is an empty file.

Importing a module defined inside a package:
```python
import pkg.subpkg.mymodule
pkg.subpkg.mymodule.myfunc()	# myfunc must be fully referenced
```
or
```python
from pkg.subpkg import mymoduyle
mymodule.myfunc()
```
or
```python
from pkg.subpkg.mymodule import myfunc
myfunc()
```

Importing all:
```python
from pkg import *	# import everything in the __all__ list defined inside __init__.py
```
This behaviour is explained by the fact that under Microsoft OS like Windows 95 or MS-DOS, there are ambiguities about file names, and thus about module names, so they need to be properly defined somewhere.
```python
__all__ = ["echo", "surround", "reverse"]
```

Crossreferences: two modules can import each other. In fact it is so common in Python that before looking on disk, the module importer looks among already loaded modules.

Using a relative path when importing:
```python
from . import module
from .. import module2
from ..package import module3
```

## Some interesting libraries

### csv

To read CSV file in both Python 2 and 3:
```python
import sys
import csv
if sys.version_info[0] < 3: 
    fp = open(path, 'rb')
else:
    fp = open(path, 'r', newline='', encoding='utf8')
reader = csv.reader(fp)
```

### Decimal
	
The decimal module offers a Decimal datatype for decimal floating point arithmetic.
```python
from decimal import *

Decimal(’0.70’) * Decimal(’1.05’) # gives Decimal("0.7350")
.70 * 1.05 # gives 0.73499999999999999

Decimal(’1.00’) % Decimal(’.10’) # gives Decimal("0.00")
1.00 % 0.10 # gives 0.09999999999999995

sum([Decimal(’0.1’)]*10) == Decimal(’1.0’) # is True
sum([0.1]*10) == 1.0 # is False
```

Precision can be setup:
```python
getcontext().prec = 36
Decimal(1) / Decimal(7) # gives Decimal("0.142857142857142857142857142857142857")
```

### PyQt

Install on MacOS-X with Homebrew:
```bash
brew install pyqt
```

Hello World sample:
```python
from PyQt4 import Qt

app=Qt.QApplication(["Hello World App"])
hello = Qt.QLabel("Hello, World") # we must store the widget in a variable because it's a TOP widget, otherwise it will be destroyed when reaching app.exec_() call
hello.show()
app.exec_()
```

### PyTest

Running tests:
```bash
cd tests
py.test
```

Enable displaying of stdout and stderr:
```bash
py.test -s
```

### unittest

Running tests from files in tests subfolder:
```bash
python -m unittest tests.my_filename
```

### Tox

Automate Python code testing.

 * [TOX home page](https://testrun.org/tox/latest/).

To install:
```bash
pip install tox
```
or
```bash
easy_install tox
```

To launch tests, you need to `tox.ini` file and run:
```bash
tox
```

### Bisect

Bisect is a module for working on a sorted list:
```python
import bisect
scores = [(100, ’perl’), (200, ’tcl’), (400, ’lua’), (500, ’python’)]
bisect.insort(scores, (300, ’ruby’))
```

### heapq
	
Module for implementing heaps based on regular lists.
	
The lowest valued entry is always kept at position zero. This is useful for applications which repeatedly access the smallest element but do not want to run a full list sort.

```python
from heapq import heapify, heappop, heappush
data = [1, 3, 5, 7, 9, 2, 4, 6, 8, 0]
heapify(data) # rearrange the list into heap order
heappush(data, -5) # add a new entry
[heappop(data) for i in range(3)] # fetch the three smallest entries
# result is [-5, 0, 1]
```

### PIL (Python Image Library)
	
```python
from PIL import Image, ImageDraw
```
	
### locale

```python
import locale
locale.setlocale(locale.LC_ALL, ’English_United States.1252’)
conv = locale.localeconv() # get a mapping of conventions
```

Printing an integer number:
```python
locale.format("%d", x, grouping=True)
```

Printing an amount of money:
```python
locale.format("%s%.*f",
		(conv[’currency_symbol’], conv[’frac_digits’], x),
		grouping=True)
```

### logging
	
```python
import logging
logging.debug(’Debugging information’)
logging.info(’Informational message’)
logging.warning(’Warning:config file %s not found’, ’server.conf’)
logging.error(’Error occurred’)
logging.critical(’Critical error -- shutting down’)
```

Possible outputs: file, stderr, email, datagrams, sockets, HTTP Server.

### math

```python
import math
```

Ceil:
```python
y = math.ceil(x)	# takes a float and returns a float
```

Square root:
```python
y = math.sqrt(x)
```

Maximum value of a float:
```python
sys.float_info.max
```
### Threading

```python
import threading

class MyThread(threading.Thread):
	def run(self):
		# ...

thread_instance = MyThread()
thread_instance.start()
# ...
thread_instance.join()
```

The `threading` module provides: locks, events, condition variables and semaphores.

An easy way to synchronize threads on data is to use the Queue module.

### Pygments

Module and program (`pygmentize`) for syntax highlighting.

List all stylesheets:
```bash
pygmentize -L styles
```

List all handled languages:
```bash
pygmentize -L lexers
```

### random

```bash
import random
```

Integer:
```python
i = random.randint(1,1000)
```
Float:
```python
x = random.random() # in [0.0, 1.0)
```

### `weakref` (weak references)

```python
import weakref, gc
```

General explanation of behaviour:
```python
obj = SomeClass()
d = weakref.WeakValueDictionary()
d['akey'] = obj		# doesn't create a reference
d['akey']		# returns the object obj
del obj			# remove the unique reference
gc.collect()		# ensure that the reference and data are removed from memory
d['akey']		# <-- Raises a KeyError exception
```

Creating a single weak reference:
```python
my_weak_ref = weakref.ref(myobj)
```

### `bundleBuilder`

[bundleBuilder](https://wiki.python.org/moin/MacPython/BundleBuilder) is a package for building a macOS application.

### `py2app`

Program that builds a macOS application bundle.
See [py2app](https://pythonhosted.org/py2app/).

Make `setup.py`:
```bash
py2applet --make-setup MyApplication.py
```

Example of `setup.py` file:
```python
#!/usr/bin/env python
from setuptools import setup
import py2app

setup(
	app=['myApp.py'],
	options=dict(
	    py2app=dict(
	        packages=['mechanize'],
	        site_packages=True,
	    ),
	),
)
```

Clean up build directories:
```bash
rm -rf build dist
```

Building with alias mode builds an application bundle that uses your source and data files in-place:
```bash
python setup.py py2app -A
```

Build for deployment:
```bash
python setup.py py2app
```
---> ERROR
	> /opt/local/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/site-packages/macholib/ptypes.py(48)from_str()
	-> return cls.from_tuple(struct.unpack(endian + cls._format_, s), **kw)
	(Pdb)

Running the application:
```bash
./dist/MyApplication.app/Contents/MacOS/MyApplication
```
or
```bash
open -a dist/MyApplication.app
```

To see stdout and stderr, open the console:
```bash
open -a Console
```

### Pandas

 * [Pandas](https://pandas.pydata.org/).
 * [Data frames](https://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.html).

Test if a data frame contains a column:
```python
if mydf.keys().contains('mycol'):
	pass
```
