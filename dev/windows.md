<!-- vimvars: b:markdown_embedded_syntax={'sh':'','dosbatch':''} -->

# Windows

 * [Windows 10 ISO download](https://www.microsoft.com/en-us/software-download/windows10ISO).

## PowerShell

Install appx package from command line:
```
Add-AppxPackage -Path path/to/my/package.appx
```

## msiexec

To install an MSI as an administrator:
```dosbatch
runas /user:admin "msiexec -i \"my_application.msi\""
```

## Remote access

### winrm

Start Windows Remote Management service.
Start CMD as administrator.
```dosbatch
winrm quickconfig
```
then answer yes each time.

### VNC

RealVNC: seems the best, works good. Free version and fast - http://www.realvnc.com/

UltraVNC: can't make it work. Problem of password setting. Works only on Windows but clients in java for Linux and MacOS are available - http://www.uvnc.com/

TightVNC: Too much slow. License GNU, Windows, Linux - http://www.tightvnc.com/

## Automatic login (Windows XP ?)

1) Go to the Start Menu and the Run box (or type Win+R)

2) Type in the following:

control userpasswords2

now click OK

3) In the new Windows that appears select the account you wish to make the primary logon.

Now uncheck the "Users must enter a username and password..." box.

4) Hit Apply and a dialog box will appear asking you to confirm the selected users password.

Click OK when you are done!

## Control panel

To start control panel as a administrator:
```dosbatch
runas /u:admin "control appwiz.cpl"
```

Control panel                | Command
---------------------------- | ---------------------------------------------------------------------
Accessibility Options        | control access.cpl
Add New Hardware             | control sysdm.cpl add new hardware
Add/Remove Programs          | control appwiz.cpl
Date/Time Properties         | control timedate.cpl
Display Properties           | control desk.cpl
FindFast                     | control findfast.cpl
Fonts Folder                 | control fonts
Internet Properties          | control inetcpl.cpl
Joystick Properties          | control joy.cpl
Keyboard Properties          | control main.cpl keyboard
Microsoft Exchange           | control mlcfg32.cpl
  (or Windows Messaging)     |
Microsoft Mail Post Office   | control wgpocpl.cpl
Modem Properties             | control modem.cpl
Mouse Properties             | control main.cpl
Multimedia Properties        | control mmsys.cpl
Network Properties           | control netcpl.cpl NOTE: In Windows NT 4.0, Network properties is Ncpa.cpl, not Netcpl.cpl
Password Properties          | control password.cpl
PC Card                      | control main.cpl pc card (PCMCIA)
Power Management (Windows 95)| control main.cpl power
Power Management (Windows 98)| control powercfg.cpl
Printers Folder              | control printers
Regional Settings            | control intl.cpl
Scanners and Cameras         | control sticpl.cpl
Sound Properties             | control mmsys.cpl sounds
System Properties            | control sysdm.cpl

