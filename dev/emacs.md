<!-- vimvars: b:markdown_embedded_syntax={'lisp':'scheme'} -->
# Emacs

Centralized emacs option file:
make a symlink of the directiory `Documents/informatique/UNIX/emacs` to `~/.emacs_dir`, then put this single line into `~/.emacs`:
```lisp
(load "~/.emacs_dir/emacs.el")
```

PATH:
```lisp
(setenv "PATH" ...) --> env path, used mainly when in emacs' shell
(setq exec-path ...) --> where emacs find programs to execute
```

ACCESSING MENU:
	F10 or M-x menu-bar-open

COMPILING
formats of error messages are stored inside variable `compilation-error-regexp-alist`.

## Keys

Keys                | Effect
------------------- | ------------------------------
C-x C-c             | Quit
C-x r m             | create a bookmark
C-x r b             | jump to a bookmark
C-x b               | switch to another buffer
C-x k               | close current buffer
M-x                 | grep-regexp-alist
C-j                 | to evaluate an expression or a variable value in the scratch buffer (i.e. in Lisp Interaction mode).
C-x C-e             | evaluate a lisp expression, for instance in the .emacs file.
M-:                 | prompt for expression
C-h v               | display variable value & information
M-x help            | equivalent to C-h
C-h c, C-h k        | What does this key do?
C-h f               | What does this function do?
C-h v               | What does this variable do?
C-h a               | Search for commands by regexp.
C-h m, C-h b        | Describe the current major mode.
C-x RET f           | Changer l'encodage du buffer
C-SPC or C-@        | set mark
M-w                 | copy
C-w                 | cut
C-y                 | paste
C-q TAB             | Insert TAB
C-v                 | page down
M-v                 | page up
C-l                 | put current line at center of window
C-0 C-l             | put current line at top of window
C-b                 | cursor backward
C-f                 | cursor forward
M-b                 | backward a word
M-f                 | forward a word
C-p                 | previous line
C-n                 | next line
C-a                 | beginning of line
C-e                 | end of line
M-a                 | beginning of sentence
M-e                 | end of sentence
M-<                 | beginning of buffer
M->                 | end of buffer
C-x 0               | close current window
C-x 1               | keep only current window
C-x 2               | split horizontally
C-x 3               | split verticaly
C-x o               | switch between windows
C-x ^               | enlarge window by one line

## Commands

Command                             | Description
----------------------------------- | ------------------------------------------------
M-x enlarge-window                  | enlarge by one line
M-x shrink-window                   | shrink by one line
M-x enlarge-window-horinzontally    | enlarge by one column
M-x shrink-window-horinzontally     | shrink by one column

## Emacs lisp

set variable:
```lisp
(set 'myvar' '(item1 item2))
(setq myvar '(item1 item2))
```

Concat two values:
```lisp
(concat myvar "/some/path")
```

Insert an element at beginning of a list:
```lisp
(cons "somestring" '(item1 item2))
```

Condition:
```lisp
(if (eq my-var 'myvalue)
  ; do something
)
```

Condition on string:
```lisp
(if (equal myvar "mystring") ...)
(if (string= myvar "mystring") ...)
```

Test if emacs is running in GUI mode:
```lisp
(if window-system (...))
```

Execute multiple actions in a then or else clause:
```lisp
(if (eq my-var 'myvalue)
		(progn
			(some_func ...)
			(some_other_func ...))
	;; else part
	(progn
			(some_func2 ...)
			(some_other_func2 ...))
	)
```

For testing OS, use variable `system-type`. Values:
	`gnu'         compiled for a GNU Hurd system.
	`gnu/linux'   compiled for a GNU/Linux system.
	`darwin'      compiled for Darwin (GNU-Darwin, Mac OS X, ...).
	`ms-dos'      compiled as an MS-DOS application.
	`windows-nt'  compiled as a native W32 application.
	`cygwin'      compiled using the Cygwin library.

## Environment variables

Getting environment variable:
```lisp
(getenv "PATH")
(setq PATH (getenv "PATH"))
```

## Remote ssh editing

```lisp
(require 'tramp)
(setq tramp-default-method "ssh")
```
you can replace "ssh" with: scp, rsh, rcp, (rsync?)
usage (with C-x f):
	/teddy:.emacs

you can also specify the protocol:
	/ssh:myserver:mydir/myfile.txt

If you get the error "couldn't find an inline trasnfer encoding" when trying to use tramp ssh from linux/unix to Windows/cygwin, then check value of variable ramp-coding-commands. You should then have to install uuencode/uudecode in cygwin (package is sharutils).


## .emacs (init file)

	M-x load-file RET ~/.emacs RET

## load-path

Get current load-path:
	C-h v load-path
