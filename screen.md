SCREEN
======

Screen is a window manager that provides virtual DEC VT100 terminals.
Screen and its windows continue running (they are detached) when user leaves his session.

## Colors and font

To get 256 colors, screen must been compiled with the 256 colors option.

To get italics, see [Italic fonts in iTerm2, tmux, and vim](https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/).


## Configuration file

`~/.screenrc`.

To reload it from screen:
```
:source ~/.screenrc
```

## Status bar

 * See [screen's Appearance](http://aperiodic.net/screen/appearance).
 * [Status line String Escapes](https://www.gnu.org/software/screen/manual/screen.html#String-Escapes).

Set hard status line content:
```screenrc
hardstatus alwayslastline "%w%=%H - %D %d %M %0c"
```

## Window caption

The window caption is the bar at the bottom of the screen app.

Always display the window caption, even if there's no split: 
```screen
caption always
```

Set the string template:
```screen
caption string "..."
```

## Running

Command               | Description
--------------------- | ------------------------------------------------------------
`screen`              | Start a new session.
`screen -R`           | Resume to the first window found, or create one.
`screen -S mysession` | Create a new session specifying its name.
`screen -r`           | Resume a previous session.
`screen -dr`          | Resume a previous session, detaching it first if necessary.
`screen -ls`          | List sessions.
`screen -list`        | List sessions.

General commands
----------------

Command             | Description
------------------- | ---------------------------------------------
`C-a c`             | Create a new window, opening a new shell.
`C-a :screen`       | Create a new window, opening a new shell.
`C-a :screen mycmd` | Create a new window, running `mycmd` command inside.
`C-a ?`             | Help. List commands.
`C-a d`             | Detach current session.
`C-a r`             | Resume a detached session.

## Windows

Command                | Description
---------------------- | ---------------------------------------------
`C-a w`                | List windows in a session.
`C-a :windows`         | List windows in a session.
`C-a :windowlist`      | Display an interactive list of windows. Select window with arrows and return key. Move windows up and down inside the list with `.` and `,`.
`C-a N`                | Display current window's number.
`C-a :number`          | Display current window's number.
`C-a :number n`        | Change current window's number.
`C-a C-a`              | Switch to last window visited.
`C-a n`                | Switch to next window in list.
`C-a SPACE`            | Switch to next window in list.
`C-a p`                | Switch to previous window in list.
`C-a BACKSPACE`        | Switch to previous window in list.
`C-a NUMBER`           | Switch to the corresponding window. NUMBER must be between 0 and 9.
`C-a ' NAME OR NUMBER` | Switch to the corresponding window.
`C-a A`                | Rename current window.

## Bind keys

 * [Key Binding](http://web.mit.edu/gnu/doc/html/screen_13.html).

Key     | Description
------- | --------------------------
`C-a ?` | List all key bindings

```
bind j focus down
bind V screen vim $HOME/dev
bind W screen ssh galaxy@w4m
```
Then you type `C-a <key>`.

## Regions

Command     | Description
----------- | ----------------------------------------------------------------
`C-a S`     | Horizontal split.
`C-a |`     | Vertical split. Not enabled by default, see [Vertical split]().
`C-a X`     | Unsplit.
`C-a Q`     | Quit all regions but this one.
`C-a TAB`   | Go to next region (circle through regions).
`C-a j`     | Go to region at the bottom of the current region.
`C-a k`     | Go to region at the top of the current region.
`C-a h`     | Go to region at the left of the current region.
`C-a l`     | Go to region at the right of the current region.

### Resizing a region

`C-a :resize [-l] [-h] [-v] <amount>`

Flag | Description
---- | ----------------------------
`-l` | Resize is local to slice.
`-h` | Resize horizontally.
`-v` | Resize vertically.

The amount can be expressed in various forms:

Amount | Description
------ | -------------------------
10     | Resize to size 10.
+10    | Make 10 bigger.
-10    | Make 10 smaller.
10%    | Make it 10% of all.
=      | Make all windows equal.


### Vertical split

To get vertical split, you need to install current version:
```bash
git clone git://git.savannah.gnu.org/screen.git
```
GNU Screen 4.1 release should include vertical split.

### Layouts

A layout stores the current arrangement of regions.

Command                | Description                                           
---------------------- | ------------------------------------------------------
`layout save Desktop1` | Will save the current setup under the name "Desktop1". If you detach and reattach later on, the layout will automatically be restored. "Desktop1" will become the current layout.
`layout autosave off`  | This turns the autosave feature off. Layouts are automatically saved if autosave is on and the user detaches or switches to another layout.
`layout new Desktop2`  | Create a new empty layout named "Desktop2".
`layout next`          | Load the next layout. 
`layout prev`          | Load the previous layout.
`layout load "name"`   | Load the layout named "name".
`layout attach "name"` | Set the layout used when somebody is attaching. Default is ":last", this is the layout that was current when the last detach was done.

Besides the restoring of the screen on re-attach, layouts can be used to implement a kind of "virtual desktop" in screen. Say you put "layout save Desktop1" in your ~/.screenrc. If you need a new Desktop, do "C-a:layout new Desktop2". You can then use "layout next" to switch between both layouts.

## Editor / Copy mode

The editor is a vi-like editor in which you can move, copy and search.

Command   | Description
--------- | --------------
`C-a [`   | Enter copy mode.
`C-a ESC` | Enter copy mode.
`ESC`     | Exit copy mode.
`:`       | Exit copy mode.
`/`       | Search forward.
`?`       | Search backward.
`space`   | Start/end copy selection.
`C-a ]`   | Paste.

## Errors

### logging error

	/var/run/utmp: No such file or directory

Run screen with `-ln` option, which turns off login, or use `deflogin off` command inside `.screenrc`.
