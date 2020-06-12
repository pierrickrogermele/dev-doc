<!-- vimvars: b:markdown_embedded_syntax={'vim':''} -->
# Vim

 * [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/).

## Configuration

To reload vimrc:
```vim
source $MYVIMRC
```

To know path of vimrc file:
```vim
echo $MYVIMRC
```

To get home:
```vim
echo $HOME
```

`MYVIMRC` is `$HOME/.vimrc` in UNIX and `$HOME/_vimrc` in Windows.
Be careful that under Windows, *gVim* installs a global `_vimrc` inside its installation directory.

To get information about vim files:
```vim
help runtimepath
```

Standard configuration/plugin folders:
	~/.vim/colors/
	~/.vim/plugin/
	~/.vim/ftdetect/
	~/.vim/ftplugin/
	~/.vim/syntax/
	~/.vim/indent/
	~/.vim/compiler/
	~/.vim/after/
	~/.vim/autoload/
	~/.vim/doc/

### colors folder

Color scheme files.
Command `color mycolors` will search for `mycolors.vim` file inside `colors` folders.

### plugin folder

Files in this directory will be loaded once at startup.

### ftdetect folder

Files in this directory will be loaded once at startup.
Should contain autocommands that detect and set the filetype of files.

For instance, for Potion language (`*.pn` files), we create the file `ftdetect/potion.vim`:
```vim
au BufNewFile,BufRead *.pn set filetype=potion
```

### ftplugin folder

When Vim sets a buffer's filetype if looks for `<filetype>.vim` and `<filetype>/*.vim` files inside this folder.
Code in theses files must only set buffer-local options since it is called each time a buffer's filetype is set.

To force reloading filetype plugins, just reset filetype inside buffer:
```vim
set filetype=potion
```

### syntax folder

Contains syntax highlighting files.
See `help syntax`.

For instance for Potion language, we create the file `syntax/potion.vim`:
```vim
if exists("b:current_syntax")
	finish
endif

" Define keyword groups
syntax keyword potionKeyword loop times to while
syntax keyword potionKeyword if elsif else
syntax keyword potionKeyword class return

syntax keyword potionFunction print join string

" Link keyword groups to highlighting groups.
highlight link potionKeyword Keyword
highlight link potionFunction Function

let b:current_syntax = "potion"
```

See `help syn-keyword`.
`iskeyword` option defines which characters are allowed for a keyword. Thus only these characters are recognized by Vim.
For common highlighting groups see `help group-name`.

To define syntax highlighting for operators and keywords that contain characters not in `iskeyword`, we must use a regex. Example for Potion comments that start with `#`:
```vim
syntax match potionComment "#.*$"
highlight link potionComment Comment
```

Defining syntax highlighting for operators:
```vim
syntax match potionOperator "\v/"
syntax match potionOperator "\v\+"
syntax match potionOperator "\v-"
syntax match potionOperator "\v\?"
syntax match potionOperator "\v\*\="
syntax match potionOperator "\v/\="
syntax match potionOperator "\v\+\="
syntax match potionOperator "\v-\="
syntax match potionOperator "\v\="
highlight link potionOperator Operator
```
See `help syn-match` and `help syn-priority`.

Use `syntax region` to highlight strings:
```vim
syntax region potionString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link potionString String
```
See `help syn-region`.

### indent folder

Same as ftplugin, but code in this folder is only related to indentation.

### compiler folder

Same as ftplugin but for compiler-related options.

### after folder

Subdirectories are allowed:
 * Files in `after/syntax` will be loaded after files in `syntax`.
 * Files in `after/plugin` will be loaded after files in `plugin`.
 * Files in `after/ftplugin` will be loaded after files in `ftplugin`.

### autoload folder

Autoload is a way to delay the loading of your plugin's code until it's actually needed.

If a function like the following one is called:
```vim
call somefile#Hello()
```
and this function is unknown, Vim will look for the function inside `autoload/somefile.vim`.

Inside file `autoload/somefile.vim`, the function must look like this:
```vim
function somefile#Hello()
	" ...
endfunction
```

If the function is already known, Vim will not look for it. Hence if you need to reload your script file, call an unknown function from this file like `call somefile#BadFct()` and Vim will force reload of `autoload/somefile.vim`.

Subdirectories are allowed by the use of multiple `#` characters:
```vim
call myplugin#somefile#Hello()
```
Then in the file `autoload/myplugin/somefile.vim`:
```vim
function myplugin#somefile#Hello()
	" ...
endfunction
```

### doc folder

Documentation files are simply files with file type `help`.

Create a file `doc/potion.txt` for Potion language:
```help
*potion.txt* functionality for the potion programming language

                   ___      _   _              ~
                  / _ \___ | |_(_) ___  _ __   ~
                 / /_)/ _ \| __| |/ _ \| '_ \  ~
                / ___/ (_) | |_| | (_) | | | | ~
                \/    \___/ \__|_|\___/|_| |_| ~

       Functionality for the Potion programming language.
     Includes syntax highlighting, code folding, and more!

====================================================================
CONTENTS                                            *PotionContents*

    1. Usage ................ |PotionUsage|
    2. Mappings ............. |PotionMappings|
    3. License .............. |PotionLicense|
    4. Bugs ................. |PotionBugs|
    5. Contributing ......... |PotionContributing|
    6. Changelog ............ |PotionChangelog|
    7. Credits .............. |PotionCredits|

====================================================================
Section 1: Usage                                       *PotionUsage*

This plugin with automatically provide syntax highlighting for
Potion files (files ending in .pn).

It also...

```
Set its file type to `help` (`se ft=help`) to get syntax highlighting.
The `~` characters at the end of the ASCII art prevent Vim from highlighting the lines.
The `*sometag*` marks place tags inside the document. They can be called with help (e.g.: `help sometag`).
The `|sometag|` marks create links to tags. User can press `<c-]>` on it to jump to the corresponding tag.

## Options

