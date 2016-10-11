VIM
===

## Install

```bash
./configure --with-features=big --disable-gui 
```

## Configuration

To reload vimrc:
```vim
source $MYVIMRC
```

To known path of vimrc file:
```vim
echo $MYVIMRC
```

To get home:
```vim
echo $HOME
```

`MYVIMRC` is `$HOME/.vimrc` in UNIX and `$HOME/_vimrc` in Windows.
Be careful that under Windows, *gVim* installs a global `_vimrc` inside its installation directory.

## Modeline

Vim settings inside a file:
```java
// vi: ts=4 et
```

## Tabulation

Tabstop (width of columns for tab mode):
```vim
set tabstop=4
set ts=4
```

Softtabstop (?):
```vim
set softtabstop=2
```

Insert spaces instead of tabs:
```vim
set expandtab
set et
set noet " set to false
```

Converting current buffer to the current tab settings:
```vim
retab
```

In order to see tabulation in editor (this will also display all other hidden characters):
```vim
set list
set nolist
```

You can also use the whitespace highlighting syntax, that prints spaces in red and tabs in green:
```vim
set syntax=whitespace
```

## Gui

Set GUI off (menu, toolbars, ...):
```
:se go=
```

## Display

Command      | Description
------------ | ----------------
`:se nu`     | Turn on line numbering.
`:se nonu`   | Turn off line numbering.
`:se list`   | Turn on display of non-printable characters.
`:se nolist` | Turn off display of non-printable characters.

## Key bindings

 * [Mapping keys in Vim - Tutorial (Part 1)](http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial).

List mappings in normal, visual and select and operator pending mode:
```vim
map
```

List mappings in insert and command-line mode:
```vim
map!
```
	
## Read

To insert from a file, below cursor position:
```vim
read myfile.txt
r myfile.txt
```

To insert before the first line:
```vim
0r myfile.txt
```

To insert below the last line:
```vim
$r myfile.txt
```

To insert output of a command:
```vim
r !mycmd
```

## Help

Command      | Description
------------ | --------------------
`:h[elp]`    | Display help/manual.
`:h pattern` | Display help about "pattern" if available.

Inside help:

Command      | Description
------------ | --------------------
`CTRL+]`     | Follow tag (in yellow). Don't forget to select tag (using visual block CTRL+V and cursor arrows) if it contains dashes (like in map-which-keys).
`CTRL+T`     | Go back to where you where before hitting CTRL+].
`CTRL+O`     | Jump to older location.
`CTRL+I`     | Jump to newer location.

## Editing

Command | Description
------- | ---------------------
`dd`    | Remove current line.
`D`     | Delete current line.
`d$`    | Delete from cursor to end of line.
`d0`    | Delete from start of line to cursor.
`o`     | Open a new line below and insert.
`O`     | Open a new line above and insert.
`i`     | Insert before cursor.
`I`     | Insert to the start of the current line.
`a`     | Append after cursor.
`A`     | Append to the end of the current line.
`C`     | Cut from cursor to end of line and insert.
`r`     | Overwrite one character. After overwriting the single character, go back to command mode.
`R`     | Enter insert mode but replace characters rather than inserting.
`ESC`   | The ESC key Exit insert/overwrite mode and go back to command mode.
`u`     | Undo the last action.
`U`     | Undo all the latest changes that were made to the current line.
`C-r`   | Redo.
`J`     | Join two line.
`rx`    | Replace character with x.
`Rtext` | Replace text beginning at cursor.
`s`     | Substitute character.
`ns`    | Substitute n character.
`S`     | Substitute entire line.
`~`     | Reverse case.
`gU`    | Put in uppercase.
`gu`    | Put in lowercase.

## Navigate

