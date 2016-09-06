CHEETAH
=======

Cheetah is a template engine, written in Python, and used for code generation.

 * <http://www.cheetahtemplate.org>.
 * [Cheetah, the Python-Powered Template Engine](http://pythonhosted.org/Cheetah/).
 * [Python-Powered Templates with Cheetah](http://www.onlamp.com/pub/a/python/2005/01/13/cheetah.html).
 * [Cheetah packages](https://pypi.python.org/pypi/Cheetah).

## Statements

### If else

Test if a variable is defined (not "" or None or 0):
```cheetah
#if $myvar:
	do something with $myvar
#end if
```