Name        | Description
----------- | ----------------
number      | Line numbering.
list        | Display non-printable characters.
wrap        | 
textwidth   |
ignorecase  | Ignore case when comparing strings with `==` operator.
foldcolumn  | Integer. If 0, then disabled. Otherwise display a column of foldings (width=number).
runtimepath | Where to look for standard folders (`colors`, `syntax`, `ftplugin`, ...).
iskeyword   | Define the list of allowed characters for keywords.
........... | Used in syntax highlighting.
autowrite   | Enable buffer writing before running external commands (`!`) or `make`, ...

Local options:
Name        | Description
----------- | ------------------------------
buftype     | The type of buffer. (e.g.: `"nofile"` for a scratch buffer)
filetype    | The type of file (e.g.: `"c", "java", ...`).

## map & co

 * [Mapping keys in Vim - Tutorial (Part 1)](http://vim.wikia.com/wiki/Mapping_keys_in_Vim_-_Tutorial).

Map key `-` to key sequence `dd` in normal and visual modes:
```vim
map - dd
```
Do not put a comment after a map, it will be integrated in the mapping value.
```vim
map - dd " Some comment that will be mapped to the `-` key too.
```

Map space key:
```vim
map <space> dd
```

Map Ctrl+d:
```vim
map <c-d> dd
```

Map only in normal mode:
```vim
nmap \ dd
```

Map only in visual mode:
```vim
vmap \ U
```

Map only in insert mode for deleting current line:
```vim
imap <c-d> <esc>ddi
```

Remove a normal mode mapping:
```vim
nunmap -
```

Be careful about recursive mapping like:
```vim
nmap dd O<esc>jddk
```
To avoid recursion use the `*noremap` commands:
```vim
noremap \ dd
nnoremap \ dd
vnoremap \ dd
inoremap dd O<esc>jddk
```

Mapping a sequence of keys:
```vim
nnoremap -d dd
```

Define key mapping inside current buffer only:
```vim
nnoremap <buffer> <leader>x dd
```
The correct way is however to use the local leader:
```vim
nnoremap <buffer> <localleader>x dd
```

Define a leader:
```vim
let mapleader = "-"
```

Use leader for key sequence:
```vim
nnoremap <leader>d dd
```

Define local leader as `\` (for specific file types):
```vim
let maplocalleader = "\\"
```
Use `<localleader>` in mappings that are `<buffer>` specific.

Key mapping for quoting current word:
```vim
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
```

Key mapping for searching for word under cursor:
```vim
nnoremap <leader>g :grep -R '<cword>' .<cr>
```
For searching for WORD (even if it contains quote characters)):
```vim
nnoremap <leader>g :execute "grep -R " . shellescape(expand("<cWORD>")) . " ."<cr>
```
Do not jump to first match, but open the quickfix window automatically:
```vim
nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>
```
`grep` being a shell command the string passed to it must be escaped (hence the call to `shellescape()`).
The word under the cursor must be retrieved using the `expand()` method so it can be embedded inside the command to execute.

List mappings in normal, visual and select and operator pending mode:
```vim
map
```

List mappings in insert and command-line mode:
```vim
map!
```

To know what commands where assigned to a key:
```vim
:verbose map <leader>c
```

The `Leader` key is mapped to "\" by default. To redefine it, set `mapleader` variable.

### operator-pending mappings

Define an new operator movement for selecting all content between current parenthesis:
```vim
onoremap p i(
```

Remove everything inside next parenthesis and goes into insert mode (use `cin(`):
```vim
onoremap in( :<c-u>normal! f(vi(<cr>
```
Same thing with previous parenthesis (`cil(`):
```vim
onoremap il( :<c-u>normal! F)vi(<cr>
```

Remove markdown title of current section and goes into insert to change title (`cih`):
```vim
onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
```
The `g_` is to go to the last non-blank character of the line.

Creating a new operator (`<leader>g`) to grep for word under cursor:
```vim
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
	let saved_unnamed_register = @@

	if a:type ==# 'v'
		execute "normal! `<v`>y"
	elseif a:type ==# 'char'
		execute "normal! `[v`]y"
	else
		return
	endif

	silent execute "grep! -R " . shellescape(@@) . " ."
	copen

	let @@ = saved_unnamed_register
endfunction
```
`g@` calls the function as an operator, thus we ca type `<leader>giw` to call the function for the word under the cursor.
`<c-u>` deletes the `'<,'>` automatically inserted by Vim when text is selected and `:` is pressed. This is because we are going to call a function of our own and pass it the type of selection made (`visualmode()`).
`visualmode()` returns `"v"` for characterwise, `"V"` for linewise, and a `Ctrl-v` character for blockwise.
`a:type` has the following values:
 * `"v"` when we press `viw<leader>g`.
 * `"V"` when we press `Vjj<leader>g`.
 * `"char"` when we press `<leader>giw`.
 * `"line"` when we press `<leader>gG`.
`@@` is the unnamed regsiter, the one used by default when deleting and yanking.
`s:` declares the function inside the current script namespace.
`<SID>` looks for a function inside the current script namespace and not the global namespace (default).

## Abbreviations

Replace keys sequence by another. The end of a sequence is marked by a non-keyword character.
To see the list of non-keyword characters:
```vim
set iskeyword?
```

Define an abbreviation in insert mode for correcting mistyping:
```vim
iabbrev adn and
```

Create an abbreviation for the current buffer only:
```vim
iabbrev <buffer> --- &mdash;
```

## autocmd

Save all new text buffers:
```vim
autocmd BufNewFile *.txt :write
```

Re-indent HTML files when saving or loading:
```vim
autocmd BufWritePre,BufRead *.html :normal gg=G
```

Add comment out shortcut for Javascript and Python:
```vim
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
```

Get list of all autocmd events available:
```vim
help autocmd-events
```

Clear all autocommands:
```vim
autocmd!
```

Define an abbreviation to insert `if` statement more easily in Python and Javascript:
```vim
autocmd FileType python     :iabbrev <buffer> iff if:<left>
autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
```

Redefining the same autocommand will define it twice. To avoid that, use a group:
```vim
augroup filetype_python
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
augroup END
```
Using a group and the `autocmd!` to clear all groups definition inside a vimrc
file will avoid redefining multiple times the same autocommands when sourcing
again `.vimrc`.

## augroup

Groups autocommands together.

```vim
augroup filetype_python
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
augroup END
```

## executable

Test if a shell command exists:
```vim
if executable("my-command")
	dosomething()
endif
```

## execute

Execute a Vimscript in a string.

Write current buffer:
```vim
execute "write"
```

Open new window on the right and edit previous buffer in it:
```vim
execute "rightbelow vsplit " . bufname("#")
```

If you want to use variables or special characters (like `<cr>`) inside a command, you must use a vimscript as a string and run it with the `execute` command:
```vim
execute "mkspell " . myfile
```

## normal

Execute command in normal mode.

Go to start of file:
```vim
normal gg
```
However the `normal` command takes remapping of keys into account.
To avoid that, use the `normal!` command:
```vim
normal! gg
```
If `g` or `gg` was remapped, it will be ignored in this case.

`normal` does not recognize special characters like `<cr>`.
A workaround is to use `execute`:
```vim
execute "normal! gg/a\<cr>"
```

Puts a semicolon at the end of the line:
```vim
execute "normal! mqA;\<esc>`q"
```

## help

Get help on a command or option.

```vim
help helpgrep
```

## helpgrep

Search the help using regular expressions.

```vim
helpgrep .*indent
```
Use `copen` to open window with the full list of results.

## Modeline

A modeline is a line at top of file used to set vim options.

In Java or C++:
```java
// vi: se ts=4 et
```

In C:
```c
/* vi: se fdm=marker: */
```

## Normal mode

Key    | Effect
------ | --------------------
K      | Open manpage corresponding to word under cursor.
Ctrl-x | Decrement number under cursor.
Ctrl-a | Increment number under cursor.

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

## Diff

On command line:
```bash
vimdiff file1 file2 [file3] ...
```

From inside vim, to open a diff between current file and another file:
```vim
diffsplit my_other_file
```
To do the same in a vertical split:
```vim
vert diffsplit my_other_file
```

Re-run diff after a manual modification:
```vim
diffupdate
```

To import diff in current file, press `do` or:
```vim
diffget
```

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
`f(`        | Move forward to next parenthesis.
`F(`        | Move backward to previous parenthesis.
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
%           | Jump to matching opening/closing bracket.
`(`         | Beginning of current sentence.
`)`         | Beginning of next sentence.
`{`         | Beginning of current paragraph.
`}`         | Beginning of next paragraph.
`[[`        | Beginning of current section.
`]]`        | Beginning of next section.
----------- | ---------------------

Using marks:
	mq Mark location in mark "q".
	`q Go back to location stored in mark "q".

## Section movements

See `help ]]`:
 * `[[` Beginning of current section or previous `{`.
 * `]]` Beginning of next section or next `{`.
 * `][` Beginning of next section or next `}`.
 * `][` Beginning of current section or previous `}`.

Example of redefining section movements for filetype Potion. Create file `ftplugin/potion/sections.vim`:
```vim
noremap <script> <buffer> <silent> [[ :call <SID>NextSection(1, 1, 0)<cr>
noremap <script> <buffer> <silent> ]] :call <SID>NextSection(1, 0, 0)<cr>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection(2, 0, 0)<cr>
noremap <script> <buffer> <silent> [] :call <SID>NextSection(2, 1, 0)<cr>
vnoremap <script> <buffer> <silent> [[ :<c-u>call <SID>NextSection(1, 1, 1)<cr>
vnoremap <script> <buffer> <silent> ]] :<c-u>call <SID>NextSection(1, 0, 1)<cr>
vnoremap <script> <buffer> <silent> ][ :<c-u>call <SID>NextSection(2, 0, 1)<cr>
vnoremap <script> <buffer> <silent> [] :<c-u>call <SID>NextSection(2, 1, 1)<cr>

function! s:NextSection(type, backwards, visual)
	if a:visual
		normal! gv
	endif

	if a:type == 1
		let pattern = '\v(\n\n^\S|%^)'
		let flags = 'e'
	elseif a:type == 2
		let pattern = '\v^\S.*\=.*:$'
		let flags = ''
	endif

	if a:backwards
		let dir = '?'
	else
		let dir = '/'
	endif

	execute 'silent normal! ' . dir . pattern . dir . flags . "\r"
endfunction
```

## Execute external command ( ! operator)

`!` operator runs a command and display its output:
```vim
:!ls
```

Use `silent` to suppress the output and the prompt for pressing *ENTER*:
```vim
:silent !ls
```
Vim screen could be altered by use of `silent` afterward. In this case use `:redraw!` to fix the screen.

Example of a function to compile & run a Potion script file.
Write the following `ftplugin/potion/running.vim`:
```vim
if !exists("g:potion_command")
	let g:potion_command = "potion"
endif

function! PotionCompileAndRunFile()
	silent !clear
	execute "!" . g:potion_command . " " . bufname("%")
endfunction

function! PotionShowBytecode()
	" Get the bytecode.
	let bytecode = system(g:potion_command . " -c -V " . bufname("%"))

	" Open a new split and set it up.
	vsplit __Potion_Bytecode__ " Split a new buffer
	normal! ggdG " Delete everything inside buffer
	setlocal filetype=potionbytecode " Set buffer type
	setlocal buftype=nofile " Set the buffer as scratch (never saved)

	" Insert the bytecode.
	call append(0, split(bytecode, '\v\n'))
endfunction

nnoremap <buffer> <localleader>r :call PotionCompileAndRunFile()<cr>
nnoremap <buffer> <localleader>b :call PotionShowBytecode()<cr>
```
The command `!clear` clears the screen.

## Windows

Command                 | Description
----------------------- | ---------------------
`:split`                | Split horizontally.
`:sp`                   | Split horizontally.
`:sp myfile`            | Open file into a new window split, horizontally.
`Ctrl-ws`               | Split horizontally.
`:vsplit`               | Split vertically.
`:vs`                   | Split vertically.
`:vs myfile`            | Open file into a new window split, vertically.
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
`:tabo[nly]`            | Close all other tabs (show only the current tab).
`:tab split`            | Copy the current window to a new tab of its own.
`Ctrl-w T`              | Move current window to a new tab page.
----------------------- | ---------------------
`:tabs`                 | List all tabs including their displayed windows.
`:tabm 0`               | Move current tab to first.
`:tabm 2`               | Move current tab to position 3.
`:tabm -2`              | Move current tab of 2 positions to the left.
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
set textwidth=79
set tw=40
```

Unset textwidth:
```vim
set tw=0
```

To force physical wraping of text on selected lines, use `gq` key commands.

## Folding

 * [Folding](http://vim.wikia.com/wiki/Folding).
 * [How to fold](http://vimcasts.org/episodes/how-to-fold/).
 * [Writing a custom fold expression](http://vimcasts.org/episodes/writing-a-custom-fold-expression/).
 * [Advanced Folding](https://learnvimscriptthehardway.stevelosh.com/chapters/49.html).

6 different ways of folding:
	manual Created manually, erased when leaving Vim. May be used in conjunction with some key mapping.
	marker Use markers `{{{` for begin and `}}}` for end (optional). Levels are possible `{{{1`, `{{{2`, ....
	diff   Used in vimdiff.
	expr
	indent Uses code indentation for folding.
	syntax
See `help foldmethod`.

Vim associates each line with a folding level.
 * A line with a level of `0` is never folded.
 * Lines of same level are grouped together.
 * When fold of level n is closed, all lines with level >= n are folded with it.
To display the fold level of line 3:
```vim
echom foldlevel(3)
```

```vim
setlocal foldmethod=syntax
```

Set folding style inside file:
```cpp
// vi: fdm=marker
```

Marker folding (use `{{{` or `{{{X` markingi with or without `}}}` ending marker):
```vim
" My section {{{
...
" }}}

" My other section {{{1
```

Key  | Description
---- | -----------------------
`zc` | Close a fold.
`zo` | Open a fold.
`za` | Toggle a fold.
`zC` | Close all folds at current position.
`zO` | Open all folds at current position.
`zA` | Toggle all folds at current position.
`zr` | Open all folds by one more level.
`zR` | Open all levels of all folds.
`zm` | Close all folds by one more level.
`zM` | Close all levels of all folds.

Example with defining folding for Potion language using indent method. Create the following `ftplugin/potion/folding.vim` file:
```vim
setlocal foldmethod=indent
setlocal foldignore=
```
The `foldignore=` is used to cancel ignoring of lines starting with `#`. This is only relevant for indent folding.

Using expr method gives more flexibility. Here is an example:
```vim
setlocal foldmethod=expr
setlocal foldexpr=GetPotionFold(v:lnum)

function! GetPotionFold(lnum)
	" Blank lines
	if getline(a:lnum) =~? '\v^\s*$'
		return '-1'
	endif

	let this_indent = IndentLevel(a:lnum)
	let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

	if next_indent == this_indent
		return this_indent
	elseif next_indent < this_indent
		return this_indent
	elseif next_indent > this_indent
		return '>' . next_indent
	endif
endfunction

function! IndentLevel(lnum)
	return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
	let numlines = line('$') " Total number of lines in buffer
	let current = a:lnum + 1

	while current <= numlines
		if getline(current) =~? '\v\S' " Line contains at least one non-blank char
			return current
		endif

		let current += 1
	endwhile

	return -2
endfunction
```
`>1` means to start a fold level 1 on this line.
`<3` means to end a fold level 3 on this line.
`a2` means that fold level = fold level of previous line + 2.
`s3` means that fold level = fold level of previous line - 3.
`-1` means undefined folding level. Vim will define and set the level of this line to the level of the line before or after, which ever is smaller. However when it's before a fold level `>1` it will be set to 0.
`0` means "no fold".
`=` means to use fold level from the previous line.

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

To avoid the listing of all the processed files, use `silent`:
```vim
silent argdo %s/sometext/somereplacement/ge | update
```

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

 * [Search and replace](http://vim.wikia.com/wiki/Search_and_replace).

Command           | Description
----------------- | --------------------------------------
`*`               | Search forwards for current word (the one under the cursor).
`#`               | Search backwards for current word (the one under the cursor).
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

Regex code        | Description
----------------- | ----------------------------------------
`\n`              | Newline character when searching.
`\r`              | Newline character when replacing.
`\v`              | 'Very magic' mode to use extended regex.
                  | Put it at the start of the regex.

Search for character with its hexadecimal code: `/\%x95`.

Delete all lines matching a pattern:
```
g/print(/d
```

Delete all lines not matching a pattern:
```
g!/print(/d
```
or
```
v/print(/d
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

To replace new lines use `\n` in the match part. To replace carriage returns use `\r`.
To insert a new line in the replace part, use `\r` (`\n` inserts a null character).

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

 * [Get the name of the current file](https://vim.fandom.com/wiki/Get_the_name_of_the_current_file).

Command               | Description
--------------------- | ---------------
`:e myfile`           | Open file.
`:e#`                 | Previous file.
`:e!`                 | Revert file.
`:e .`                | Open current directory in navigator.
`:E`                  | Open directory of current file in navigator.
`Ctrl-G`              | Print file name of the current buffer.
`1 Ctrl-G`            | Print full path of the current buffer.
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

To execute a command in each buffer:
```vim
bufdo e
```

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
command -nargs=+ MyCommand the_command <args>
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

## Operators

An operator is a command that waits for you to enter a movement command (for selecting the text on which to apply the operator).

Op. | Description
--- | -----------------
d   | delete
y   | yank
p   | paste
c   | change (delete selection and go into insert mode)
v   | select

Some movements associated with these operators:

Movement | Description
-------- | -----------------
i(       | Select everything inside the parenthesis surrounding the current position.
iw       | Select current word.
t,       | Select everything up to the next comma (excluded).
w        | Select everything up to beginning of next word (excluded).
W        | Select everything up to beginning of next word (excluded), including punctuations as part of the current word.
e        | Select everything up to end of current word.
E        | Select everything up to end of current word, including punctuations as part of the word.
$        | Select everything up to end of line.
G        | Select everything up to end of file.

See `onoremap` for defining new movements for these operators.

These operators have uppercase versions and double versions, which are shortcuts:
Keys | Description
---- | -------------------
D    | Delete current line.
dd   | Delete current line.
Y    | Yank current line.
yy   | Yank current line.
C    | Change from current position to end of line.
cc   | Change current line.
V    | Select current line.

## Copy, paste & registers

 * [How to paste yanked text into Vim command line?](http://stackoverflow.com/questions/3997078/how-to-paste-yanked-text-into-vim-command-line).

Normal mode:
keys   | Description
------ | -------------------
`P`    | Paste above current line or before cursor.
`p`    | Paste below current line or after cursor.
`"k`   | Set/access (depending on the following command) register k (any letter can be used). Example: `"kyy`, `"kp`.
`"K`   | Append to register k.
`:reg` | Get list of all actual registers.
`x`    | Delete current character.

In command or insert mode:
keys        | Description
----------- | -------------------
`C-R ?`     | Paste from register ?.
`C-R C-O ?` | Pastes and handles control characters, if there are, from register ?.

Register | Description
-------- | --------------------------------------------
`0`      | Yank register. The one used when pressing `y`.
`1`..`9` | Shifting delete registers. Used when pressing `c` or `d`.
`a`..`z` | User registers.
`+`, `\*` | System clipboard registers.
@         | Unnamed register
"         | Unnamed register (i.e.: default register)
/         | Search pattern used
%         | Current buffer file path

Accessing register in Vimscript:
```vim
echom @@ " unnamed register (default register, used when yanking or deleting).
```

## Debugging

 * [Debugging Vim by example](https://codeinthehole.com/tips/debugging-vim-by-example/).

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

## Profiling

Profiling a command:
```vim
profile start ~/profile.log
profile file * " Profiles all Vimscript files
profile func * " Profiles all functions
do_something " Runs a command that will be profiled
quit " Leaves Vim
```

Then opens the profile log file to look at result.

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
`zG`    | Add word as good word into internal word list.
`zw`    | Add word as bad word to spell file.
`zW`    | Add word as bad word into internal word list.
`zuw`   | Remove word from list.
`zug`   | Remove word from list.
`zuW`   | Remove word from list.
`zuG`   | Remove word from list.
`z=`    | Make suggestions for bad word.

Repeat the replacement done by |z=| for all matches with the replaced word in the current window:
```
:spellr[epall]
```


## Insert mode

 * [Insert mode](http://vimdoc.sourceforge.net/htmldoc/insert.html). See this page for a list of key bindings in insert mode.

Command     | Description
----------- | --------------------------------------------
`CTRL-R "`  | Insert the content of the unnamed register.
`CTRL-R +`  | Insert the content of the clipboard. 
<esc>       | Quit insert mode.
<c-c>       | Quit insert mode.
<c-[>       | Quit insert mode.

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

To override a group link:
```vim
hi! def link rNumber Float
```

### Embedded syntax highligthing

 * [Different syntax highlighting within regions of a file](https://vim.fandom.com/wiki/Different_syntax_highlighting_within_regions_of_a_file).
 * [vim-syntax-shakespeare](https://github.com/pbrisbin/vim-syntax-shakespeare/blob/master/after/syntax/haskell.vim).

Embedded syntax highlighting (syntax highlighting of code embedded inside another language code):
```bash
runtime! syntax/xml.vim
unlet b:current_syntax
syntax include @Python syntax/python.vim
syntax region pythonCode  start=+<Python>+ keepend end=+</Python>+  contains=@Python
```

## mkspell

Generates a Vim spell file from a list of words.

```vim
mkspell ~/.vim/spell/en.utf-8.add
```

## Pipe character (|)

Pipe character is used to separate commands on the same line:
```vim
om "foo" | echom "bar"
```

## Statements

### if

 * [Conditionals](http://learnvimscriptthehardway.stevelosh.com/chapters/21.html).
 * [Comparisons](http://learnvimscriptthehardway.stevelosh.com/chapters/22.html).

```vim
if cond1
	...
elseif cond2
	...
else
	...
endif
```

If the expression passed to if is not a number, it will be coerced to a number. So if it is a string that starts with a number (e.g.: "13foo") then it will be coerced to that number, otherwise it will be coerced to zero.
```vim
if ""    " 0 => False
if "10"  " 10 => True
if "10foo"  " 10 => True
if "foo"  " 0 => False
if "foo" + 10  " 10 => True
```

Testing an option:
```vim
if &myopt == 'myvalue'
endif
```

Compare numbers:
```vim
if 1 < 2
```

Test equality of numbers:
```vim
if 1 == 2
```

Test equality of strings (depending on `ignorecase` option):
```vim
if "foo" == "FOO"
```

Test equality of strings (case-insensitive):
```vim
if "foo" ==? "FOO"
```

Test equality of strings (case-sensitive):
```vim
if "foo" ==# "FOO"
```

Case-sensitive comparison:
```vim
if "foo" ># "Foo"
```

### for

Loop on elements of a list:
```vim
for i in [1, 2, 5, 70]
	echom i
endfor
```

### while

```vim
while i <= 10
	echom i
endwhile
```

## Types

### Number

A Number is a 32 bit signed integer.

A decimal:
```vim
echom 100
```

An hexadecimal:
```vim
echom 0xff
echom 0Xff
```

An octal:
```vim
echom 010 " Decimal 8
```
But wrong octals are silently interpreted as decimals:
```vim
echom 019 " Decimal 19
```

### Float

Diverse float numbers:
```vim
echo 100.1
echo 5.45e+3
echo 15.45e-2
echo 15.3e9
echo 5e10 " Error ! Decimal point is compulsory.
```

### Boolean

A boolean option has for value `1` or `0` when used.
All integer values different of `0` are treated as true.

### Strings

 * [Strings](http://learnvimscriptthehardway.stevelosh.com/chapters/26.html).
 * [String Functions](http://learnvimscriptthehardway.stevelosh.com/chapters/27.html).

A string:
```vim
echom "Hello"
```

Escaping characters:
```vim
echom "a \"b\" \\c."
echo "a\nb" " Will print two lines.
echom "a\nb" " Will replace \n with ^@
```

Literal string (no escaping):
```vim
echo 'a\nb' " No escaping. Will print a\nb.
echo 'a''b' " Will print a'b.
```

Returns the length of a string:
```vim
echom strlen("foo")
```

Getting a character from a string:
```vim
echo 'abcdef'[1] " 'a'
echo 'abcdef'[-1] " '' empty string is always returned for negative indices.
```

Getting a subrange of a string:
```vim
echo 'abcdef'[0:2] " 'abc'
echo 'abcdef'[3:] " 'def'
echo 'abcdef'[-2:] " 'ef', negative indices are allowed in a range.
```

Concatenate strings:
```vim
echo 'abc' . 'def'
```

Splits a string into a list:
```vim
echo split("one two three")
echo split("one,two,three", ",")
```

Joins a list into a string:
```vim
echo join(["foo", "bar"], ",")
```

Convert string to lower case:
```vim
echom tolower("Foo")
```

Convert string to upper case:
```vim
echom toupper("foo")
```

Search for a substring:
```vim
match('mystringtosearch', '[a-i]')
```
Returns the index of the substring or `-1`.

Get the found substring:
```vim
matchstr('mystringtosearch', '[a-i]')
```

Get a subgroup from a regex match:
```vim
let m = matchlist('MyStringToMatchAnInteger123, '^[^0-9]*\([0-9]\+\)$')
if len(m) > 0
	let i = m[1]
endif
```

### Lists

 * [Lists](http://learnvimscriptthehardway.stevelosh.com/chapters/35.html).

Create a list:
```vim
echo ['foo', 3, 'bar']
```

Create a list of integers from 1 to 50:
```vim
echo range(1, 50)
```
Create a list of integers from 1 to 50, with step 2:
```vim
echo range(1, 50, 2)
```

A nested list:
```vim
echo ['foo', [3, 'bar']]
```

Lists are zero indexed. Negative indices can be used to get elements starting from the end: `-1` is the last, `-2` the one before the last, etc. 
Get elements:
```vim
echo [0, 2]][0] " 0
echo [0, 2][1] " 2
echo [0, 2][-1] " 2
echo [0, 2][-2] " 0
```

Slicing:
```vim
echo ['a', 'b', 'c', 'd', 'e'][0:2] " ['a', 'b', 'c']
echo ['a', 'b', 'c', 'd', 'e'][0:100000] " Whole list.
echo ['a', 'b', 'c', 'd', 'e'][-2:-1] " ['d', 'e']
echo ['a', 'b', 'c', 'd', 'e'][:1] " ['a', 'b']
echo ['a', 'b', 'c', 'd', 'e'][3:] " ['d', 'e']
```

Concatenate lists:
```vim
echo ['a', 'b'] + ['c']
```

Define a list:
```vim
let mylist = ['a']
```

Get the length of a list:
```vim
len(['a', 'b']) " 2
```

Get a value from a list, using default value:
```vim
get(['a'], 0, 'default') " 'a'
get(['a'], 100, 'default') " 'default'
```

Search for an element:
```vim
index(['a', 'b'], 'b') " 1
index(['a', 'b'], 'c') " -1
```

Join:
```vim
join(['a', 'b']) " 'a b'
join(['a', 'b'], '-') " 'a-b'
```

Reverse elements in-place:
```vim
call reverse(mylist)
```

Sort a list:
```vim
call sort(mylist)
```

Append to a list:
```vim
call add(mylist, 'b')
```

Make a copy:
```vim
myNewList = deepcopy(mylist)
```

Remove element in-place:
```vim
call remove(mylist, 'a')
```

Apply a function on each element:
```vim
call map(mylist, 'myfunc(v:val)')
```

Filter out values:
```vim
call filter(mylist, 'myfunc(v:val)')
```

### Dictionaries

Keys are always strings.

Define a dictionary:
```vim
{'a': 1, 'b': 'foo'}
{'a': 1, 'b': 'foo',} " Coma after last element is ignored.
```

Get a element:
```vim
{'a': 1, 100: 'foo',}['a'] " 1
{'a': 1, 100: 'foo',}[100] " 'foo'
{'a': 1, 100: 'foo',}.a    " 1
{'a': 1, 100: 'foo',}.100  " 'foo'
```

Using `get()` and default value to get an element's value:
```vim
get({'a': 100}, 'a', 'default') " 100
get({'a': 100}, 'b', 'default') " 'default'
```

Check if a key exists:
```vim
has_key({'a': 100}, 'a') " 1
has_key({'a': 100}, 'b') " 0
```

Adding an element:
```vim
let mydict.key = 100
```

Remove an entry:
```vim
unlet mydict.key
unlet mydict['key']
```

Remove an entry and get the removed value:
```vim
let removeValue = remove(mydict, 'key')
```

Removing an non existing key generates an error.

Getting the list of keys:
```vim
keys({'a': 100, 'b': 200}) " ['a', 'b']
```

Getting the list of values:
```vim
values({'a': 100, 'b': 200}) " [100, 200]
```

Getting a selections of entries:
```vim
items({'a': 100, 'b': 200}) " [['a', 100], ['b', 200]]
```

## Concatenate operatoe

To concatenate strings:
```vim
echom "a" . "b"
```
Integers can be used with concatenation:
```vim
echom "a" . 10
```
## Arithmetic operators

Integer division:
```vim
echom 3 / 2
```

Float division:
```vim
echom 3 / 2.0
```

Additions cast strings into integers (Number type):
```vim
echom "a" + "b" " Gives 0.
echom "20a" + "b" " Gives 20.
echom "20" + "5.6" " Gives 25.
```

## function

Functions must start with a capital letter if they are unscoped!:
```vim
function Meow()
	echom "Meow!"
endfunction
```

Redefinition of a function is forbidden by default.
To override this, use the `!` suffix:
```vim
function! Meow()
	echom "Meow!"
endfunction
```

Even if scoped, convention is to capitalize the first letter of a function.

Function with a return value:
```vim
function Foo()
	return "foo"
endfunction
```

A function not returning any value is called with `call`:
```vim
call Meow()
```
One with a return value is used in expressions:
```vim
echom Foo()
```
A function not returning explicitly a value, returns `0`.

Function with an argument:
```vim
function DisplayName(name)
	echom "Hello!  My name is:"
	echom a:name
:endfunction
```
Arguments must be prefixed by `a:` when used.
Call the function:
```vim
call DisplayName("Your Name")
```

Variable length arguments:
```vim
function Varg2(foo, ...)
	echom a:foo
	echom a:0 " Number of arguments in `...`.
	echom a:1 " First argument in `...`.
	echo a:000 " full list of arguments in `...`.
endfunction
```

Arguments are not modifiable inside a function, we must create local variables:
```vim
function AssignGood(foo)
	let foo_tmp = a:foo
	let foo_tmp = "Yep"
	echom foo_tmp
endfunction
```

## call

Calls a function:
```vim
call MyFct()
```

## operatorfunc

This option allows to use a function as an operator inside a key mapping.

```vim
noremap <leader>g :set operatorfunc=GrepOperator<cr>g@

function! GrepOperator(type)
	echom "Test"
endfunction
```

## echo

Print string at bottom of window:
```vim
echo "My string"
```

Print a variable:
```vim
echo foo
```

Print option:
```vim
echo &myopt
```

Print a register:
```vim
echom @a
```

Print buffer local variable:
```vim
echo b:myvar
```

## echom

Print and save in messages:
```vim
echom "My string"
```

## messages

Print list of messages:
```vim
messages
```

## Comments

Write comments:
```vim
" Some comment
```

## append

Appends text into a buffer.

Insert text at beginning of buffer:
```vim
call append(0, ['line1', 'line2', 'line3'])
```

## Environment variables

Set an environment variable:
```vim
let $MYVAR='myvalue'
```

Unset an environment variable:
```vim
unlet $MYVAR
```

Print an environment variable:
```vim
echo $MYVAR
```

## set

See <http://learnvimscriptthehardway.stevelosh.com/chapters/19.html#options-as-variables>.

Append to a list or string:
```vim
set myopt+=myval
```

Insert at beginning of list or string:
```vim
set myopt^=myval
```

Set a boolean option on:
```vim
set number
```
Set a boolean option off:
```vim
set nonumber
```
Toggle a boolean option:
```vim
set number!
```

Get a boolean option value:
```vim
set number? " Returns 'number' or 'nonumber'.
```

Set an option with value:
```vim
set numberwidth=10
```

Get an option's value:
```vim
set numberwidth?
```

Set multiple options:
```vim
set number numberwidth=8
```

## setlocal

Set option locally for the current buffer only:
```vim
setlocal number
```

Many options have a shortcut, like filetype:
```vim
set ft=C
```

For printing an option:
```vim
set myopt
```

## let

Set a variable:
```vim
let foo = "bar"
let foo2 = 23
```

Set a buffer local variable:
```vim
let b:myvar = 1
```

Use `let` to set an option's value from a computation:
```vim
let &myopt = someothervar + 10 + z
```

Set option locally:
```vim
let &l:number = 1
```

Set register:
```vim
let @a = "hello!"
```

Variable scope:
	  g: global variable
	  b: local buffer variable
	  w: local window variable
	  t: local tab page variable
	  s: script-local variable
	  l: local function variable
	  a: parameter of the current function
	  v: Vim variable.

Prefixes for options, registers and env vars:
	&varname    A Vim option (local option if defined, otherwise global)
	&l:varname  A local Vim option
	&g:varname  A global Vim option
	@varname    A Vim register
	$varname    An environment variable

## Assignement operators

Set a variable
```vim
let myvar = 'a'
```

Add a number:
```vim
let n += 4
```

Concatenate:
```vim
let s .= 'a'
```

## put

Writing an option to the current buffer:
```vim
put=&myopt
```

## len

Returns the length of a string:
```vim
echom len("foo")
```

## escape

Escape characters with `\`.

Escape space and backslash characters:
```vim
echo escape('c:\program files\vim', ' \')
```

## shellescape

Escape a string so it can be used safely as an argument for a shell command.

```vim
call system("chmod +w -- " . shellescape(expand("%")))
```

## silent

Hides messages of a command.

```vim
silent mycommand ...
```

## winnr

Returns the current window's number:
```vim
let n = winnr()
```

A window number may change each time windows are closed and opened.
It is only for one tab.

## bufwinid

Returns the window-ID of the first buffer matched by an expression:
```vim
bufwinid('myexpr')
```

The window-ID of a buffer never changes during a Vim session.
It is valid accross tabs.

## bufwinnr

Returns the window number of the first buffer matched by an expression:
```vim
bufwinnr('myexpr')
```

A window number may change each time windows are closed and opened.
It is only for one tab.

## wincmd

Moves to window n:
```vim
execute n . 'wincmd w'
```

## bufnr

Get the number of the current buffer:
```vim
bufnr()
```

Get the number of the buffer matching an expression, and with the highest number:
```vim
bufnr('myexpr')
```

### bufname

Get the name of the current buffer:
```vim
bufname()
```

We can search with an expression:
```vim
bufname('myexpr')
```

## system

Calls an external program and returns its output as a string.

Call `ls`:
```vim
system("ls")
```

Pass characters on stdin:
```vim
system('wc -c', 'abcdef')
```

## File system

Testing if a file exists:
```vim
filereadable(myfile)
```

Get relative path of current buffer:
```vim
expand('%')
```

Get absolute path of current buffer:
```vim
expand('%:p')
```

Get path to a file inside current directory:
```vim
fnamemodify('foo.txt', ':p')
```

When using `~`, get the fullpath by calling `expand`:
```vim
let myfile = expand("~/.vim/spell/en.utf-8.add")
```

Getting the modification time of a file:
```vim
let modiftime = getftime(myfile)
```

List files in current directory:
```vim
globpath('.', '*')
```
The result of `globpath()` is a single string containing filenames separated by newline characters.
To get a list, run:
```vim
split(globpath('.', '*'), '\n')
split(globpath('.', '*.txt'), '\n')
split(globpath('.', 'prefix?.txt'), '\n') " ? replaces one character.
split(globpath('.', 'prefix[abc].txt'), '\n') " '[abc]' matches 'a', 'b' or 'c'.
split(globpath('.', '**'), '\n') " '**' recursively list files.
```

Get real file behing symbolic link:
```vim
resolve(myfilename)
```

Change directory:
```vim
cd /my/new/dir
chdir /my/new/dir
lcd /my/new/dir " Local. Only for current window
lchdir /my/new/dir " Local. Only for current window
tcd /my/new/dir " Only for current tab (and all its windows).
tchdir /my/new/dir " Only for current tab (and all its windows).
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

Sort decimal integer numbers:
```vim
sort n
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

## Internal vim grep command

```vim
vim /print(/ ~/dev/mydir/*
```

## grep

```vim
gr mypattern myfiles
grep mypattern myfiles
```

Do not jump to first result (but still fill quickfix window):
```vim
grep! mypattern
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

## errorformat

 * [Vim errorformat Demystified](https://flukus.github.io/vim-errorformat-demystified.html).

To add a new error format:
```vim
set errorformat+=%*[\"]%f%*[\"]\\,\ line\ %l:\ %m
```
For a literal %, type %%.

To insert a new error format at beginning of list:
```vim
set errorformat^=someformat
```

Reset to default value:
```vim
set errorformat&
```

## Netrw

 * [Vim: you don't need NERDtree or (maybe) netrw](https://shapeshed.com/vim-netrw/).

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
i       | Change view.

Set the tree view as default:
```vim
let g:netrw_liststyle = 3
```

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
`viWgx`     | Select "word" (it will select special chars like '?') under cursor and open the corresponding link in browser.
`gf`        | Open the file whose name under the cursor.
`Ctrl-W f`  | Open file under cursor into a new window (horizontal split).
`Ctrl-W gf` | Open file under cursor into a new tab.

The file is searched inside the vim path. To see its actual value run `:echo &path`.
The path is a comma separated list of directories.
Special meaning inside the path:
`.` The directory containing the current file.
`/usr/share/doc;` First search in `/usr/share/doc`, then `/usr/share/`, then `/usr/`, then `/`.
`/home/kate/*` Search all of `/home/kate` and its subfolders, recursively.

## cword, cWORD, cfile, ...

`<cword>` is replaced with word under cursor.
`<cWORD>` is replaced with WORD (series of non-blank characters)) under cursor.
`<cfile>` is replaced with path under cursor.
`<cexpr>` is replaced with C expression under cursor.

## cfile

Read error file and jump to first error:
```vim
cfile myerrorfile.err
```

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

## Packages

Packages management:
 * [Vim: So long Pathogen, hello native package loading](https://shapeshed.com/vim-packages/).

Packages must be installed in `~/.vim/pack/somedir/start` for automatic loading at startup, or `~/.vim/pack/somedir/opt` for manual loading with `packadd packagename` command.

### Markdown plugins

 * https://github.com/tpope/vim-markdown
 * https://github.com/plasticboy/vim-markdown
 * https://github.com/masukomi/vim-markdown-folding
 * https://github.com/vim-pandoc/vim-pandoc
 * https://github.com/vim-pandoc/vim-pandoc-syntax

### vim-commentary

 * [vim-commentary](https://github.com/tpope/vim-commentary).

command | Description
------- | -------------
`gcc`   | comment out or uncomment a line.
`gc`    | to comment out a selected block.

### csv.vim

 * [csv.vim](https://github.com/chrisbra/csv.vim).

Command        | Description
-------------- | --------------------
WhatColumn     | Get index of current column.
WhatColumn!    | Get name of current column (read from header).
ArrangeColumn  | Align columns.
ArrangeColumn! | Align columns (force recalculating).
SumCol         | Sum of a column.
Header         | Open top window with one line header.
Header 4       | Open top window with 4 lines header.
VHeader 2      | Open left window with 2 first columns.
VHeader 2!     | Open left window with 2nd column.
Header!        | Close header window.
AddColumn      | Insert new column.

### YouCompleteMe

Code completion for Python, C, C++, C#, Java, ...

 * [YouCompleteMe: a code-completion engine for Vim](https://github.com/ycm-core/YouCompleteMe).

### Status line plugins

 * [lightline](https://github.com/itchyny/lightline.vim).
 * [powerline](https://github.com/powerline/powerline). Enhanced status line.

### Pathogen

DEPRECATED because of native package loading.

Pathogen is a package for easying package installation.

 * [Pathogen](http://www.vim.org/scripts/script.php?script_id=2332).
 * [The Modern Vim Config with Pathogen](http://tammersaleh.com/posts/the-modern-vim-config-with-pathogen/).

With Pathogen, packages are now installed inside ~/.vim/bundle folder in a dedicated folders, and are automatically configured.

### Python

 * [VIM and Python – A Match Made in Heaven](https://realpython.com/vim-and-python-a-match-made-in-heaven/).
 * [SimpylFold](https://github.com/tmhedberg/SimpylFold). Plugin for correct Python indent folding.
 * https://github.com/ivanov/vim-ipython

### nvim-R

 * [For R: nvim-R](https://hpcc.ucr.edu/manuals_linux-cluster_terminalIDE.html#for-r-nvim-r).
 * [nvim-R](https://github.com/jalvesaq/Nvim-R).

Start an R session (does not need an opened .R file):
```vim
call StartR("R")
```

Nvim-R commands:
 * Intialize a connected R session with `\rf` (Once an .R file has been opened).
 * `\l`: send current line to R session.
 * `\bb`: send current block.
 * `\cc`: send current chunk.
 * `\ff`: send current function.
 * `\ss`: send selection.
 * `\ro`: open Object Browser.

### Tmux

 * [Tmux conf file](https://github.com/tmux-plugins/vim-tmux).