Add emacs user's directory to the load path:
```lisp
(setq load-path (cons "~/emacs" load-path))
```

## loading a file

load and evaluate the file
```lisp
(load "~/my/file/file.el")
```

## Install new major mode

To install a new mode lisp file <mylang>.el:
1) put in the site-lisp directory (under .../share/emacs). Check the right path by typing under emacs:
C-h v load-path
2) add the following two lines in ~/.emacs (example for applescript:
(autoload 'applescript-mode "applescript-mode" "AppleScript mode" t)
(setq auto-mode-alist (append '(("\\.scpt$" . applescript-mode))
auto-mode-alist))

OU:
```lisp
(add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
```

Force major mode in a script (place this line (commented) just after the '#!/...' script line:
	-*- mode: Emacs-Lisp -*-
or
	-*- Emacs-Lisp -*-

## MAJOR MODES

conf-mode       for configuration files
cc-mode         for C
cperl-mode      for Perl

## Change default major mode

To replace perl-mode with cperl-mode:

(defalias 'perl-mode 'cperl-mode)

OR:
```lisp
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))
```

OR:
```
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist))
```

## File local variables

Set in a comment line, between two `-*-` and separated by `;`:
```
-*- mode: Lisp; fill-column: 75; comment-column: 50; -*-
```

Special 'eval' variable:
```
-*- eval:(rename-buffer "todo-info") -*-
```
when opening a file which contains an 'eval' local variable, emacs asks wether or not to evaluate it. The following variables are used to control automatic evaluation of the 'eval' expressions:
```lisp
safe-local-eval-function 
safe-local-eval-forms
(custom-set-variables '(safe-local-eval-forms (quote ((rename-buffer)))) )
```

## Fonts

Listing fonts in scratch buffer:
```lisp
(prin1-to-string (x-list-fonts "*"))
```

Setting default font:
	;; menu -> options -> customize emacs -> specific face -> "def" [enter] 

In `.emacs`:
```lisp
(set-default-font "-adobe-courier-medium-r-normal--18-180-75-75-m-110-iso8859-1")
```

## Encodings

You can change the encoding to use for the file when saving using ‘C-x C-m f’.
You can also force this immediately by using ‘C-x C-m c <encoding> RET C-x C-w RET’.
You can force Emacs to read a file in a specific encoding with ‘C-x RET c C-x C-f’.

## UTF8

Forcer un fichier en UTF-8, à chaque chargement :
	-*- coding: utf-8 -*-

mettre utf-8 comme encodage par défaut dans le fichier de config `.emacs`:
```lisp
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
```

Loading files in utf-8 (tested in xemacs):
```lisp
(require 'un-define)
(set-coding-priority-list '(utf-8))
(set-coding-category-system 'utf-8 'utf-8)
```

## DOS <-> UNIX conversion

Dos to unix:
	M-x set-buffer-file-coding-system RET undecided-unix
or
	C-x RET f undecided-unix

Unix to dos:
	M-x set-buffer-file-coding-system RET undecided-dos
or
	C-x RET f undecided-dos

## Search & replace

C-s				search
C-S				search-regexp
M-% 				replace
M-x replace-regexp
M-x query-replace-regexp
groups for in regexp replace: \(...\) then \1 to use it.

M-x search-forward-regexp

M-x query-replace
M-x query-replace-regexp

To search & replace in multiple files, first select files, then:
M-x dired-do-query-replace-regexp

Save many files at once:
M-x ibuffer	then *u to mark all buffers, and S to save them all.

## Readonly

M-x toggle-read-only

## Selecting files

C-x C-f, then open a directory. 
Select files/dirs by moving cursor to them and pressing 'm'. 
Select files/dirs with a regexp: %m
Unselect  by pressing 'u'.
Enter a sub-directory by pressing 'i'.

You can first select files with find: M-x find-dired, type a directory path, then enter find arguments (e.g.: `-iname '*.html'` or `-type f`).

# Creating a new directory

M-x make-directory

When creating a file in a directory which doesn't exist yet, the following hook will automatically create the missing directories when saving buffer:
```lisp
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))
```

## Indentation

width of TAB key:
```lisp
(setq c-basic-offset 2)
```

width of TAB file-character:
```lisp
(setq tab-width 4)
```

To replace TAB chars by spaces when writing file:
```lisp
(setq indent-tabs-mode nil)
```

To indent relatively to words of previous line:
```lisp
indent-relative
```

## Tab stops

```lisp
(setq tab-stop-list '(4 8 12 16))
```
M-i moves to next tab stop

## Smart tabs

Smart tabs:
```lisp
;(setq-default tab-width 4) ; or any other preferred value
(setq cua-auto-tabify-rectangles nil)
(defadvice align (around smart-tabs activate)
	(let ((indent-tabs-mode nil)) ad-do-it))
(defadvice align-regexp (around smart-tabs activate)
	(let ((indent-tabs-mode nil)) ad-do-it))
(defadvice indent-relative (around smart-tabs activate)
	(let ((indent-tabs-mode nil)) ad-do-it))
(defmacro smart-tabs-advice (function offset)
	(defvaralias offset 'tab-width)
	`(defadvice ,function (around smart-tabs activate)
		 (cond
			(indent-tabs-mode
			 (save-excursion
				 (beginning-of-line)
				 (while (looking-at "\t*\\( +\\)\t+")
					 (replace-match "" nil nil nil 1)))
			 (setq tab-width tab-width)
			 (let ((tab-width fill-column)
						 (,offset fill-column))
				 ad-do-it))
			(t
			 ad-do-it))))
(smart-tabs-advice c-indent-line c-basic-offset) ; c
(smart-tabs-advice c-indent-region c-basic-offset) ; c
(smart-tabs-advice js2-indent-line js2-basic-offset) ; javascript
(smart-tabs-advice cperl-indent-line cperl-indent-level) ; cperl
```

## CC mode

to set a new c style (and thus new indentation style):
M-x c-set-style RET

## MODE HOOK

execute a function when a major mode is entered.
```lisp
(defun my-c++-indent-setup ()
  (setq c-basic-offset 3)
  (setq indent-tabs-mode nil))

(add-hook 'c++-mode-hook 'my-c++-indent-setup)
```

## Key binding

global:
```lisp
(global-set-key [?\M-r] 'indent-relative)
```

for a mode:
```lisp
(setq html-mode-hook
      '(lambda ()
	 (auto-fill-mode 1)
	 (define-key html-mode-map [?\C-c?\C-p] 'php-mode)
	 (define-key html-mode-map [?\C-c;] 'my-html-insert-comment)
	 ))
```

## Sort

M-x sort-lines

## Case

M-l Convert following word to lower case (downcase-word). 
M-u Convert following word to upper case (upcase-word). 
M-c Capitalize the following word (capitalize-word). 
C-x C-l Convert region to lower case (downcase-region). 
C-x C-u Convert region to upper case (upcase-region)

## Column & line modes

M-x column-number-mode
M-x line-number-mode

## KDE

to pass env vars to emacs, modify the command in KDE :
bash -i -c '/usr/bin/emacs %F'

## Line wrapping in sub-windows

set truncate-partial-width-windows to nil (i.e. off)

## Parenthesis matching

show-paren-mode 1

color in 256 colors terminal:
```sh
TERM=xterm-256color emacs -nw
```

## Color themes

emerge app-emacs/color-theme
then in emacs :
M^x color-themes-select

in .emacs:
(require 'color-theme)
;; load all color themes
(color-theme-initialize)
;; set default color theme
(color-theme-blue-sea)

## Customizing colors

```lisp
(set-face-foreground 'default "white")
(set-face-background 'default "black")
(set-cursor-color "red")
```
M-x customize-group <RET> font-lock-faces <RET>

under MacOS-X, color names are defined inside:
/usr/share/emacs/22.1/etc/rgb.txt

Default colors: white, black, red, green, blue, cyan, yellow, magenta
the default colors can be combined with:
	:weight bold
	:underline t

```lisp
(custom-set-faces
 '(font-lock-builtin-face ((((class color) (min-colors 8)) (:foreground "yellow" :weight bold))))
 '(font-lock-comment-delimiter-face ((default (:foreground "magenta")) (((class color) (min-colors 8) (background dark)) (:foreground "magenta"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background dark)) (:foreground "magenta"))))
 '(font-lock-constant-face ((((class color) (min-colors 8)) (:foreground "green" :weight bold))))
 '(font-lock-doc-face ((t (:foreground "magenta" :weight bold))))
 '(font-lock-function-name-face ((((class color) (min-colors 8)) (:foreground "white" :weight bold))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "red" :weight bold))))
 '(font-lock-negation-char-face ((t (:foreground "red" :weight bold))))
 '(font-lock-preprocessor-face ((t (:foreground "red"))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "blue"))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "blue" :weight bold))))
 '(font-lock-string-face ((((class color) (min-colors 8)) (:foreground "green"))))
 '(font-lock-type-face ((((class color) (min-colors 8)) (:foreground "yellow"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 8)) (:foreground "white"))))
 '(font-lock-warning-face ((((class color) (min-colors 8)) (:foreground "red")))))
```

Start in shell mode:
```sh
emacs -nw
```

## Accessing menu

M^x tmm-menubar

## Annuler une commande

C-g OR ESC-ESC-ESC

## Line wrapping

M-x toggle-truncate-lines

Or for a NotePad like mode :
M-x longlines-mode

Splitting a window vertically disables the line wrapping. But you can enable longlines-mode to bypass this feature/bug.

## Buffers, windows and keys

Options / settings / customize:
	M-x customize

Region:
C-@ or C-SPACE			set a mark
M-@    				?? does strange thing
C-g 				cancel a selection mark
M-x transient-mark-mode    	highlight the region
M-x delete-selection-mode	delete region on specific actions

in .emacs:
```lisp
(custom-set-variables
  '(delete-selection-mode t)
  '(transient-mark-mode t))
```

Deleting:
	<DEL>		delete backward one character
	C-d		delete forward one character
	M-<DEL>		delete backward one word
	M-d		delete forward one word
	M-z {char}	kill to next occurrence of character
	C-k 		kill to end of line

Syntax highlighting
to have nice syntax color highlighting, set in your shell init file:
```sh
export TERM="xterm-256color"
```

## Initial and default frame

```lisp
(setq initial-frame-alist
	  `((font . ,(if my-win32
			 (if have-win32-sixbyten-font
			     "-raster-sixbyten-normal-r-normal-normal-10-75-96-96-c-60-iso10646-1"
			   "-outline-Lucida Console-normal-r-normal-normal-11-82-96-96-c-*-iso8859-1")
		       ;; X's 6x10 font ...  Why not use "6x10" here?
		       "-Misc-Fixed-Medium-R-Normal--10-100-75-75-C-60-ISO8859-1"))
	    (background-color . ,(face-background 'default))
	    (foreground-color . ,(face-foreground 'default))
	    (horizontal-scroll-bars . nil)
	    (vertical-scroll-bars . nil)
	    (menu-bar-lines . 0)
	    ;;(icon-type . t)
	    (top . 50)		;; This is overridden by my-center-frame later.
	    (left . 50)		;; This is overridden by my-center-frame later.
	    (height . ,(if (or (not my-win32)
			       have-win32-sixbyten-font)
			   (my-frame-percent-to-char-height 97)
			 70))
	    (width . 100)
	    (cursor-color . "red")
	    (mouse-color . "green"))))
(setq default-frame-alist (copy-alist initial-frame-alist))
```

Put autosave files (ie #foo#) in one place:
```lisp
(defvar autosave-dir
	(concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
					(if buffer-file-name
							(concat "#" (file-name-nondirectory buffer-file-name) "#")
						(expand-file-name
						 (concat "#%" (buffer-name) "#")))))
```

Put backup files (ie foo~) in one place. (The backup-directory-alist
list contains regexp=>directory mappings; filenames matching a regexp are
backed up in the corresponding directory. Emacs will mkdir it if necessary.)
```lisp
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))
```

Stop writing backup files:
```lisp
(setq make-backup-files nil)
```

## Enriched mode

	M-x enriched-mode       Set it as minor mode on Text major mode.

	M-o ? | M-x facemnu-*				            format text
	M-o i | M-x facemenu-set-italic					set selected text in italic
	M-o b                                   set bold
	M-o d                                   reset (default)
	M-o u                                   underline
	M-o l                                   bold italic

To open an enriched text in raw mode use M-x find-file-literally.

## gdb

Run gdb:
M-x gdb

## Install

MacOS-X
There's already a version of emacs installed, but an old one: 22.1.1, 2007
To install a newer version:
```sh
brew install emacs
```

## meta-ctrl-option-keys

Key notations:
	M-<key>			Meta
	C-<key>			CTRL
	Alt-<key>		Option

Meta key:
Either ALT or ESC

Meta key:
```lisp
(setq mac-option-modifier 'meta) ;; Alt key is the default Meta key.
(setq mac-option-modifier 'none) ;; Unset Alt key.
(setq mac-command-modifier 'meta) ;; Sets the command (Apple) key as Meta
(setq mac-control-modifier 'meta) ;; Sets the control key as Meta
(setq mac-function-modifier 'meta) ;; Sets the function key as Meta (limitations on non-English keyboards)
```

## Navigate

Moving / scrolling:

Set up/down arrow keys to scroll line by line:
```lisp
(global-set-key [M-up] (lambda () (interactive) (scroll-down 1)))
(global-set-key [M-down] (lambda () (interactive) (scroll-up 1)))
```

## XML modes

Major modes:
 * nxml-mode
 * xml-mode

To complete a tag (an opening or a closing one): C-RET or M-TAB.

Completing end-tag:
	</ + C-RET
	C-c C-f (f=finish)
	C-c C-i (i=inline) to close an opening tag and insert an end-tag
	C-c C-b (b=block) same as C-c C-i but puts end-tag on next line
