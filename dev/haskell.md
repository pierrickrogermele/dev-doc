<!-- vimvars: b:markdown_embedded_syntax={'haskell':''} -->
# Haskell

 * [Haskell](https://en.wikibooks.org/wiki/Haskell).
 * [Haskell/Indentation](https://en.wikibooks.org/wiki/Haskell/Indentation).

Bookmark:
<https://en.wikibooks.org/wiki/Haskell/Type_basics>

## Run

Running interactively:
```sh
ghci
```
`Ctrl-d` to exit, `:?` for help.

## Comments

A single line comment:
```haskell
-- My comment
x = 1 -- My other comment
```

Multi-lines comment:
```haskell
y = 2 {- My multi-lines
	Comment -}
```

## Types

Integer:
```haskell
'100
```

Float:
```haskell
9.15
```

Boolean:
```haskell
True
False
```

Char:
```haskell
'z'
```

### Strings

A string is a list of characters:
```haskell
"My String"
-- same as:
['M', 'y', ' ', 'S', 't', 'r', 'i', 'n', 'g']
```

### Lists

```haskell
let v = [1, 2, 4]
```

Putting two lists together (slow if first list is big):
```haskell
[1, 2, 3] ++ [4, 5]
```

Inserting at the beginning of a list:
```haskell
'A' : " nice tree"
-- gives:
"A nice tree"
```

Accessing a list by index (indices start at 0):
```haskell
"ABCDE" !! 3 -- Returns 'D'
```

Getting first and last elements:
```haskell
head mylist -- Returns first element
last mylist -- Returns last element
tail mylist -- Returns all but first element
init mylist -- Returns all but last element
```

Getting the length of a list:
```haskell
length [1, 2, 3]
```

## Built-in constants/variables

```haskell
pi
```

## Variables

A variable in Haskell gets defined only once and cannot change.
==> All variables are immutable.
==> Order of variable declarations has no importance.

Set a variable:
```haskell
r = 6.0
```

Is `let` keyword optional?:
```haskell
let a = 1
```

## Statements

### if then else

```haskell
if x < 10 then x + 1 else x - 1
```

### where

The `where` statement is used to define local variables inside a function:
```haskell
MyFct x y z =  (x + y) / a + (y + z) / b
  where
  a = MyFct2(x+y)
  b = MyFct2(y+z)
```

### guards (switch/case)

```haskell
absolute x
    | x < 0     = -x
    | otherwise = x
```

Use of `where` inside guards:
```haskell
numOfRealSolutions a b c
    | disc > 0  = 2
    | disc == 0 = 1
    | otherwise = 0
        where
        disc = b^2 - 4*a*c
```

## Operators

Equality test:
```haskell
1 == 0
```

Inequality test:
```haskell
1 /= 0
```

Boolean operators:
```haskell
(1 == 2) && True
(1 > 2) || True
not False
```

The `$` operator replaces the use of parenthesis. Everything on the right of the operator will take precedence:
```haskell
myFunc (1 + 2) -- is equivalent to:
myFunc $ 1 + 2
```

The `.` operator chains function calls:
```haskell
myFunc1(myFunc2(10))    -- is equivalent to:
(myFunc1 . myFunc2)(10) -- and:
myFunc1 . myFunc2 $ 10
```

## Functions

Function names can contain apostrophe characters. Put at then end of a function's name, it usually means: "a strict version of a function (one that isn't lazy) or a slightly modified version of a function".

Two types:
 * infix: like binary operatos `*`, `+`, ...
 * prefix: like `min` or `succ`.

If a prefix function takes two arguments, we can still call it as an infix function by using backticks:
```haskell
10 `div` 2
-- is equivalement to
div 10 2
```

Defining a function:
```haskell
MyFct x = x + x
```

Parenthesis can be used when calling a function, and are necessary in some cases because a function takes precendence to other operators:
```haskell
MyFct 3 * 5 -- same as MyFct(3) * 5
MyFct(3) * 5 -- same as previous
MyFct(3 * 5) -- 
```

Function with multiple parameters:
```haskell
MyFct x y  = x + y
```

## succ

Returns the successor:
```haskell
succ 8 -- Returns 9
```

## min and max

```haskell
min 9 10
max 1.2 6.7
```

## Errors

```
    Could not find module ‘System.Environment’
    There are files missing in the ‘base-4.14.0.0’ package,
    try running 'ghc-pkg check'.
    Use -v (or `:set -v` in ghci) to see a list of the files searched for.
 
```
See <https://wiki.archlinux.org/index.php/Haskell#Installation> about "Problems with linking". `cabal` needs to be invoked with shared libraries use enabled.
Set the following lines:
```haskell
library-vanilla: False
shared: True
executable-dynamic: True
program-default-options
  ghc-options:
    -dynamic
```
inside `~/.cabal/config`.

## Hackage

 * [Hackage: The Haskell Package Repository](https://hackage.haskell.org/).

Use `cabal-install` package to install packages.

To download package list (needed before first install):
```sh
cabal update
```

Install a package:
```sh
cabal install mypkg
```