Command     | Description
----------- | ---------------------
`j`         | Down.
`CTRL-j`    | Down.
`CTRL-n`    | Down.
`k`         | Up.
`CTRL-p`    | Up.
`h`         | Left.
`CTRL-h`    | Left.
`Backspace` | Left.
`l`         | Right.
`Spacebar`  | Right.
----------- | ---------------------
`H`         | To the first line of the screen.
`M`         | To the middle line of the screen.
`L`         | To the the last line of the screen.
`nH`        | n lines after top line of current screen.
`nL`        | n lines before last line of current screen.
----------- | ---------------------
`zt`        | Puts current line to top of screen.
`z.`, `zz`  | Puts current line to center of screen.
`zb`        | Puts current line to bottom of screen.
----------- | ---------------------
`Ctrl-f`    | Forward one screen.
`Ctrl-b`    | Backward one screen.
`Ctrl-d`    | Down half a screen.
`Ctrl-u`    | Up half a screen.
`Ctrl-e`    | Display another line at bottom of screen.
`Ctrl-y`    | Display another line at top of screen.
----------- | ---------------------
`w`         | Start of next word.
`W`         | Start of next word, ignoring punctuation.
`b`         | Start of previous/current word.
`B`         | Start of previous/current word, ignoring punctuation.
`e`         | End of next/current word.
`E`         | End of next/current word, ignoring punctuation.
----------- | ---------------------
`0`         | First column in current line.
`|`         | First column in current line.
`n|`        | Column n in current line.
`^`         | First non-blank character in current line.
`$`         | Last character in current line.
`+`         | First non-blank character in next line.
`Return`    | First non-blank character in next line.
`-`         | First non-blank character in previous line.
----------- | ---------------------
`1G`        | First line in file.
`G`         | Last line in file.
`G$`        | Last character in file.
`nG`        | Line n in file.
`:n`        | Line n in file.
----------- | ---------------------
`(`         | Beginning of current sentence.
`)`         | Beginning of next sentence.
`{`         | Beginning of current paragraph.
`}`         | Beginning of next paragraph.
`[[`        | Beginning of current section.
`]]`        | Beginning of next section.

## Windows

Command                 | Description
----------------------- | ---------------------
`:split`                | Split horizontally.
`:sp`                   | Split horizontally.
`:sp myfile`            | Open file into a new window split, horizontally.
`Ctrl-ws`               | Split horizontally.
`:vsplit`               | Split vertically.
`Ctrl-wv`               | Split vertically.
----------------------- | ---------------------
`Ctrl-w Ctrl-w`         | Circle through windows.
`Ctrl-w <arrow-key>`    | Jump to neighbour window.
----------------------- | ---------------------
`[number] Ctrl-w +`     | Resize window vertically.
`[number] Ctrl-w -`     | Resize window vertically.
`[number] Ctrl-w <`     | Resize window horizontally.
`[number] Ctrl-w >`     | Resize window horizontally.
`Ctrl-w =`	            | Make all windows the same size.
----------------------- | ---------------------
`Ctrl-w K`              | Move current window to the very top.
`Ctrl-w J`              | Move current window to the very bottom.
`Ctrl-w H`              | Move current window to the far left.
`Ctrl-w L`              | Move current window to the far right.
----------------------- | ---------------------
`:q`                    | Close current screen.
`Ctrl-w c`              | Close current window.
`Ctrl-w q`              | Close current screen.
`Ctrl-w o`              | Close all windows except current one.
`:qall`                 | Quit all windows (prompt for saving).
`:wall`                 | Save all buffers of windows.
`:wqall`                | Save & quit all windows.
`:qall!`                | Quit all windows without prompting for saving.

## Tabs

Command                 | Description
----------------------- | ---------------------
`:tabnew`               | Create a new tab.
`:tabedit {file}`       | Edit specified file in a new tab.
`:tabfind {file}`       | Open a new tab with filename given, searching the 'path' to find it.
`:tabclose`             | Close current tab.
`:tabclose {i}`         | Close i-th tab.
`:tabonly`              | Close all other tabs (show only the current tab).
`:tab split`            | Copy the current window to a new tab of its own.
`Ctrl-w T`              | Move current window to a new tab page.
----------------------- | ---------------------
`:tabs`                 | List all tabs including their displayed windows.
`:tabm 0`               | Move current tab to first.
`:tabm 2`               | Move current tab to position 3.
`:tabm`                 | Move current tab to last.
`:tabn`                 | Go to next tab.
`:tabp`                 | Go to previous tab.
`:tabfirst`             | Go to first tab.
`:tablast`              | Go to last tab.
`gt`                    | Go to next tab.
`gT`                    | Go to previous tab.
`2gt`                   | Go to tab in position 2. First tab is number 1.