## Windows Subsystem for Linux

 * [How to install Linux distros properly on Windows 10](https://www.windowscentral.com/how-install-linux-distros-windows-10).
 * [How to Uninstall and Reset Windows Subsystem for Linux Distributions](https://www.petri.com/how-to-uninstall-and-reset-windows-subsystem-for-linux-distributions).
 * [Manually download Windows Subsystem for Linux distro packages](https://docs.microsoft.com/en-us/windows/wsl/install-manual).

To enable WSL: Settings -> Applications -> Apps & features -> Programs and Features (on the right) -> Turn Windows features on or off -> Windows Subsystem for Linux (Beta) (check)

See <https://docs.microsoft.com/en-us/windows/wsl/install-manual> for a list of available Linux distributions.
From Powershell, download your distribution:
```dosbatch
Invoke-WebRequest -Uri https://aka.ms/wsl-debian-gnulinux -OutFile debian.appx -UseBasicParsing
```
Or use curl:
```dosbatch
curl.exe -L -o debian.appx https://aka.ms/wsl-debian-gnulinux
```

Install the distribution from Powershell:
```dosbatch
Add-AppxPackage .\debian.appx
```
Then go to the Windows programs and run "Debian GNU/Linux".

## Cygwin

 * [Cygwin](http://www.cygwin.com/).

### Installation

Create `c:\cygwin` directory.

Download `setup.exe` and copy it into `c:\cygwin`.

run `setup.exe`.

choose packages:
	Devel -> cvs
	Net -> open-ssh

### cygpath

Transform cygwin path into Windows path and vice-versa.

Convert a UNIX path into a DOS path:
```sh
cygpath -d <unixpath>
```

Convert a UNIX path into a DOS path, but keeping regular slashes (/):
```sh
cygpath -dm <unixpath>
```

### unix2dos

Converts UNIX text files to DOS format.
`dos2unix` does the reverse.

### find

`find` has a homonym under Windows which is an equivalent of UNIX `grep`:
```dosbatch
C:\Windows\System32\find
```

### sshd (SSH server)

See file `/usr/share/doc/Cygwin/openssh.README`.

All users must have passwords in order to use sshd.

Control Panel --> System and Security --> System --> Advanced system settings --> Environment Variables..
Add new system variable : 
CYGWIN=ntsec
Edit PATH system variable : 
Add  ;c:\cygwin\bin at the end.

In a cygwin bash shell :
```sh
ssh-host-config
```
 * When the script asks you about "privilege separation", answer yes
 * When the script asks about "create local user sshd", answer yes
 * When the script asks you about "install sshd as a service", answer yes
 * When the script asks you for "CYGWIN="     your answer is ntsec
 * On Windows 7 (or other advanced OS version), it will ask to create a new privileged user named cyg_server.

Start ssh daemon:
```sh
net start sshd 
```
or
```sh
cygrunsrv  --start  sshd
```

```sh
mkpasswd   --local   >   /etc/passwd
mkgroup   --local    >   /etc/group
```

Windows XP SP2 : open the Windows Firewall to allow TCP port 22 through.

To stop or remove the service:
```sh
cygrunsrv  --stop  sshd
cygrunsrv  --remove sshd
```

Allow connection to port 22 in Firewall settings.

If sshd does not want to start as a service, you can run it by hand (or start it each time from your .bash_profile and run a bash automatically each time you log into Windows):
```sh
/usr/sbin/sshd
```

If you meet the following error :
	/var/empty must be owned by root and not group or world-writable
then be sure to chown /var/empty to the user name under which you're logged in :
```sh
chown pierrick /var/empty
```

### X11

install package X11 -> xinit.

run:
```sh
startxwin       # multiwindow mode
startx          # windowed mode
```

### Maximum memory

Increase memory maximum :
 1. Go to the registry (run regedit), and in `HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\`
 2. Create a new DWORD value there called `heap_chunk_in_mb` and set it to the amount of memory you want (in Mb).

```sh
regtool -i set /HKLM/Software/Cygnus\ Solutions/Cygwin/heap_chunk_in_mb 1024
regtool -v list /HKLM/Software/Cygnus\ Solutions/Cygwin
```

## MingW-MSYS

Répertoires cachés:
	/c			# pour accéder au disque C:
	/usr
	/mingw

For installing, run `mingw-get-inst` and choose:
 * C++ compiler
 * MinGW Developer Toolkit

Shell: Start -> All Programs -> MinGW -> MinGW Shell

To install packages from the shell, do normally as under Linux:
```sh
./configure && make && make install
```

## Qwerty (Windows XP ?)

Pour passer de qwerty en azerty et vice-versa : Alt + Shift

## System

### runas

To start a command as another user:
```dosbatch
runas /user:<user_login> cmd
runas /u:<user_login> cmd
```

### find

`find` is a *grep* tool:
```dosbatch
FIND "sometext" [some drive or files]
```

### 64bit

La présence du dossier C:\Program Files(x86) est caractéristique d'un système 64 bit.

On peut aussi vérifier en ouvrant le panneau Système dans le panneau de configuration, dans lequel on devrait trouver la ligne:
Type du système:				Système d'exploitation 64 bits.

Les variables d'environnement suivantes peuvent être utilisées pour différencier 32 et 64 bits:
Environment Variable		32bit Native		64bit Native		WOW64
PROCESSOR_ARCHITECTURE	x86	            AMD64	          x86
PROCESSOR_ARCHITEW6432	undefined	      undefined	      AMD64

### MBR

tool: `fixmbr`.
equivalent to old `fdisk /mbr`.

How to rewrite MBR for booting windows and Wubi/Linux:
 * Run Ubuntu from Live CD
 * Install lilo package
 * sudo lilo -M /dev/sda mbr
 * shutdown computer
 * start computer

### Shutdown & reboot

Windows NT:
 * `shutdown`
  - /R      reboot
  - /T:n    wait n seconds

Windows 2000:
 * `shutdown`
  - -r  reboot
  - -s  shutdown
  - -f  force shutdown

### Virtual memory

Performance issue, system Cache too high.

Under XP:
Control Panel -> System -> Advanced -> Performance / Settings -> Advanced -> Virtual Memory / Change -> System managed size.

### NTFS

Pour convertir un système FAT32 en NTFS :
convert D: /FS:NTFS /V

Pour C: faire attention aux questions posées, il faut :
	_ répondre NON à la question du démontage du disque
	_ répondre OUI lorsqu'il demande d'effectuer la conversion au redémarrage

### Powertoys for WinXP

http://www.microsoft.com/windowsxp/downloads/powertoys/xppowertoys.mspx

A set of small software made by third party people (non-MS):
_ Power Calculator
_ Virtual Desktop Manager

## Network

## ipconfig

To get a list of all network cards:
```dosbatch
ipconfig /all
```

## Host files

`C:\Windows\System32\drivers\etc\hosts`.
--> Pour l'éditer il faut lancer le NotePad en mode administrateur :
Démarrer --> Tous les programmes --> Accessoires --> Block-notes, clique droit puis Exécuter en tant qu'adiministrateur.

### PuTTY (telnet ssh client)

Download `putty-*-installer.exe` from <http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html>.
Run PuTTYgen, and generate rsa2 private/public keys. Save them inside the directory of your choice.
Send the public key to the server. If it runs OpenSSH, copy the public key to .ssh/authorized keys with the following format:
ssh-rsa <key> user@remote-machine
To avoid specifying the private key each time on PuTTY, use Pageant:
 1. Start Pageant. It does nothing except running in the System Tray.
 2. Click on the icon in the System Tray. Add your private key. Close.
 3. Now run PuTTY and connect to the server.

### Allow ping

Control panel --> System and Security --> Windows Firewall --> Advanced setting --> Inbound Rules --> New Rule...
        Custom --> Next --> All programs --> Next --> Next --> Next --> Allow the connection --> Next --> Domain, Private, Public --> Next
        Name = ICMP echo requests (ping) --> Finish

For allowing connection to SSH server, create a rule with :
    _ Protocol type: TCP
    _ Specific ports: 22

## ISO files

Creating an ISO from a DVD.
Download dd version for Windows at <http://www.chrysocome.net/>.

Get the list of Windows devices:
```sh
./dd-0.5/dd --list
```

make the iso file:
```sh
./dd-0.5/dd if=\\.\Volume{c18588c0-02e9-11d8-853f-00902758442b} of=c:\temp\usb1.img bs=1M --progress
```

## Bugs and system failures

### Debugging minidump files

Minidump files are small memory dump files that records the smallest set of useful information that may help identify why your computer has stopped unexpectedly.

File to download and install : `winsdk_web.exe` (requires .NET Framework 4).
`Dumpchk.exe` (Dump Check Utility) is used to read minidump files (small memory dump files).

### When BLUE SCREEN disappears too quickly

   1. Go to Start -> Control Panel -> System
   2. Go to Advanced
   3. Under the Startup and Recovery section, click Settings...
   4. Under System Failure un-check "Automatically restart"

### Device error when installing

ERROR MESSAGE:
```
Installer Information
The system cannot open the device or file specified.
```

SOLUTION:
Check the permission of the installer file (.msi):
right-click on file --> properties --> Security --> Edit
Remove all users/groups except yourself.
Add group "Administrators".
Set permissions to "Full control" for yourself and the Administrators group.

OTHER POSSIBLE SOLUTIONS:
Check that %TEMP% directory doesn't use encryption:
right-click --> General --> Advanced... --> Encrypt contents to secure data.

### Blue screen on Tanya's Toshiba computer

Blue screen:
```
DRIVER_IRQL_NOT_LESS_OR_EQUAL

w22n51.sys
```

It seems (according to some Internet forums) that the culprit comes from the driver of the wireless card "Intel(R) PRO/Wireless 2200BG Netw".
Installed version on Tanya's computer is 8.0.12.9000 dated from 02 January 2004.

--> driver problem detected by Windows after installing Microsoft Updarte, crashing again and then sending report. Driver updated on Intel website link given by Microsoft.
