<!-- vimvars: b:markdown_embedded_syntax={'dosbatch':''} -->
# Engineering

## Deployment

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
