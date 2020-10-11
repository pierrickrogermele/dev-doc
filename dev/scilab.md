<!-- vimvars: b:markdown_embedded_syntax={'scilab':'','sh':'bash'} -->
# SciLab

 * [Matlab/Scilab equivalence](http://www.scribd.com/doc/13085645/Matlab-Scilab-Equivalent).

## Install

### macos

Install .dmg from official site.

Add the following directory to the PATH:
	/Applications/scilab-5.4.1.app/Contents/MacOS/bin

Error when running scilab from command line:
	the library libstdc++.6.dylib isn't found.
Go to Scilab bin directory :
```sh
cd /Applications/scilab-5.4.1.app/Contents/MacOS/bin
install_name_tool -change '/sw/lib/gcc4.4/lib/libstdc++.6.dylib' '/usr/lib/libstdc++.6.dylib' scilab-bin
install_name_tool -change '/sw/lib/gcc4.4/lib/libstdc++.6.dylib' '/usr/lib/libstdc++.6.dylib' scilab-cli-bin
```
Then go to Scilab lib directory:
```sh
cd /Applications/scilab-5.4.1.app/Contents/MacOS/lib/scilab
for f in *.dylib ; do install_name_tool -change '/sw/lib/gcc4.4/lib/libstdc++.6.dylib' '/usr/lib/libstdc++.6.dylib' $f ; done
cd /Applications/scilab-5.4.1.app/Contents/MacOS/lib/thirdparty
for f in *.dylib ; do install_name_tool -change '/sw/lib/libiconv.2.dylib' '/usr/lib/libiconv.2.dylib' $f ; done
```

## Comments

```scilab
// a one line comment
```

## Command output

You can silence the output of a command by terminating it with a semi-colon:
```scilab
x=[0:10:1];
```

## File I/O

Open a file:
```scilab
fd = mopen('myfile', 'r');
```

Printing to a file:
```scilab
mfprintf(fd, 'Some text to format %d = %f\n', n, x);
```

Load data file:
```scilab
m = read('myfile', -1, 2);
```

## if

```scilab
if x > 1 then y = 2
elseif x > 0 then y = 1
else y = 0
end
```

## function

Create a function:
```scilab
function [r] = my_sqr(x)
r = x * x
endfunction
// OR
deff("[y]=my_sqr(x)","y=x*x")
```

Plotting a function:
```scilab
x=[0:0.1:10]*%pi/10;
fplot2d(x,f)
clf();
fplot2d(1:10,'parab')
```

## Graphic

Clear graphic figure (window):
```scilab
clf
```

## Operators

Logical operators:
```scilab
x = ~b; // negation
x = a & b; // and
x = a | b; // or
b = and(A); // return %T (true) if all elements of A are true.
```

## Profiling

Measuring cpu time:
```scilab
timer();
my_function();
elapsed = timer();
```

Measuring clock time:
```scilab
tic();
my_function();
elasped = toc();
```

Profling:
```scilab
add_profiling("my_function");
my_function();
profile(my_function)
plotprofile(my_function)
```

## exec

Execute a script:
```scilab
exec('myscript.sci');
```

## Variables

Remove variables:
```scilab
clear
clear <variable_name>
```

## Vector

difference (discrete derivative):
```scilab
diff(v);
```

## Scalar operations

To operate each member of a vector with the corresponding member of another vector, use the dot operators:
```scilab
v1 .* v2
v1 ./ v2
```
