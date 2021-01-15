<!-- vimvars: b:markdown_embedded_syntax={'dosbatch':''} -->
# Engineering

## Life cycle

pre-alpha: still in development.
alpha: not all features included. Not fully tested by developers.
beta: all features included, but contains bugs.
gamma: last version before release.

## NEWS file

What to put inside a NEWS file (or CHANGELOG file?) and how to present it.

```
CHANGES IN VERSION 1.3.4
------------------------

BUG FIXES

  * blablabla...
  * blablabla...
  * blablabla...

NEW FEATURES

  * blablabla...
  * blablabla...

DEPRECATION ANNOUNCEMENT

  * blablabla...
  * blablabla...

USER SIGNIFICANT CHANGES

  * blablabla...
  * blablabla...
```

## Deployment

### Building a .dmg for macos

 * [How do I create a DMG file on linux Ubuntu for MacOS](https://askubuntu.com/questions/1117461/how-do-i-create-a-dmg-file-on-linux-ubuntu-for-macos).

### Packaging a Java application for macos

 * [Bringing your Java Application to Mac OS X Part Three](https://www.oracle.com/technical-resources/articles/javase/javatomac3.html).

Packaging a script can be made with just the script:
 * Create the app folder using the name of your script: `MyScript.app`.
 * Then inside this folder put your script and name it `MyScript`, without any extension.
 * The script must have a shebang.
 * The script must be made executable for everyone.
 * Folder and all files inside, must have ownership set to `root:wheel`.

### MSI Packager

 * [MSI Packager](https://github.com/mmckegg/msi-packager).

Relies on `msitools`.

### msitools

Gnome package to build or access MSI packages.

 * [msitools](https://wiki.gnome.org/msitools).

### NSIS software installer

 * [Nullsoft Scriptable Install System](https://nsis.sourceforge.io/)
 * [Java Launcher with automatic JRE installation](https://nsis.sourceforge.io/Java_Launcher_with_automatic_JRE_installation).
 * [A simple installer with start menu shortcut and uninstaller](https://nsis.sourceforge.io/A_simple_installer_with_start_menu_shortcut_and_uninstaller).

For creating installers for Windows.
Only works on Windows.
Successfully installed with *wine*.

Run command line:
```dosbatch
makensis script.nsi
```

By default `makensis` change current directory to its installation directory. To disable this feature use `/NOCD` flag:
```dosbatch
makensis /NOCD script.nsi
```