The [Taboo](https://github.com/gcmt/taboo.vim) plugin allow renaming of tabs:

Command                  | Description
------------------------ | ----------------------------------------
`:TabooRename mynewname` | Rename the current tab.
`:TabooOpen mynewname`   | Open a new tab with the specified name.
`:TabooReset`            | Remove the custom name of the current tab.

## Wrap

Enable wraping:
```vim
set wrap
```

Disable wraping:
```vim
set nowrap
```

Textwrap:
```vim
set textwrap=79
set tw=40
```

Unset textwrap:
```vim
set tw=0
```

## Folding

 * [Folding](http://vim.wikia.com/wiki/Folding).
 * [How to fold](http://vimcasts.org/episodes/how-to-fold/).
 * [Writing a custom fold expression](http://vimcasts.org/episodes/writing-a-custom-fold-expression/).
 * [Markdown folding](https://github.com/nelstrom/vim-markdown-folding).

```vim
setlocal foldmethod=syntax
```

Marker folding (use `{{{X` marking):
```java
// vi: fdm=marker
class Blabla { // {{{1
}

class Zoup { // {{{1
}
```

## Argdo

See also tabdo, windo and bufdo.

Argument list management.

The argument list is the list of files and directories given on vim command line: `vim myfile1.txt otherfile.txt myfile2.cpp`.

### Basic commands

---------------- | ----------------------------------------------------------------------
`args`           | Print argument list.
`args *.txt`     | Replace argument list with all the .txt files in current directory.
`args **/*.txt`  | Replace argument list with all the .txt files in current directory and all subfolders.
`argadd *.cpp`   | Add all .cpp files in current directory.
---------------- | ----------------------------------------------------------------------

Note that, in order to speed up loading, syntax highlighting is set to off by argadd.

### Executing command

`argdo` runs a command on all files of the argument list (the list of files specified at command line when running vim command).

Replace a string in all files in argument list:
```vim
argdo %s/MY\.CONSTANT/NEW.NAME/ge | update
```
The 'e' option will disable error messages.
The `update` writes files that have been modified.

## Modeline (embedded commands)

Set your commands inside a comment line, after a tag, and end with a colon (:) in case of a closing comment token like in C.

First set the following options:
```vim
set modeline
set modelines=5
```

Examples in C:
```c
/* vim: ft=C
 */
/* vi: ft=C
 */
/* vi: set ft=C: */
/* vi: set ft=C noai ts=4: */
```

Set filetype:
```cpp
// vi: set ft=C++
```

## Search & replace

Command           | Description
----------------- | --------------------------------------
`*`               | Search for current word (the one under the cursor).
`/`               | Search pattern forward.
`?`               | Search pattern backward.
`n`               | Scan for next search match in the same direction.
`N`               | Scan for next search match but opposite direction.
`/\<in\>/`        | Search for whole words.
`/\t`             | Search for tabulations.
`/\cmyword`       | Case insensitive search of 'myword'.
`/\Cmyword`       | Case sensitive search of 'myword'.
`:se incsearch`   | Turn on incremental search (like in emacs).
`:se is`          | Turn on incremental search.
`:se nois`        | Turn off incremental search.
`:se nohlsearch`  | Turn off search highlighting.
`:nohlsearch`     | Turn off search highlighting.
`:nohl`           | Turn off search highlighting.
`:set ignorecase` | Ignore case while searching.
`:set ic`         | Ignore case while searching.
`:set noic`       | Do not ignore case while searching.
`f mychar`        | Find a character forward.
`F mychar`        | Find a character backward.

Search for character with its hexadecimal code: `/\%x95`.

```
:g/<str>/<cmd>         Run <cmd> on all lines that contain <str>
:g/<str1>/s/<str2>/<str3>/   Find line containing <str1>, replace <str2> with <str3>
:v/<str>/<cmd>         Execute <cmd> on all lines that do not match <str>  
```

Replace by uppercase or lowercase:
```vim
%s/Some text \([a-z0-9]*\)/\U\1/g           " Put in uppercase the backreference.
%s/Some text \([a-z0-9]*\)/\U\1 blabla/g    " Put in uppercase the backreference and the text after.
%s/Some text \([a-z0-9]*\)/\U\1\E blabla/g  " Put in uppercase the backreference, but not the text after (stop at `\E`).
%s/Some text \([a-z0-9]*\)/\L\1/g           " Put in lowercase the backreference.
%s/Some text \([a-z0-9]*\)/\u\1/g           " Put in uppercase the first letter of the backreference.
%s/Some text \([a-z0-9]*\)/\l\1/g           " Put in lowercase the first letter of the backreference.
```

Confirm before replacing:
```vim
%s/blabla/zop/gc
```

### Deleting

Command           | Description
----------------- | --------------------------------------
`:.,$d`           | Delete from current line to end of file.
`:.,/Edison/d`    | Delete from current line to first line containing the string Edison.
`:g/^$/d`         | Delete empty lines.

### Replacing

Substituting `foo` with `bar`, `r` determines the range and `a` determines the arguments:
```
rs/foo/bar/a	
```

The range `r` can be:

------------- | -----------------------------------------
nothing       | Work on current line only.
a number      | Work on the line whose number you give.
%             | The whole file.

Arguments `a` can be:
-- | -----------
g  | Replace all occurrences in the line. Without this, Vim replaces only the first occurrences in each line.
i  | Ignore case for the search pattern.
I  | Don't ignore case.
c  | Confirm each substitution. You can type y to substitute this match, n to skip this match, a to substitute this and all the remaining matches ("Yes to all"), and q to quit substitution.

Example           | Description
----------------- | ------------------------------
`:s/OLD/NEW`      | First occurrence on current line.
`:s/OLD/NEW/g`    | Globally (all) on current line.
`:#,#s/OLD/NEW/g` | Between two lines #,#.
`:n,$s/OLD/NEW/g` | From line n to end of file.
`:.,$s/OLD/NEW/g` | From current line to end of file.
`:%s/OLD/NEW/g`   | Every occurrence in file.

To insert a new line character when replacing, type either `C-v C-m` or `C-v ENTER`.

While grouping, the character `&` replaces the whole match.

For replacing while respecting the case, load library file `keepcase.vim`, and then: `:%SubstituteCase/\cbadjob/GoodJob/g`.

For replacing in multiple files, see [ARGDO]().

## Bookmark

Command      | Description
------------ | ---------------
`:m<letter>` | Set bookmark.
`'<letter>`  | Go to bookmark.
`''`         | Go to previous position.

## Buffers & files

Command               | Description
--------------------- | ---------------
`:e myfile`           | Open file.
`:e#`                 | Previous file.
`:e!`                 | Revert file.
`:e .`                | Open current directory in navigator.
`:E`                  | Open directory of current file in navigator.
`:ls`                 | List open files.
`:buffers`            | List open files.
`:b#`                 | Switch to alternate buffer.
`:bn`                 | Switch to buffer n.
`:b <name>`           | Switch to buffer <name> (use TAB to list all possible buffers).
`:bn`                 | Switch to next buffer.
`:bp`                 | Switch to previous buffer.
`:n`                  | Edit next file.
`:n!`                 | Edit next file (ignoring warnings).
`:n files`            | Specify new list of files.
`:n .`                | Open current directory in navigator.
`:r file`             | Insert file after cursor.
`:r !command`         | Run command, and insert output after current line.
`:bd <buffer_number>` | Delete buffer.
`:bd myfile`          | Delete buffer.
`:w`                  | Write current buffer on disk.
`:w new_file_name`    | Write current buffer to new file.
`:w!`                 | Write file (ignoring warnings).
`:w! file`            | Overwrite file (ignoring warnings).
`:n1,n2w file`        | Write lines n1 to n2 to file.
`:n1,n2w >> file`     | Append lines n1 to n2 to file.

## Quit

Command      | Description
------------ | ---------------
`:q`         | Quit and prompt for unsaved files.
`:q!`        | Quit without prompting for unsaved files.
`:wq`        | Write the file and quit vi.
`:x`         | write the file if changes have been made and quit vi.
`ZZ`         | Quit, only writing file if changed.

## Indentation

Autoindent: indent the new line like the current line.
```
:set autoindent
:set ai
```

C indent: indent automatically open and close braces, and autoindent new line.
```
:set cindent
```

Command      | Description
------------ | ---------------
`5>>`        | Indent 5 lines.
`>%`         | Indent curly-braces block (set cursor on one of the curly-braces).
`]p`         | Paste and indent pasted text with the surrounding text.

Shiftwidth (width used when shifting lines with > or <):
```
:set sw=4
```

## Commands

Commands are run in command-line mode, which is entered using the `:` character.

Defining a new command:
```
command MyCommand the_command_to_run
```
User-defined commands must start with an uppercase letter.

List user-defined command:
```
command
```

Force redifining a command:
```
command!
```

Arguments:
```
command -nargs=0 MyCommand ...
command -nargs=1 MyCommand the_command <args>
command -nargs=* MyCommand the_command <args>
```
Possible `nargs` values:

Value | Description
----- | -----------------
`0`   |  No arguments.
`1`   |  One argument.
`*`   |  Any number of arguments.
`?`   |  Zero or one argument.
`+`   |  One or more arguments.

## Compiling

Command                          | Description
-------------------------------- | ---------------------
`:make`                          | Run make command.
`:set makeprg=gmake`             | Set make command.
`:set makeprg=gmake\ \CC=gcc296` | Set some parameters to make.
`:cn`                            | Next error.
`:cfirst`                        | First error.
`:clast`                         | Last error.
`:clist`                         | List errors.

## Copy & paste

 * [How to paste yanked text into Vim command line?](http://stackoverflow.com/questions/3997078/how-to-paste-yanked-text-into-vim-command-line).

Command     | Description
----------- | -------------------
`Y`         | Copy current line.
`yy`        | Copy current line.
`2Y`        | Copy current line and next one.
`10Y`       | Copy 10 lines, starting from current one.
`yG`        | Copy all lines from current line to the end of the file.
`P`         | Paste above current line or before cursor.
`p`         | Paste below current line or after cursor.
`yw`        | Copy from current position to beginning of next word.
`yW`        | Copy from current position to beginning of next word (including punctuations).
`ye`        | Copy from current position to end of current word.
`yE`        | Copy from current position to end of current word (including punctuations).
`y$`        | Copy from current position to end of the line.
`C-R "`     | Paste in command mode.
`C-R C-O "` | Paste in command mode. Handles control characters, if there are, inside the default register.

### Registers

Command      | Description
------------ | -----------------------------------------------
`"k`         | Set/access (depending on the following command) register k (any letter can be used). Example: `"kyy`, `"kp`.
`"K`         | Append to register k.
`:reg`       | Get list of all actual registers.

Registers:

Register | Description
-------- | --------------------------------------------
`0`      | Yank register. The one used when pressing `y`.
`1`..`9` | Shifting delete registers. Used when pressing `c` or `d`.
`"`      | Default register.
`a`..`z` | User registers.
`+`, `*` | System clipboard registers.

## Debugging

For debugging with gdb or pdb under vim, install <http://pyclewn.sourceforge.net/index.html>.

From within vim, start Pyclewn with `:Pyclewn`.

Then use any vim debugger command, like `:Cfile my_executable`.

Any command of the debugger can be entered this way (note the space betwee :C and the command):
```
:C mycommand ...
```

Terminate Pyclewn (and vim betbeans interface):
```
:nbclose
```

## Encoding

Command                     | Description
--------------------------- | -----------------------------------------------
`:set fileencoding`         | Get encoding of the current buffer.
`:set fenc`                 | Get encoding of the current buffer.
`vim "+set encoding=utf-8"` | Start vi with utf-8 enabled.
`:set enc=utf-8`            | Set current buffer in utf-8.
`:set tenc=latin-1`         | Set terminal encoding (when editing utf-8 but terminal is in another encoding).

## Spell checking

Enabling and disabling spell checking:
```
:set spell
:set nospell
```

Set lang for all buffers:
```
:set spelllang=fr
:set spl=en
```

Set lang for selected buffer only:
```
:setlocal spelllang=en_us
```

Command | Description
------- | --------------------------------------------------------------------------------------------------
`]s`    | Move to next misspelled word.
`[s`    | Move backward.
`]S`    | Like ]s but only stop at bad words, not at rare words or words for another region.
`[S`    | Move backward.
`zg`    | Add word as good word to spell file (the word under cursor, or the selected word in visual mode).
`zG`    | Add word as goot word into internal word list.
`zw`    | Add word as bad word to spell file.
`zW`    | Add word as bad word into internal word list.
`zuw`   | Remove word from list.
`zug`   | Remove word from list.
`zuW`   | Remove word from list.
`zuG`   | Remove word from list.
`z=`    | Make suggestions for bad word.

Repeat the replacement done by |z=| for all matches	with the replaced word in the current window:
```
:spellr[epall]	
```


## Insert mode

Command     | Description
----------- | --------------------------------------------
`CTRL-R "`  | Insert the content of the unnamed register.
`CTRL-R +`  | Insert the content of the clipboard. 

## Visual mode

### Basic commands

Command     | Description
----------- | --------------------------------------------
`v`         | Enter/exit visual mode.
`c`         | Cut text and enter insertion mode.
`a"`        | Select text delimited by quotes.
`a)`        | Select text delimited by parenthesis.
`a(`        | Idem.
`a]`        | Select text delimited by brackets.
`a[`        | Idem.
`c""<Esc>P` | Surround text by quotes.

## Surrounding text

 * [vim-surround](https://github.com/tpope/vim-surround).

Command     | Description
----------- | --------------------------------------------
`ysiw]`     | Surround word under cursor with square brakets.
`ds"`       | Deletes surrounding quotes.

## Syntax highlighting

 * [Create your own syntax files](http://vim.wikia.com/wiki/Creating_your_own_syntax_files).

To turn syntax highlighting on and off:
```vim
syntax on
syntax off
```

For colors, see <http://vimdoc.sourceforge.net/htmldoc/usr_06.html>.

Set filetype (determines rules to apply for syntax highlighting):
```vim
setf <language>
setf java
setf c
set filetype=html
```

Rules on file creation or opening :
```vim
au BufRead,BufNewFile *.html,*.htm set filetype=php
au BufRead,BufNewFile ~/project_y/*.html set filetype=php
```

Colorscheme:
```vim
colorscheme         " display current colorscheme name
colorscheme morning
color morning
color default       " default colorscheme
```

Installing user color schemes:
```bash
mkdir -p $HOME/.vim/colors
cp mycolorscheme.vim $HOME/.vim/colors
```

Embedded syntax highlighting (syntax highlighting of code embedded inside another language code):
```bash
runtime! syntax/xml.vim
unlet b:current_syntax
syntax include @Python syntax/python.vim
syntax region pythonCode  start=+<Python>+ keepend end=+</Python>+  contains=@Python
```

## Vimscript

### Running vim commands

One can run vim command directly inside a vimscript:
```vim
mkspell ~/.vim/spell/en.utf-8.add
```

However if you must use a variable this isn't possible, because in a vim command variables are not interpreted. You must use the `exec` vimscript command:
```vim
exec "mkspell " . myfile
```

### For

```vim
for i in [1 2 5 70]
endfor
```

### Strings

To concatenate strings:
```vim
let myvar = "somestring" . somevar . "some other string"
```

### File system

Testing if a file exists:
```vim
if filereadable(myfile)
endif
```

Getting the modification time of a file:
```vim
let modiftime = getftime(myfile)
```

To get a correct path to a file/dir using `~`, use the `expand` keyword:
```vim
let wordsfile = expand("~/.vim/spell/en.utf-8.add")
```

### Variables & co

See <http://learnvimscriptthehardway.stevelosh.com/chapters/19.html#options-as-variables>.

Append to a list or string:
```vim
set myopt+=myval
```
	
Insert at beginning of list or string:
```vim
set myopt^=myval
```

### Options

Options can be set either with set or let:
```vim
set myopt = 10
let &myopt = 10
```
The advantage of using `let`, is that you can make computation:
```vim
let &myopt = someothervar + 10 + z
```

Setting a boolean option:
```vim
set cindent
```

Unsetting a boolean option (prefix with 'no'):
```vim
set nocindent
```

Testing an option in .vim script:
```vim
if &filetype == 'java'
```

Many options have a shortcut, like filetype:
```vim
set ft=C
```

For printing an option:
```vim
set myopt
echo &myopt
```

For printing a variable:
```vim
echo myvar
```

## Printing
	
Printing from vi:
```vim
hardcopy
ha
```
Can be applied to a range of lines.
	
Printing in landscape mode:
```vim
se popt=portrait:n
```
	
Printing from command line:
```bash
vim -c hardcopy -c quit <myfile>
```
	
Output to a postscript file, with syntax highlighting:
```bash
vim -c 'hardcopy >myfile.ps' -c quit <myfile>
```
	
Turn off header on printer output:
```bash
vim -c 'set popt+=header:0' ...
```
	
Set font size:
```bash
vim -c 'set pfn=:h16' ...
```

## Shell command

Running a shell command:
```vim
:!mycommand
```

## Sort text

Sort all:
```vim
:%sort
```

Reverse sort:
```vim
sort!
```

Uniq:
```vim
sort -u
```

Ignore case:
```vim
sort -f
```

Use external sort:
```vim
exe  "%!LC_ALL=fr_FR." . &fileencoding . " sort"
```

## Statusline
	
```vim
set laststatus=2
set statusline=%n:%<%F%Y%R%=%l(%P)
```

Flag | Description
---- | ----------------
`%l` | Line number.
`%c` | Column number.

## Grep

### Internal vim grep command

```vim
vim /print(/ ~/dev/mydir/*
```

### External grep

```vim
gr mypattern myfiles
grep mypattern myfiles
```

Add results to the current results:
```vim
grepadd ...
```

Recursive grep
```vim
rgrep ...
```

Buffer grep
```vim
bgrep
```

```vim
fgrep
rfgrep
egrep
regrep
agrep
ragrep
```

## Error format

To add a new error format:
```vim
set errorformat+=%*[\"]%f%*[\"]\\,\ line\ %l:\ %m
```
For a literal %, type %%.

To insert a new error format at beginning of list:
```vim
set errorformat^=someformat
```

## Netrw

Netrw is the file navigation system of vim.

Entering netrw:
```
:e localdir
:e remotedir
:E
```

Command | Description
------- | -------------------
`d`     | Make a directory.
`%`     | Create/open new file.

## File system

In commands, `%` is replaced by the current filename.
`%:p` by the full path of the current file.
`%:p:h` by the full directory path of the current file.
`%:h` by the directory of the current file.

Getting current directory:
```vim
pwd
```

Go to home directory:
```vim
cd
```

Change to directory of current file:
```vim
cd %:p:h	
```

Change the current directory for the current window only:
```vim
lcd
```

To make the current dir always the same as the file currently edited:
```vim
set autochdir
```

Create a directory:
```vim
call mkdir("mynewdir")
```

## Go to file/url

KEYS        | DESCRIPTION
----------- | -----------
`gx`        | Open link in browser.
`gf`        | Open the file whose name under the cursor.
`Ctrl-W f`  | Open file under cursor into a new window (horizontal split).
`Ctrl-W gf` | Open file under cursor into a new tab.

The file is searched inside the vim path. To see its actual value run `:echo &path`.
The path is a comma separated list of directories.
Special meaning inside the path:
`.` The directory containing the current file.
`/usr/share/doc;` First search in `/usr/share/doc`, then `/usr/share/`, then `/usr/`, then `/`.
`/home/kate/*` Search all of `/home/kate` and its subfolders, recursively.

## Packages

### Pathogen

Pathogen is a package for easying package installation.

 * [Pathogen](http://www.vim.org/scripts/script.php?script_id=2332).
 * [The Modern Vim Config with Pathogen](http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen/).

With Pathogen, packages are now installed inside ~/.vim/bundle folder in a dedicated folders, and are automatically configured.

### Syntax highlightling packages

 * [Tmux conf file](https://github.com/tmux-plugins/vim-tmux).


## Quickfix window

Command         | Description
--------------- | -------------------------------------------
`copen`         | Open the Quickfix window
`cclose`        | Close the Quickfix window
`cn`, `cnext`   | Jump to next match
`cp`, `cprev`   | Jump to previous match
`colder`        | Navigate between multiple Quickfix windows
`cnewer`        |
 
## Select mode

Command     | Description
----------- | --------------------------------
`Shift-V`	| To select lines of text - enter visual mode.
`Ctrl-V` 	| To select a block of text - enter visual mode.
`<ESC>`     | Exit visual mode and return to command mode.
`y`         | Copy selection.
`d`         | Delete selection.
`c`         | Edit selection (delete and insert).
`>`         | Indent selection.
`<`         | Unindent selection.

