<!-- vimvars: b:markdown_embedded_syntax={'sh':'bash','bash':'','r':'','hog':''} -->
# UNIX

These notes refer to UNIX and Linux operating systems.

 * [LSB (Linux Standard Base)](https://en.wikipedia.org/wiki/Linux_Standard_Base).
 * [POSIX (Portable Operating System Interface)](https://en.wikipedia.org/wiki/POSIX).
 * [Debian](https://www.debian.org).
 * [CentOS](https://www.centos.org).
 * [Arch Linux](https://www.archlinux.org/).

## System

### Installing

#### ArchLinux

 * [How to install Arch Linux on VirtualBox](https://www.howtoforge.com/tutorial/install-arch-linux-on-virtualbox/).
 * [How to Install Arch Linux (also on VirtualBox)](https://medium.com/@gevorggalstyan/how-to-install-arch-linux-on-virtualbox-93bc83ded692).
 * [Installation guide](https://wiki.archlinux.org/index.php/Installation_guide).
 * [Install Arch Linux in Virtualbox with UEFI Firmware](https://www.linuxbabe.com/virtualbox/install-arch-linux-uefi-hardware-virtualbox).

In VirtualBox with EFI:

 * Enable EFI in VirtualBox VM: Settings -> System -> Enable EFI.
 * Boot on ArchLinux ISO CD install.
```bash
fdisk -l # Look for the device name of the harddrive (should be `/dev/sda`).
fdisk /dev/sda # Make 3 partitions:
  # Press `g` for creating a GPT partition
  # /dev/sda1: EFI System (type 1), 512MB
  # /dev/sda2: Linux filesystem (type 20)
  # /dev/sda3: Linux swap (type 19)
  # Press `w` to write partition table.
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkswap /dev/sda3
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
swapon /dev/sda3
vi /etc/pacman.d/mirrorlist
pacstrap /mnt base linux linux-... # see ArchLinux installation
genfstab -U -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
vi /etc/locale.gen
echo LANG=en_IE.UTF-8 > /etc/locale.conf
locale-gen
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
echo "archlinux.host.local" > /etc/hostname
passwd # Define root password
systemctl enable dhcpcd
UUID=$(blkid /dev/sda2 | sed 's/^.*PARTUUID="\(.*\)"$/\1/') # Get Linux disk UUID

 # EFI boot, see https://wiki.archlinux.org/index.php/EFISTUB
echo "\\vmlinuz-linux root=PARTUUID=$UUID rw initrd=\\initramfs-linux.img" >/boot/archlinux.nsh # Write script for booting from EFI shell.
cp /boot/archlinux.nsh /boot/startup.nsh

 # For booting on LVM ? Is bootloader like GRUB necessary ?

exit
reboot
```

#### OS X

 * [How to reinstall macOS](https://support.apple.com/en-us/HT204904).
 * [Create a bootable USB stick on macOS](https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-macos?_ga=2.233519964.315784058.1525944550-1342623189.1521968110#0).
 * [Radeon kernel modesetting for r600 or later requires firmware-amd-graphics](https://joshtronic.com/2017/11/06/fixed-radeon-kernel-modesetting-for-r600-or-later-requires-firmware-amd-graphics/).

To upgrade to macOS High Sierra on a computer running with mac OS X Lion, one must first upgrade to OS X El Capitan. Use this [link](https://support.apple.com/en-us/HT206886) to download OS X El Capitan.

### Booting, starting and stoping

Putting a machine to sleep in Debian:
```bash
systemctl suspend
```

Shutdown an Alpine machine:
```bash
poweroff
```
Other commands: `reboot` and `halt`.

Display boot menu on macmini 2,1 : press `Alt` when starting computer.

### dmesg

Display kernel ring buffer.

#### macos

 * [Mac startup key combinations](https://support.apple.com/en-us/HT201255).

macOS boot key combinations:

Command         | Description
--------------- | ------------------------------------------
Cmd-R           | Recovery mode.
Alt-Cmd-R       | Install latest macOS or macOS that came with the Mac, depending on current OS version.
Shift-Alt-Cmd-R | Install latest macOS or macOS that came with the Mac, depending on current OS version.
C               | Boot on DVD or USB device.
D or Alt-D      | Run hardware tests.
Alt             | Display possible boot devices.
Eject key       | Eject optical media.
Cmd+V           | Boot in verbose mode.
 
To always boot in verbose mode on macos:
```bash
sudo /usr/sbin/nvram boot-args="-v"
```

To boot in console mode on macos, edit file /etc/ttys and find the lines:
```
 #console        "/usr/libexec/getty std.9600"   vt100   on secure
Console "/System/Library/CoreServices/loginwindow.app/Contents/MacOS/loginwindow"
```

Preventing system sleep on macOS:
```bash
caffeinate -i myprog
```
Or by using PID:
```bash
caffeinate -i -w 4521
```

Shutdown a macOS machine:
```bash
shutdown -h now
```

To boot in 32 bit mode:
```bash
sudo systemsetup -setkernelbootarchitecture i386
```
To get back to 64 bits, replace `i386` by `x86_64`.
Or press keys 3 and 2 during startup for 32-bit or keys 6 and 4 for 64-bit.

To get boot architecture setting:
```bash
sudo systemsetup -getkernelbootarchitecturesetting
```

#### macos login window

Set login window message:
```bash
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Hello There"
```

Hide accounts:
```bash
sudo defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add shortname1 shortname2 shortname3
```

Show all accounts:
```bash
sudo defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add
```

Changing Apple logo. Be careful to back up the original file before. The tiff image must be 90x90:
```
/System/Library/CoreServices/SecurityAgent.app/Contents/Resources/applelogo.tif
```

### OS info

Get OS type:
```bash
uname
```
Returns `"Darwin"`, `"Linux"`, etc.

Get system info (OS type, machine name, etc):
```bash
uname -a
```

Get Ubuntu version:
```bash
lsb_release -a
```

Get system information on Ubuntu:
```bash
sudo lshw
sudo lshw -C network # Filter on network components
```

Get CPU exact description on macos:
```bash
sysctl -n machdep.cpu.brand_string
```

### Processes

#### top

#### htop

 * [Understanding and using htop to monitor system resources](https://www.deonsworld.co.za/2012/12/20/understanding-and-using-htop-monitor-system-resources/).

A top app with %CPU for each core and colors.

#### ps

List every process (standard syntax):
```bash
ps -e
ps -ef # + user, full path
ps -eF # + user, fullpath, memory size
ps -ely
```

List every process (BSD syntax):
```bash
ps ax
```
Option          | Description
--------------- | ----------------------------------------------------
 -a             | Display also processes of all users.
 -x             | display also processes which do not have a controlling terminal.
 -U username    | Display the processes owned by the specified user.

For monitoring memory usage of processes:
```bash
while true ; do ps -o %mem,rss,sz,vsize,fname ; sleep 1 ; done
```

#### kill

Send a signal to a process by name or number:
```bash
kill -HUP 12648
kill -HUP myproc
```
#### pkill

Send signal to processes by name.
Portable?

Use regexpattern by default:
```bash
pkill -HUP [sn]mbd
```

#### killall

Send signal to processes by name.
Not portable.

Fix string:
```bash
killall -HUP myprocess
```

Regex:
```bash
killall -r -HUP 'myproc[0-9]*'
```

### Machine name

Under macOS, to set the name of a machine, run:
```bash
sudo scutil --set HostName lucy
sudo scutil --set LocalHostName lucy
sudo scutil --set ComputerName lucy
```

### Run levels

 * [Run levels](http://www.tldp.org/LDP/sag/html/run-levels-intro.html).

To get current level:
```bash
runlevel
```

Change run level:
```bash
init 5
```

The booting run level is defined inside the file `/etc/inittab`.

Services starting scripts are located inside `/etc/rc.d/init.d`.
They are run according to the runlevel. A symbolic is created inside the relevant runlevel folder for a service that we want to stop or start.
The runlevel folder is of the form `/etc/rc.d/rc?.d`, where `?` is replaced the runlevel number.
The name of the symbolic link begin by `K` for stopping the service and `S` for starting it, and is followed by a number. The number allows to sort the services in the order we want them to stop or to start.

LOGIN

Remove login manager:
```bash
update-rc.d -f gdm remove
```

Restore login manager:
```bash
update-rc.d -f gdm defaults
```


### Users and groups

Create new user with specific UID on BSD:
```bash
sudo adduser -u 1200 myuser
```

Create new user on GNU/Linux:
```bash
sudo useradd ...
```

Add a user to sudoers group:
```bash
sudo adduser myuser sudo
```

Add a user to a group in Linux:
```bash
usermod -a -G somegroup someuser
```

Get user UID and all groups to which he belongs:
```bash
id
```

### macos dscl

Command line tool to manage directory services (including NFS).
It replaces nicl command.

List users:
```bash
dscl . -list /Users
```

Read information about a user:
```bash
dscl . -read /Users/pierrick
```

Search for user with uid <uid>:
```bash
dscl . -search /Users uid <uid>
```

Create a new user:
```bash
sudo mkdir /Users/toto
sudo dscl . -create /Users/toto
sudo dscl . -append /Users/toto RealName "Mr. Toto"
sudo dscl . -append /Users/toto PrimaryGroupID 103
sudo dscl . -append /Users/toto UniqueID 512
sudo dscl . -append /Users/toto NFSHomeDirectory /Users/toto
sudo dscl . -append /Users/toto UserShell /bin/bash
sudo dscl . -passwd /Users/toto "tata"
sudo chown -R toto:titi
```
taken from a shell script:
```bash
sudo $dscl . -create "/Users/$new_user"
sudo $dscl . -append "/Users/$new_user" RealName "$firstname $lastname"
sudo $dscl . -append "/Users/$new_user" NFSHomeDirectory "/Users/$new_user"
sudo $dscl . -append "/Users/$new_user" UserShell /bin/bash   
sudo $dscl . -append "/Users/$new_user" PrimaryGroupID $new_gid
sudo $dscl . -append "/Users/$new_user" UniqueID $new_uid
sudo $dscl . -append "/Users/$new_user" hint ""
sudo $dscl . -append "/Users/$new_user" comment "user account \"$firstname $lastname\" created: $(/bin/date)"
sudo $dscl . -append "/Users/$new_user" picture "/Library/User Pictures/Animals/Butterfly.tif"
sudo $dscl . -append "/Users/$new_user" sharedDir Public
sudo $dscl . -passwd "/Users/$new_user" "$passwd1"
```

### macos dseditgroup

Edit groups in the Directory Service:
```bash
dseditgroup -o edit -p -a <username> -t user <group_name> 
```
-u : specify admin-user login
-p : prompt for admin-user password

Create a group:
```bash
dseditgroup -p -o create Dev
```

Add a user to a group:
```bash
dseditgroup -p -o edit -a pierrick -t user Dev
```

### macos environment variables

`~/.MacOSX/environment.plist` file is for defining ENV VARS for the session.
A MacOS-X application won't see ENV VARS defined from the terminal if run from the Windows Manager.
See <Https://developer.apple.com/library/mac/#documentation/MacOSX/Conceptual/BPRuntimeConfig/Articles/EnvironmentVars.html>.

### Hardware

Get list of PCI devides in Debian:
```bash
lspci
```

Get list of USB devices in Debian:
```bash
lsusb
```

 * [Use Apple’s USB SuperDrive with Linux](https://cmos.blog/use-apples-usb-superdrive-with-linux/).
 * [Use Apple’s USB SuperDrive with Linux](https://christianmoser.me/use-apples-usb-superdrive-with-linux/).
 * [Using Apple’s SuperDrive on Linux](https://kuziel.nz/notes/2018/02/apple-superdrive-linux.html)

To enable (wake up) Apple Super Drive, install sg3-utils (`sg3_utils` on ArchLinux) package and check which device is your drive (`/dev/sr0` or `/dev/sr1` usually). Then run:
```sh
sg_raw /dev/sr0 EA 00 00 00 00 00 01
```

To make it automatic, create the file `/etc/udev/rules.d/60-apple-superdrive.rules` as root with the following content:
```hog
# Apple's USB SuperDrive
ACTION=="add", ATTRS{idProduct}=="1500", ATTRS{idVendor}=="05ac", DRIVERS=="usb", RUN+="/usr/bin/sg_raw /dev/$kernel EA 00 00 00 00 00 01"
```

#### macos optical disk handling

To make a disk image from an optical disk:
	Open "Applications->Utilities->Disk Utility"
	Then select the disk and click on "New Image".
	Select "DVD/CD master" in order to create an ISO/CDR file, or "read-only" or "compressed" to create a dmg file.

To convert a dmg to an iso:
```bash
hdiutil convert /path/to/filename.dmg -format UDTO -o /path/to/savefile.iso
```

To convert a cdr (CD/DVD Master) to an iso:
```bash
hdiutil makehybrid -iso -joliet -o CLIMB_APP.iso CLIMB_APP.cdr
```

To unmount a disk:
```bash
diskutil umount <disk name>
```

To eject optical disk:
```bash
drutil eject
```

#### Display

 * Control the screen brightness on Linux: [Backlight](https://wiki.archlinux.org/index.php/backlight).

After install Debian on an iMac 27'', I had to turn off ACPI backlight in the kernel in order to get control of the screen brightness:
```
acpi_backlight=none
```
See [Kernel parameters](https://wiki.archlinux.org/index.php/Kernel_parameters) for setting kernel parameters at boot time.

#### iPad/iPhone

##### Charging

For charging an iPad under Linux, see [Charge iPad / iPhone 4s / iPod Touch in Ubuntu](http://ubuntuguide.net/charge-ipad-iphone-4s-ipod-touch-in-ubuntu).
Under Ubuntu:
```bash
sudo apt-get install libusb-1.0-0 libusb-1.0-0-dev git git-core
git clone https://github.com/mkorenkov/ipad_charge.git
cd ipad_charge
make
sudo make install
```

Then to start charging connected devices:
```bash
ipad_charge
```

And to stop charging connected devices:
```bash
ipad_charge -0
```

#### Keyboard

 * [Configure Apple keyboard under Debian](https://wiki.debian.org/MacBook#Keyboard).
 * [Compose key](https://en.wikipedia.org/wiki/Compose_key).

The ~/.XCompose file list user configuration for key combination. See `man compose`.

To see current keyboard configuration under Ubuntu:
```bash
localectl status
```

To configure the keyboard for the session only, run:
```bash
sudo loadkeys us
```
or for French AZERTY keyboard:
```bash
sudo loadkeys fr
```

To configure keyboard permanently under CentOS:
```bash
sudo system-config-keyboard
```

To configure keyboard permanently under Ubuntu, it will open an X window:
```bash
sudo dpkg-reconfigure keyboard-configuration 
```
Under Ubuntu, to configure permanently from command line, and make it also available at boot time (i.e.: at login console), edit the file `/etc/rc.local` and put the line `loadkeys fr` just before the line `exit 0`. `fr` is for french keyboard layout, replace it with whatever keyboard layout you want.

### Services

List all services under Ubuntu:
```bash
service --status-all
```

List services under macOS:
```bash
launchctl list
```

Sart a service under macOS:
```bash
Launchctl start org.postfix.master
```

Stop a service under macOS:
```bash
Launchctl stop org.postfix.master
```

#### systemd

 * [systemd](https://wiki.archlinux.org/index.php/Systemd).

`systemd` configuration for power management is stored in `/etc/systemd/logind.conf`.
It handles how to react when system is idle, and when power/sleep/hibernate button is pressed, or when laptop lid is closed.

See man page `logind.conf`.

In `/etc/systemd/sleep.conf` is enabled or disabled suspend, hibernate and other hydrid modes.

See man page `systemd-sleep.conf`.

#### systemctl

Enable a service with systemd (ArchLinux, ...) for starting on bootup:
```bash
systemctl enable myunit
```

For user services:
```bash
systemctl --user enable myunit
```

Enable and start now:
```bash
systemctl enable --now myunit
```

List services:
```bash
systemctl list-units
```

Deactivate a service (stop it):
```bash
systemctl stop myunit
```

#### journalctl

Print system logs:
```sh
journalctl
```

### macos Finder

Show all files and directories:
```bash
Defaults write com.apple.Finder AppleShowAllFiles YES
```

To change a folder icon:
Edit an icon with gimp, making its background transparent.
Maximum size must be 255x255 or the icon will not be clickable (only the folder title will be clickable).
Copy the image from gimp.
Open information panel of the folder (cmd-i), click once on the icon in top/left corner of the information window. Paste (cmd-v) the image.

Set hidden attribute:
```bash
sudo SetFile -a "v" /private # Show '/private' in the Finder.app
sudo SetFile -a "V" /private # Hide '/private' from the Finder.app
```

### locale

Display current locale:
```bash
locale
```

Display available locales:
```bash
locale -a
```

Add a new locale:
```bash
locale-gen fr_FR.UTF-8
```

### Virtual consoles

Is possible to open additional consoles with Ctrl+Alt+F?. On archlinux, F1 to F6 are available.
Still under Archlinux, it seems also to work when X is started on one of the consoles.

### /proc

Get wifi link quality:
```sh
cat /proc/net/wireless
```

### lspci

List PCI devices.

Get wifi cards:
```sh
lspci | egrep -i 'wifi|broadcon|wlan|wireless'
```

Get card information:
```sh
lspci -vv -s 02:00.0 # card index 02:00.0
```

## Printing

### lp

Print files to default printer (`PRINTER` env var):
```sh
lp myfile.ps
```

### lpinfo (CUPS)

List printer devices:
```sh
lpinfo -v
```

List printer models:
```sh
lpinfo -m
```

### lpadmin (CUPS)

Add a queue for a driverless (Apple AirPrint oo IPP Everywhere) printer:
```sh
lpadmin -p myqueue -E -v "ipp://my.ipp.printer/" -m everywhere
```

### a2ps

Transform ASCII/text files into post script files.

```bash
a2ps -4 -A fill file1.txt file2.txt file3.txt -o output.ps
```
	-4 :		4 pages virtuelles par page
	-A fill :	mettre les fichiers les uns à la suite des autres sur une même page

To print a file with default printer:
```sh
a2ps <some_file.cpp
a2ps some_file.cpp some_other_file.cpp
```

To output to a file:
```sh
a2ps some_file.cpp -o output.ps
```

To print in portrait mode, on one column:
```sh
a2ps -R --columns=1 file.cpp
```

No headers:
```sh
a2ps -B ...
```

No border frame:
```sh
a2ps --borders=no ...
```

Enable colors:
```sh
a2ps --prologue=color ...
```

### CUPS

 * [Connecting Ubuntu client to Cups server](http://blog.delgurth.com/2009/01/06/connecting-ubuntu-client-to-cups-server/).

Install and start [Avahi](https://wiki.archlinux.org/index.php/Avahi#Hostname_resolution) for discovering printers automatically.

Start daemon:
```sh
systemctl enable --now org.cups.cupsd
```

## Network & web

 * ArchLinux [Network configuration](https://wiki.archlinux.org/index.php/Network_configuration).
 * ArchLinux network: [systemd-networkd](https://wiki.archlinux.org/index.php/Systemd-networkd).
 * ArchLinux [iPhone tethering](https://wiki.archlinux.org/index.php/IPhone_tethering).
 * [khal](http://lostpackets.de/khal/), CLI calendar program.
 * [khard](https://github.com/scheibler/khard/), CLI address book program.
 * [Vdirsyncer](https://github.com/pimutils/vdirsyncer), synchronizes your calendars and addressbooks between two storages.

The DNS address is stored inside `/etc/resolv.conf`.

### Avahi

 * [Avahi](https://wiki.archlinux.org/index.php/Avahi#Hostname_resolution).

Before enabling daemon you disable `systemd-resolved`:
```sh
systemctl disable systemd-resolved
systemctl enable --now avahi-daemon
```

### newsboat.

RSS Feed reader.

 * [Newsboat](https://newsboat.org/releases/2.12/docs/newsboat.html).

### canto

RSS Feed reader.

 * [Canto](https://codezen.org/canto-ng/manual/).

### lynx

 * [Lynx users guide](http://lynx.invisible-island.net/lynx_help/Lynx_users_guide.html).

Open page
```bash
lynx www.mypage.com
```
Or press "G" key inside lynx

Cmd | Desc.
--- | --------
a   | Add current page to bookmarks.
v   | View bookmarks.

Dump web page in text format:
```lynx
lynx -dump myfile.html
```
`-width=600` sets the number of columns to use (default 80, max 1024).
`-list_inline` writes the links inside the text at their place instead of writin them at the end of the output.

### links

 * [Links user manual](http://links.twibright.com/user_en.html).

### FortiClient SSLVPN

When connecting in VPN with FortiClient, the DNS is not set. The content of `/etc/resolv.conf` is:
```
awk: fatal: cannot open file `/opt/fortinet/forticlientsslvpn/./helper/pppd.log' for reading (Permission denied)
 # Generated by resolvconf
nameserver 172.20.10.1
```
The solution is to make the `pppd.log` file readable for anyone:
```bash
sudo chmod a+r /opt/fortinet/forticlientsslvpn/helper/pppd.log
```
and restart FortiClient.

### lsof

List processes that uses a port:
```bash
lsof -i:8080
```

### List network devices

`ifconfig` is deprecated. It has been replaced by `ip`.

To get a list of network devices:
```bash
ip link show
```

Get info on a card:
```bash
ethtool my_card_name
```

### curl

Download a file with ftp:
```bash
curl -o myfile.txt "ftp://mysite.fr/my/file.txt"
```

Follow page relocation:
```bash
curl -L -o myfile.txt "http://mysite.fr/my/file.txt"
```

### wget

Download recursively:
```bash
wget -r http://some.site.fr/
```

Resume a download:
```bash
wget -c http://some.site.fr/myfile.zip
```

Set file output:
```sh
wget -O myfile.html http://some.site.fr/some/page.html
```

```bash
wget -i blabla -o zop http://fsgjkbnkfjg.bgjnfdgb/dfbkjgn.xml
```

Quiet:
```bash
wget -q -O myfile.html http://some.site.fr/some/page.html
```

### mail

Read mail from system mailbox:
```bash
mail
```

Send a mail to the system:
```bash
mail -s "my_subject" user.name
```
and then type your message body and finish by `ctrl+d`, or
```bash
echo "my text" | mail -s "my_subject" user.name
```

### iw

Get card name:
```sh
iw dev | grep Interface
```

Get SSID:
```sh
iw dev | grep ssid
```

Get info on a card:
```sh
iw mycard info
```

### ifconfig

Get IP of a card:
```sh
ifconfig mycard
```

### NTP, Network Time Protocol

 * [NTP configuration on Debian](https://wiki.debian.org/NTP).

On Ubuntu, timesyncd is used by default. To configure it, see `/etc/systemd/timesyncd.conf`.
To check if timesyncd is on, run:
```bash
timedatectl
```
To set it on:
```bash
sudo timedatectl set-ntp on
```

### nmap

Check that a port is open:
```bash
nmap -p 8180 mymachine
```

### Firewall & ports

Get port rules:
```bash
sudo iptables -L
```

If `ufw` (firewall) is running:
```bash
sudo ufw status
```

Under macos 10, for listing the rules:
```bash
sudo pfctl -s rules
```

### offlineimap

 * [OfflineIMAP](https://wiki.archlinux.org/index.php/OfflineIMAP).

Synchronize locally with an IMAP account.

On Archlinux:
```sh
pacman -S offlineimap
```

Install on MacOS-X:
```sh
brew install offline-imap
```

 * [Folder filtering and Name translation](https://offlineimap.readthedocs.org/en/latest/nametrans.html).
 * [Use Mac OS X's Keychain for Password Retrieval in OfflineIMAP](https://blog.aedifice.org/2010/02/01/use-mac-os-xs-keychain-for-password-retrieval-in-offlineimap/).

Run manually:
```sh
offlineimap # For all default accounts.
offlineimap -a myaccount # For one specific account.
```

For running offlineimap as daemon under Ubuntu, see `/usr/share/doc/offlineimap/examples`.

For running offlineimap as daemon under Ubuntu, run as root:
```bash
cat >/etc/systemd/user/offlineimap.service <<EOF
[Unit]
Description=OfflineIMAP Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/offlineimap
EOF
cat >/etc/systemd/user/offlineimap.timer <<EOF
[Timer]
OnUnitInactiveSec=120s
Unit=offlineimap.service
EOF
chmod a+r /etc/systemd/user/offlineimap.*
```
Then as a user:
```bash
systemctl --user daemon-reload
systemctl --user start offlineimap.timer
systemctl --user start offlineimap.service
```
See [OfflineIMAP: Periodically fetch emails with systemd's timers](https://kdecherf.com/blog/2012/12/23/offlineimap-periodically-fetch-emails-with-systemds-timers/) and [Integrating OfflineIMAP into systemd](http://www.offlineimap.org/doc/contrib/systemd.html).

### msmtp

Mail sender program, able to handle multiple SMTP accounts.

Using from command line:
```bash
echo "some text" | msmtp [-a account] email@address
```

In Mutt:
```muttrc
set sendmail="/usr/local/bin/msmtp"	# for normal msmtp
```

Using queuing in Mutt:
```bash
mkdir $HOME/.msmtp.queue
```
And in Mutt:
```muttrc
set sendmail="/usr/local/bin/msmtpq"	# for queueing version
```
Queued messages are sent later on when sending another email, when connected.
It's also possible to force sending with the following command:
```bash
msmtp-queue -r
```
Which means it could be used inside a cron task.

#### macOS install

msmtp exists in brew, but it doesn't install queueing scripts. However they are present in '/usr/local/Cellar/msmtp/<version>/share/msmtp/scripts/msmtpq/'.

### rsync

Use verbose flag to print processed files:
```bash
rsync -v ...
```

Synchronizing deletion of files in the source:
```bash
rsync -avP --delete teddy:/home/data/documents .
```

Specify remote shell to use:
```bash
rsync -e ssh
```
or
```bash
export RSYNC_RSH=ssh
rsync ...
```
	
ERROR "rsync: failed to set times on":  add -O option, it tells rsync to omit directories when preserving times.
```bash
rsync -O ...
```
	
Compress:
```bash
rsync -z ...
```
	
Recurse in sub-directories:
```bash
rsync -r ...
```
	
Exclude files:
```bash
rsync --exclude '*~' ...
rsync --exlude '*~' --exlude '.DS_Store' --delete-excluded ... # also delete excluded files from dest dirs
rsync --exclude-from=FILE # read include patterns from FILE
```

To synchronize two directories:
```bash
rsync --delete /.../folder1/ /.../folder2
```
The slash at the end of the source path tells to synchronize all files, it makes --delete works for folder1.

Print the progress of transfer:
```bash
rsync --progress
```

Authorize partial transfer (keep partially transferred files):
```sh
rsync --partial
```
Or for enabling for --partial and --progress at the same time:
```sh
rsync -P
```

Regular sync (revursive, links, times), doesn't synchronize the permissions:
```bash
rsync -rlt ...
```

### ssh

Generate private and public keys:
```bash
ssh-keygen 
```

Login without password. In /etc/ssh/sshd_config:
```
RSAAuthentication yes
PubkeyAuthentication yes
```
Then:
```bash
ssh-copy-id -i ~/.ssh/id_dsa.pub username@remotebox
```

Using local tunneling for accessing mail server:
```bash
ssh -gNL 1993:imap.mail.me.com:993 server.addr
```
Local port used is 1993. Everything going to this local port will be forwarded to imap.mail.me.com:993 through server.addr:22.


#### Debugging

Turning on log output
```bash
lynx -trace ...
```
Log is written inside Lynx.trace file.

#### Config file

First lynx reads the common config file (On MacOS-X brew install: /usr/local/Cellar/lynx/2.8.8/etc/lynx.cfg)

Force cfg file
```bash
lynx -cfg my_file
```

#### Print configuration
```bash
lynx -show_cfg
```

Setting option value in config file:
```
character_set=utf-8
```
For a comment use #.

#### Key commands

Key       | Description
--------- | --------------------------------
`G`       | Open link.
`UP/DOWN` | Move up and down inside a page.
`LEFT`    | Back to previous page.
`RIGHT`   | Follow link.
`SPACE`   | Move down in a page.
`CTRL-R`  | Reload current page.

### w3m

Open a link:
```bash
w3m www.lemonde.fr
```

Cookie:
```bash
w3m -cookie ...
```
Don't work perfectly with cookies. Doesn't recognize/accept cookies of www.mediapart.fr for instance.

Commands:

Key      | Description
-------- | ----------------------------------------------------
`l`      | Cursor right.
`h`      | Cursor left. Cursor pad also works.
`j`      | Cursor down.
`k`      | Cursor up.
`SPC`    | Go forward one screen of page
`b`      | Go back one screen of page
`:`      | Toggle auto detection of URLs (http://...):
`B`      | Go backward (previous opened page)
`RET`    | Follow link.
`TAB`    | Next link.
`ESC TAB`| Previous link.

### vimb

Vim like browser.

bma | Add bookmark
bmr | Remove bookmark
y   | Yank current URI to clipboard
"xy | Yank current URI into register x

### Wake On LAN

On Debian, see [Set up Wake On LAN (WOL) on a Debian Server](https://www.lisenet.com/2013/set-up-wake-on-lan-wol-on-a-debian-wheezy-server/) or <https://wiki.debian.org/WakeOnLan>.

To see if a card has WOL enabled, run `ethtool`:
```bash
ethtool my_card_name
```
and look for the lines `Supports Wake-on: g` and `Wake-on: d`.

```bash
wakeonlan hardware_addr
```

### dhclient

Renew client lease on specific card:
```sh
dhclient -r enp2s0 # Revoke
dhclient enp2s0    # Obtain a new lease
```

### USB tethering & bluetooth (iPhone Hotspot)

 * [iPhone tethering](https://wiki.archlinux.org/index.php/IPhone_tethering).

List network devices:
```sh
networkctl list
```

Get the link name of the iPhone, and then create the `.network` file `/etc/systemd/network/30-tethering.network`:
```conf
[Match]
Name=enp0s26u1u2c4i2

[Network]
DHCP=yes
```

### Wifi

 * ArchLinux wifi: [WPA supplicant](https://wiki.archlinux.org/index.php/WPA_supplicant).

Monitor wifi signal quality:
```sh
wavemon
```

Start daemon:
```bash
sudo wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant-wlp2s0.conf
```

On ArchLinux with WPA supplicant:
```bash
sudo wpa_cli -i wlp2s0
```
Then:
```
scan
scan_results
list_networks # List networks already defined
add_network # Add a new network
set_network 1 ssid "mynetwork"
set_network 1 psk "mypassword"
list_networks
enable_network 1
save_config
```

Stop daemon:
```bash
sudo wpa_cli -i wlp2s0
```
Then:
```
terminate
```

Get wifi status on Debian:
```bash
nmcli radio wifi
```

Turn off wifi on Debian:
```bash
nmcli radio wifi off
```

Get help on Debian:
```bash
nmcli radio wifi help
```

### msgconvert

Convert Outlook `.msg` message file into `.eml`.

To install on Archlinux:
```sh
yay -S aur/perl-email-outlook-message
```

To convert a message:
```sh
msgconvert mymessage.eml
```

### mpack

Installing on Archlinux:
```sh
yay -S aur/mpack
```

`munpack` extract attachments from `.eml` file:
```sh
munpack mymessage.eml
```

## Misc

### cal

Display a calendar.

```bash
cal 12 2019
```

### date

Convert a date to Epoch time:
```bash
date -j '01171200' +%s # BSD
```

Flag        | Description
----------- | -----------------------
`-j`        | Do not try to set date.
`-f '...'`  | set another format for input date. Default is [[[mm]dd]HH]MM[[cc]yy][.ss] (mm=month, cc=century).

Get date of yesterday formatted:
```bash
date -d yesterday +%Y-%m-%d
```

### wego

 * [wego](https://github.com/schachmat/wego).
 * [wttr.in](https://github.com/chubin/wttr.in).

`wego` is a weather client for the terminal.

The website wttr.in uses wego to display a weather report in text mode:
```sh
curl wttr.in
```

## Password managers

 * [pwsafe](https://github.com/nsd20463/pwsafe). Works in command line.

 * `keepass` password manager. Has an interactive command line interface: `kpcli`.
 * [KeePassC](http://raymontag.github.io/keepassc/). A command line interface to keepass.

`pass` password manager (too much complex, needs GPG setup):
 * [Pass](https://www.passwordstore.org/).
 * [Pass tutorial](http://www.tricksofthetrades.net/2015/07/04/notes-pass-unix-password-manager/).

Settitg a password inside the orkeychain in macOS:
```bash
sudo /usr/bin/security -v add-internet-password -a pierrick.rogermele@icloud.com -s mail.icloud.com -w 'mypassword' 
```

Getting a password stored in the keychain on macOS:
```bash
security find-internet-password -w -a pierrick.rogermele@icloud.com
```
## File system

### mkfs

Format an encrypted partition:
```sh
mkfs.ext4 -O encrypt /dev/xxx
```

### tune2fs

Enable encryption on an existing ext4 partition:
```sh
tune2fs -O encrypt /dev/xxx
```

Get drive information:
```sh
tune2fs -l /dev/xxx
```

### e4crypt

Create a key (at least one encrypted partition must exists, see `tune2fs` to enable encryption on an existing ext4 partition):
```sh
e4crypt add_key
```
See `keyctl` to list content of keyring.
<!-- TODO IMPORTANT After rebooting the new key does not appear in the session keyring. The encrypted folder are still encrypted and thus unreadable. When running `e4crypt get_policy` the right encryption key is listed.
	* Do we need to save the key in some way?
	* Does the key have to be reloaded from somewhere?
	* Does the exact same key need to be created again?
	-->
The key is created inside the session keyring, thus it will be removed when you log off. We need to create it again, the same way, next time we log in.

Encrypting a directory (must be empty):
```sh
e4crypt set_policy 1133557799bbddff myfolder
```

Check if a directory is encrypted:
```sh
e4crypt get_policy myfolder
```

### mktemp

 * GNU version replaces Xs in template.
 * BSD version doens't use the Xs and appends its own random string.
 
We can test if we're running BSD or GNU version
```bash
test_template=tmp.XXXXXX
bsd_version=$(mktemp -u -t $test_template | grep '/$test_template')
if [ -n "$bsd_version" ] ; then
	options="-t $prefix"
else
	options="-t $prefix.XXXXXX"
fi
tmp_file=$(mktemp $options)
```

Or always set XXXXX template:
```bash
tmp_file=$(mktemp -t tmp.XXXXXX)
```

### basename

Return filename portion of pathname:
```bash
basename /my/path/to/a/file
```

### dirname

Return directory portion of pathname:
```bash
dirname /my/path/to/a/file
```

### realpath

Returns resolved absolute path:
```bash
realpath my/path/to/some/where
```

### du

To measure disk usage of a folder:
```bash
du -shc <folder>
```

### ncdu

Analyze disk usage:
```bash
ncdu
```
or
```bash
ncdu <folder> # NCurses version of du
```

### file

Gives MIME type of a file using among other things the magic number stored in a magic list (see man file).

Prints human readable string:
```bash
file <file>
```

Prints only the type:
```bash
file -b --mime-type <file>
```

The `file` command also prints the character encoding. 

### find

Look for files containing a specified string in their name, starting from the root:
```bash
find / -name "gnomeprint"
```

Use regexp:
```bash
find / -regex <pattern>
find / -iregex <pattern> # case insensitive
find -E / -regex <pattern> # use extended regular expressions
```

Deleting found files:
```bash
find documents/ -iname '*~' -delete
```

Execute a command for each found file:
```bash
find <dir> -iname '*.txt' -exec printf '{}' \;
find . -iname '*.todo' -exec perl -e '$f="{}"; ($g=$f) =~ s/\.todo$/ N.txt/; printf "$f --> $g\n"; system("cat \"$f\" >>\"$g\"");' \;
```

Execute some code for each found file:
```bash
find . | while read f ; do 
	echo Found: $f
done
```

Move recent files (from today) from Download folder to another place:
```sh
find ~/Downloads/ -type f -daystart -mtime 0 -exec mv \{\} my/other/place/ \;
```

Levels of search
```bash
find . -maxdepth 1
```
level 0 tells to look only among the command line arguments
```bash
find R-* -maxdepth 0 -type d # return the list of all directories beginning wiht R-*
```

Filter on time:
```bash
find <dir> -newermt 2009-10-15
```
Find all files whose modification type is more recent than the specified date.

Filter on type:
```bash
find <dir> -type <type>
```

Type | Description
---- | -----------
b    | Block special.
c    | Character special.
d    | Directory.
f    | Regular file.
l    | Symbolic link.
p    | FIFO.
s    | Socket.

Operators:

Operator       | Description
-------------- | -----------
-false         | False.
-true          | True.
! expr         | Logical not.
-not expr      | Logical not.
expr expr      | Logical and.
expr -and expr | Logical and.
expr -or expr  | Logical or.
( expr )       | Grouping.

Filter on permissions:
```bash
find <dir> -perm -u+x       # Standard notation. 
find <dir> -perm +0422      # Octal notation.
find . -type f -perm 700    # Search for executable files.
```
Permission prefix | Decription
----------------- | ------------------------
-                 | All bits are set.
NOTHING           | Bits match exactly the file mode.
+                 | Any of the bist is set. Be careful with this + sign because it can be interpreted as a mode (not clear why for me, TODO).

Permissions GNU notation:
```bash
find <dir> -perm /u=x
```

Print output with \0 separator for results instead of \n:
```bash
find ... -print0
```

Quote filenames in output, one filename per line:
```bash
find ... -printf '"%p"\n'
```

### trash-cli

Command line trashcan (recycle bin) interface, respecting the freedesktop specifications.

Put file in trash:
```sh
trash myfile
```

Get help:
```sh
trash -h
```

List files in trash:
```sh
trash-list
```

Restore a file:
```sh
trash-restore /full/path/to/my/file
```

The default user Trash folder of the freedesktop specifications is `~/.local/share/Trash` (`$XDG_DATA_HOME/Trash`). See:
 * [The FreeDesktop.org Trash specification](https://specifications.freedesktop.org/trash-spec/trashspec-latest.html)
 * [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html).

### chmod

When the sgid bit is set on a directory, all files & dirs created in this directory will automatically have the same group as the directory:
```bash
chmod g+s mydir
```

Set execute/search flag for directories only:
```
chmod -R g+X mypath
```

To recursively remove execution flag on files in a directory tree, with GNU version:
```sh
chmod -R a-x,a+X mydir
```

### umask

`umask` set the default permissions for new files.

### ls

BSD ls and GNU ls are different.
GNU ls command is part of the coreutils package.

Sorting by size:
```bash
ls -S *
```

Reverse sort order:
```bash
ls -r *
```

Quoting names and escaping characters:
```bash
ls -Q
```

Print access time instead of last modification time:
```bash
ls -u *
```

In MacOS-X, a `@` character after permissions means that the file has additional attributes. You can see these additional attributes by typing the following command:
```bash
xattr -l <filename>
xattr -d <attrname> <filename> # to remove an attribute
```

In MacOS-X, a `+` character after permissions means that the file has an ACL, short for Access Control List, which is used to give fine grained control over file permissions, beyond what is available with the regular unix permission tables.
Entering the following command will show these additional permissions for files in a directory:
```bash
ls -le
```

### stat

Gives information on file:
```sh
stat myfile
```

Print size of file:
```sh
stat --printf="%s" myfile
```

List found files by size:
```sh
find . -name *.h5 | xargs -n 1 -I @ stat --printf="%s %n\n" "@" | sort -n
```

#### Coloring ls output

 * [dircolors: modify color settings globaly](https://unix.stackexchange.com/questions/94299/dircolors-modify-color-settings-globaly). Tips on how to set 256 colors.
 * [Customize file extension colors for ls output in Cshell](https://stackoverflow.com/questions/27290258/customize-file-extension-colors-for-ls-output-in-cshell).

`LSCOLORS` (see man ls), is an environment variable that defines the colors to be used by `ls` command. The default is "exfxcxdxbxegedabagacad", i.e. blue foreground and default background for regular directories, black foreground and red background for setuid executables, etc.

Color code | Descrption
---------- | -----------------------------------------------
a          |  Black.
b          |  Red.
c          |  Green.
d          |  Brown.
e          |  Blue.
f          |  Magenta.
g          |  Cyan.
h          |  Light grey.
A          |  Bold black, usually shows up as dark grey.
B          |  Bold red.
C          |  Bold green.
D          |  Bold brown, usually shows up as yellow.
E          |  Bold blue.
F          |  Bold magenta.
G          |  Bold cyan.
H          |  Bold light grey; looks like bright white.
x          |  Default foreground or background.

Note that the above are standard ANSI colors.  The actual display may differ depending on the color capabilities of the terminal in use.

The order of the attributes are as follows:

Rank | Description
---- | ---------------------------------
1    | Directory.
2    | Symbolic link.
3    | Socket.
4    | Pipe.
5    | Executable.
6    | Block special.
7    | Character special.
8    | Executable with setuid bit set.
9    | Executable with setgid bit set.
10   | Directory writable to others, with sticky bit.
11   | Directory writable to others, without sticky bit.

### lsof

List applications that have open a certain file:
```bash
lsof | grep MYFILE
```

List applications using network:
```bash
lsof | grep TCP
```

### mount

* [Auto-mount network shares (cifs, sshfs, nfs) on-demand using autofs](https://pjs-web.de/post/autofs/).

```bash
mount -t cifs //123.456.78.90/MyFolder my/local/dir -o username=...,password=...
```

To mount automatically, on demand, create a file /etc/autofs/auto.myext:
```conf
mylocalfoldername -fstype=cifs,username=******,workgroup=*****,password=*******,uid=${UID},gid=******* ://myserver/my/path/to/my/folder/
```

Mount a samba directory under MacOS-X:
```bash
mount -t smbfs //PR228844@DRTFAUCON-1/DCSI/LM2S/CLIMB smbnetdir
```
Then it asks the password.

Mount a samba directory under Linux:
```bash
mount -t smbfs -o username=PR228844 //DRTFAUCON-1.INTRA.CEA.FR/DCSI/LM2S/CLIMB smbnetdir
mount -t smbfs -o username=PR228844,password=Mypass0123 //DRTFAUCON-1.INTRA.CEA.FR/DCSI/LM2S/CLIMB smbnetdir
```

To allow non-root users to mount a samba drive, use sudo.
Create a `samba` group and add users to it.
Edit `/etc/sudoers` and add the following line:
```
%samba ALL=(ALL) NOPASSWD: /bin/mount,/bin/umount,/sbin/mount.cifs,/sbin/umount.cifs,/usr/bin/smbmount,/usr/bin/smbumount
```
The `NOPASSWD:` directive prevents `sudo` from prompting for the user's password. It is optional.

### udisks

Mount and unmount removale media.

Mount a removable media:
```sh
udisksctl mount -b /dev/sdc1
```

Unmount a removable media:
```sh
udisksctl unmount -b /dev/sdc1
```

### Samba

 * [Samba](https://wiki.archlinux.org/index.php/samba).

To setup Samba under macOS, declare the workgroup:
	System Preferences -> Network -> [your network device] -> Advanced -> WINS -> Workgroup
The path from a Windows computer is:
	\\<server name\<shared folder>

Access folders on samba share:
```bash
smbclient -L 123.456.789.012 -U INTRA\\PR228844
```

Get the netbiosname from a computer:
```bash
nbtscan 123.456.789.012
```

Install a Samba server on Debian:
```bash
apt-get install samba
```

Configuration in `/etc/samba/smb.conf`:
```
[global]
server string = Vampire
workgroup = Workgroup
netbios name = Vampire
public = yes
encrypt passwords = true

[projects]
path = /home/zero/projects
read only = no
writeable = yes
valid users = zero
comment = all_my_projects
```

Check the conf file:
```bash
testparm
```

Be careful that all files under `/var/lib/samba` and `/var/cache/samba` belong to `root:root`.

Create a user:
```bash
smbpasswd -a a_username
```
Samba uses existing Linux users, but has its own list of passwords.

Restart samba:
```bash
/etc/init.d/samba restart
```

To debug samba demon, run:
```sh
sudo /usr/bin/smbd --foreground --no-process-group -i -S -d 5
```

Start `smdb` and `nmdb` as daemons:
```sh
sudo /usr/bin/smbd -D
sudo /usr/bin/nmbd -D
```

On ArchLinux, to start Samba service:
```bash
sudo systemctl start smb
```

To configure samba with guest access:
```
[global]
security = share

[myshareddir]
guest ok = yes
```

#### Sambashare

Use sambashare to allow non-root users to create their shared drives:
```bash
mkdir /var/lib/samba/usershares
groupadd -r sambashare
chown root:sambashare /var/lib/samba/usershares
chmod 1770 /var/lib/samba/usershares
```

In `/etc/samba/smb.conf`:
```
[global]
  usershare path = /var/lib/samba/usershares
  usershare max shares = 100
  usershare allow guests = yes
  usershare owner only = yes
```

Add users to the group:
```bash
gpasswd sambashare -a <username>
```

Then as a user:
```bash
net usershare add <sharename> <abspath> [comment] [<user>:{R|D|F}] [guest_ok={y|n}]
net usershare delete <sharename>
net usershare list <wildcard-sharename>
net usershare info <wildcard-sharename>
```
Where `R`, `D` and `F` stand for Read-only, Deny and Full respectively.

### NFS

On macos:
See dscl tool for setting NFS server.
Use Disk Utility to mount an NFS directory on a client.


### Partition management

To shrink `/home` and expand another partition in LVM:
```bash
umount /home
e2fsck -f /dev/mapper/vg_oracle-lv_home
resize2fs /dev/mapper/vg_oracle-lv_home 20G
lvreduce -L 20G /dev/mapper/vg_oracle-lv_home
lvextend -l +100%FREE /dev/mapper/vg_oracle-lv_root
resize2fs /dev/mapper/vg_oracle-lv_root
mount /home
```
See https://unix.stackexchange.com/questions/213245/increase-root-partition-by-reducing-home.

### convmv

Convert the encoding of a filename:
```
convmv -f iso8859-1 -t utf-8 --notest myfile.ext
```

Installation on Debian:
```
apt install convmv
```

### macos file attributes

To see special file attributes:
```bash
ls -@
```
or
```bash
xattr <filename>
```

To remove attributes:
```bash
xattr -d <attribute_name> <filename>
```

To remove attributes for a whole directory:
```bash
xattr -dr <attribute_name> <dirname>
```

### which

The `which` command returns the path of a command. If the command cannot be found, an error is returned.

On BSD/macOS `which` has a silent option:
```bash
which -s myprog
```

### command

POSIX command.

Test if a command exists:
```bash
command -v mycmd >/dev/null 2>&1
```

### ranger

An ncurses file browser.

Key | Description
--- | ----------------------------
om  | Sort by modification time

## Compression and uncompression

### tar

To tar files without the parent directory, first change to that dir:
```bash
tar -cjf my_pkg.tbz -C my_dir .
```
The `-C <dir>` option, change to the specified directory.

Incremental backup (GNU only):
```bash
tar -cf /backup/my_dir.0.tar -g /backup/my_dir.snar /my/dir
tar -cf /backup/my_dir.1.tar -g /backup/my_dir.snar /my/dir
tar -cf /backup/my_dir.2.tar -g /backup/my_dir.snar /my/dir
```
Best practice is to do one full dump each week, and then a level 1 backup (incremental backup from the full dump) each day.
Note the option `--no-check-device`, which tells `tar` to do not rely on device numbers when preparing a list of changed files for an incremental dump. Device numbers are not reliable with NFS.
To restore an incremental backup:
```bash
tar -xf /backup/my_dir.0.tar -g /dev/null
tar -xf /backup/my_dir.1.tar -g /dev/null
tar -xf /backup/my_dir.2.tar -g /dev/null
```

Use xz:
```bash
tar -cJf mydir.tar.xz mydir
```

Extract in another directory:
```bash
tar -xzf my.file.tar.gz -C my/dest/dir
```

### zip, unzip

To compress files:
```bash
zip my_zip_file file1 file2 ...
```

To compress a folder:
```bash
zip -r my_dir my_dir # recursive
zip -j foo foo/* # to leave off the path
```

To uncompress:
```bash
unzip myfile.zip
```

List files contained inside a zip:
```bash
unzip -l myfile.zip
```

Unzip quietly:
```bash
unzip -q myfile.zip
unzip -qq myfile.zip
```

### 7z

Uncompress archive:
```sh
7z e myarchive.7z
```

## Binary file processing, editing & viewing

### split

Split a big file into several one giga bytes files:
```bash
split -b 1G myfile.bin myfile
```


### strings

Extract strings from binary file.

### hexdump

Tool for dumping a file content in hexadecimal format:
```bash
hexdump myfile
```

Display also ASCII characters:
```bash
hexdump -C myfile
```

### hexedit

Hexademical editor.

```bash
hexedit myfile
```

Key    | Description
------ | --------------------
/      | Search hexadecimal.
Tab+/  | Search ASCII.
Tab    | Toggle between ASCII and hexadecimal.
Ctrl+T | Toggle between ASCII and hexadecimal.

### dhex

Diff hexadecimal editor.

```bash
dhex myfileA myfileB
```

### xxd

Dump a file in hexadecimal.

```bash
xxd -p myfile
```

Searching for a sequence of bytes into a file using xxd and grep:
```bash
xxd -p myfile | tr -d '\n' | grep -c 'e280a8'
```

## Text file processing, editing & viewing

### column

Align the column of a file for viewing:
```bash
column -t myfile
```
By default the columns are considered separated by white spaces (space and tab).

If you have a CSV file:
```bash
column -t -s , myfile.csv
```

With a TSV file:
```bash
column -t -s $'\t' myfile.tsv
```

### sc

sc is a spreadsheet program. It has its own file format.

Edit a CSV file:
```bash
cat myfile.csv | psc -k -d, | sc
```

### tr

Set in uppercase:
```bash
tr '[:lower:]' '[:upper:]'
```

Removing all carriage returns:
```bash
tr -d '\r'
```

### dos2unix & unix2dos

Convert a text file with Windows style (line ending CRLF) file into a unix style file:
```bash
dos2unix myfile.txt
```

To convert from UNIX style to Windows style:
```bash
unix2dos myfile.txt
```

### cat

For printing special characters (carriage returns, ...):
```bash
cat -vte
```
Display ^M for the carriage return, and $ for the newline.

### head

Output the 3 first lines:
```sh
head -n 3 myfile
```

Output all lines but the last 5:
```sh
head -n -5 myfile
```

### tail

Output the 3 last lines:
```sh
tail -n 3 myfile
```

Output from line 4 to the end:
```sh
tail -n +4 myfile
```

### comm

Compares two sorted files line by line.

### csplit

Split file horizontally, on line numbers or line matching a pattern.

### diff

To make a patch:
```bash
diff -ru <old sources> <new sources> >myfile.patch
diff -ruwNB old_v3 new_v3 > v3.patch
```

Flag | Description
---- | --------------------------------
`-w` | Ignore all white spaces.
`-B` | Ignore blank lines.
`-N` | Make patch also for new files.

Exclude files:
```bash
diff -x .c ...
```
It works for directory inside the path, for instance:
```bash
diff -x .git ...
```
Will exclude all files containing `.git` in the path, including `/.../.git/.../somefile`.

### join

Join two files in a way similar to relational databases:
```bash
join a.txt b.txt >c.txt
```
By default `join` uses the first column as the join field.

Set the join fields, using column 3 in the first file and column 4 in the second file:
```bash
join -1 3 -2 4 a.txt b.txt >c.txt
```

### patch

Patching a source tree:
```bash
patch -p1 < patch-file-name-here
```

Patching a file:
```bash
patch original_file patch_file
```

### printf

Formats and prints data.

### sort

Sorting inplace:
```bash
sort myfile -o myfile
```

In MacOS-X, sort will not recognize unicode in UTF-8 files.
One must use iconv first to convert file into UTF8-MAC format:
```bash
iconv -t UTF8-MAC myfile.txt | sort
```

### cut

To cut a portion of text of each line:
```bash
cut -c 3-5,10-20 <my_file
```
Take only characters 3 to 5 and 10 to 20.

Select fields separated by a character:
```bash
cut -d ',' -f 1,3,4 <my_file
```

### colrm
Remove columns from a file, where a column means a character column.

Remove all characters from 5 to end:
```bash
colrm 5
```

Remove all characters from 5 to 10:
```bash
colrm 5 10
```

### fold

To wrap lines to 80 columns:
```bash
fold -w 80 <my_file
```

To wrap at last space character:
```bash
fold -s -w 80 <my_file
```


### grep

Specifying multiple expressions:
```bash
grep -e toto -e titi # will match all lines of files that match either toto or titi
```

Displaying list of matching or non-matching files:
```bash
grep -l -e resto * # display matching files
grep -L -e resto * # display non-matching files
```

Labelling standard input:
```bash
gzip -cd foo.gz | grep --label=foo something
```

Print filename for each match:
```bash
grep -H toto *
```

Print line number for each match:
```bash
grep -n toto *
```

Print context (some lines before and/or after):
```bash
grep -A 2 toto * # 2 lines after
grep -B 2 toto * # 2 lines before
grep -C 2 toto * # 2 lines before and 2 lines after
```

Exclude files:
```bash
grep --exclude=*.class
```

Select files (include only specified files):
```bash
grep --include=*.java
```

Print only n lines:
```bash
grep -m <n> ...
```

Ignore binary files:
```bash
grep -I ...
```

Match whole lines:
```bash
grep -x ...
```

Exclude from one file lines listed in another:
```bash
grep -v -x -f toexclude.txt myfile.txt
```

No regex:
```bash
fgrep ...
```

Extended regex:
```bash
egrep ...
```

Recursive:
```bash
rgrep ...
```

Search for files containing non-ASCII characters and control characters:
```bash
LC_ALL=C grep -l '[^[:print:]]'
```

### paste

Paste two or more files side by side:
```bash
paste a.txt b.txt c.txt >d.txt
```
By default, replace new line chars in a.txt and b.txt by tabulation.

### ed

Line editor.

### sed

To remove spaces at the end of a line:
```bash
sed -re 's/\s+$$//'
```

In shells, the `$` sign must be doubled in roder to do not be confused with a variable:
```bash
sed -re 's/\r$$//'
```

To remove carriage returns at the end of a line (Windows text file):
```bash
sed -re 's/\r$//'
```

To delete lines:
```bash
sed -re '/COUCOU/d'
```

To run multiple expressions in the same sed:
```bash
sed -re '...' -e '...' -e '...' ...
```

To edit in-place (BSD sed):
```bash
sed -e mycommand -i .bkp myfile # save backup with .bkp extension
sed -e mycommand -i '' myfile # no backup
```
For GNU sed:
```bash
sed -e mycommand -i.bkp myfile # save backup with .bkp extension
sed -e mycommand --in-place=.bkp myfile # save backup with .bkp extension
sed -e mycommand -i myfile # no backup
```

To edit the first line only:
```bash
sed -e '1s/foo/bar/g' myfile
```

Edit and print only selected lines:
```bash
sed -n -e 's/^some text\(.*\)/new text\1/p' myfile
```

To add a carriage return to the end of a file:
```bash
sed -i '' -e '$a\' toto.txt
```

Print even lines:
```bash
sed -n 'n;p' filename
```

Print odd lines:
```bash
sed -n 'p;n' filename
```

Print only the lines inside a range of regex addresses:
```bash
sed -n '/GOOGLE/,/ssl/p' ~/.offlineimaprc
```

To delete lines inside a range of regex addresses:
```bash
sed '/^---$/,/^---$/d' myfile
```

Delete first line:
```bash
sed '1d' myfile
```

To insert a carriage return, you need to actually type it:
```bash
echo "MY LINE OF TEXT" | sed 's/ /\
/g'
```

### ex

Text editor.

### fold

Wraps long lines to fit width.

### iconv

Converts between encodings.

Convert from Mac-OS Roman encoding to Unicode on standard output:
```sh
iconv -f mac -t utf-8 myfile
```

### m4

Macro processor.

### more

Text file viewer.

### less

Text file viewer.

### nl

Count number of lines of files.

### wc

Count number of lines, words and characters of files.

### uniq

Filter out duplicated lines:
```bash
uniq myfile
```

Output only the duplicated lines:
```bash
uniq -d myfile
```


### banner

Generates simple ASCII art:
```sh
banner 0123
```

### figlet

Generates ASCII art:
```sh
figlet -f ogre "Potion"
```

## env

Running command from shebang:
```r
#!/usr/bin/env -S Rscript --vanilla
```
If `-S` is not set:
```
/usr/bin/env: ‘Rscript -S "--vanilla"’: No such file or directory
/usr/bin/env: use -[v]S to pass options in shebang lines
```

## Power management

See:
 * [XScreenSaver](https://wiki.archlinux.org/index.php/XScreenSaver).
 * [Session lock](https://wiki.archlinux.org/index.php/Session_lock).
 * `xset dpms`.
 * `systemd` about `logind.conf` and `sleep.conf`.

### pmset

BSD command.

Get battery information:
```bash
pmset -g batt
```

### acpi

Shows battery information.
```sh
acpi
```


## Package management

### pacman (ArchLinux)

 * [Mirrors](https://wiki.archlinux.org/index.php/Mirrors).

Install or upgrade (synchronize) a package:
```bash
pacman -S mypkg
```

Query installed packages:
```bash
pacman -Q mypkg
```

Query the files database:
```bash
pacman -Fl mypkg
```

Search for packages:
```bash
pacman -Ss mypkg
```

Get info on a package:
```bash
pacman -Si mypkg
pacman -Qi mypkg
```

List all files of an installed package:
```bash
pacman -Ql mypkg
```

Update databases:
```bash
pacman -Syy # The second `y` force refresh of all databases even if it appears up-to-date.
```
A file `/etc/pacman.d/mirrorlist.pacnew`

To select the fastest mirrors, use `rankmirrors` from `pacman-contrib` package:
```sh
cp /etc/pacman.d/mirrorlist mirrorlist.bkp
sed -i 's/^#Server/Server/' mirrorlist.bkp
rankmirrors -n 10 mirrorlist.bkp > mirrorlist.10fastest
```

Upgrade/update all packages:
```bash
pacman -Syu
```

List out-of-date packages:
```sh
pacman -Qu
```

Install AUR (ArchLinux User Repository) packages:
```bash
yay -S mypkg
```
Run `yay` as normal user, not as root.

Search for packages containing a file:
```bash
pacman -Qo myfile
```

Remove a package and all its dependencies that are not used by any other package
and has not been installed explicitly:
```sh
sudo pacman -Rs mypkg
```

Downgrade packages (in case some packages are detected as newer than in repository):
```sh
sudo pacman -Suu
```

# yay (ArchLinux)

Package manager for AUR repository.

### Homebrew / brew

 * <http://mxcl.github.com/homebrew/>.
 * <https://github.com/mxcl/homebrew/>.
 * [Homebrew Multi User Setup](https://medium.com/@leifhanack/homebrew-multi-user-setup-e10cb5849d59). --> Old versions of brew, does not work anymore.

For installing in `/usr/local`:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
```

For installing elsewhere:
```bash
mkdir homebrew && curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C homebrew
```

Install a package:
```bash
brew install <package>
brew install --HEAD <package>	# to install with the developpement version (HEAD) of the brew formulae (ruby file)
brew install --build-from-source <package> # force installing from sources, even if a bottle version is available.
```

Installing from another formulæ repository:
```bash
brew install homebrew/science/myformula
```
or
```bash
brew tap homebrew/science
brew install myformula
```

Extract sources into a new local dir:
```bash
brew unpack my.formula
brew unpack -p my.formula   # Apply also patches.
```

Get cache path:
```bash
brew --cache
```

Get all installed packages that depend on another package:
```bash
brew uses --installed mypkg
```

List all files of a package:
```bash
brew list mypkg
```

Install Xcode command line tools (needed):
```bash
xcode-select --install
```

#### Maintenance tasks

Clean unused old packages:
```bash
brew cleanup
```

Run diagnostics:
```bash
brew doctor
```

Update packages information:
```bash
brew update
```

Upgrade installed packages:
```bash
brew upgrade
```

#### Cask

Install third party applications, in binary (Goole Earth, VLC, ...)

Clean cask:
```bash
brew cask cleanup
```

#### Writing a formula

 * [Contributing to Homebrew](https://github.com/Homebrew/homebrew-core/blob/master/.github/CONTRIBUTING.md).
 * [Formula Cookbook](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md).
 * [Class: Formula](http://www.rubydoc.info/github/Homebrew/brew/master/Formula).
 * [How To Open a Homebrew Pull Request (and get it merged)](https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/How-To-Open-a-Homebrew-Pull-Request-(and-get-it-merged).md).

You may encounter the following error while running `brew tests`:
```
1) Failure:
LanguageModuleRequirementTests#test_good_ruby_deps [/usr/local/Library/Homebrew/test/test_language_module_requirement.rb:51]:
Expected #<LanguageModuleRequirement: "languagemodule" [:ruby, "date", nil]>
 to be satisfied?
```
In that case, check if you have installed ruby using Homebrew. If that is the case, uninstall it. `brew` will then use the macOS ruby.

### apt (Ubuntu, Debian)

 * [Ubuntu Packages Search](http://packages.ubuntu.com).

Adding a ppa (normally, add also the key):
```bash
sudo apt-add-repository ppa:gwibber-daily/ppa
```

To install a missing public key:
```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 2EA8F35793D8809A
```

Updating repositories database:
```bash
sudo apt-get update
```

Searching for packages:
```bash
apt-cache search qt4
```

Getting info about a package:
```bash
apt-cache show qt4
apt-cache showpkg qt4 # Show dependencies
dpkg -s qt4 # Show information on installed package
```

Update packages:
```bash
sudo apt-get upgrade
```

Only shows what it would do, but don't do it:
```bash
sudo apt-get -s upgrade
```

Selecting java installation:
```bash
update-java-alternatives -l
sudo update-java-alternatives -s java-1.5.0-sun
```

To uninstall a package:
```bash
sudo apt-get remove mypkg
```

Install a `.deb` archive:
```bash
apt install mypkg.deb
```

### dpkg (Debian)

Install a package archive `.deb`:
```bash
dpkg -i mypkg.deb
```

Compare versions:
```bash
dpkg --compare-versions "2.11" "lt" "3"
```

### alien (RPM / Debian)

Convert an RPM package into a DEB package:
```bash
apt-get install alien
alien -d mypkg.rpm
```

### snap (Ubuntu, Debian)

Installing a package:
```bash
snap install kubectl --classic
```

### gdebi (Ubuntu, Debian)

`gdebi` installs Debian packages (.deb).
To install it:
```bash
sudo apt-get install gdebi
```

To install a package with it:
```bash
sudo gdebi mypackage.deb
```

### `yum` (CentOS, RedHat, Fedora)

Search for a package:
```bash
yum search mypkg
```

Install a package:
```bash
yum install mypkg
```

Installing a package and answering yes automatically to any question:
```bash
yum -y install mypkg
```

### `zypper` (Suse)

Looking for the package to which a command belongs:
```bash
cnf <command>
```

Installing a package:
```bash
sudo zypper install <package>
```

Getting information about a package:
```bash
zypper info <package>
```

adding a repository to package manager
```bash
sudo zypper addrepo <URL> <alias>
```
or
```bash
sudo zypper ar <URL> <alias>
```

refresh a repository
```bash
sudo zypper refresh --repo <alias>
```

upgrade packages inside a repository
```bash
sudo zypper dist-upgrade --repo <alias>
```

Packman repository.
Contains that are not distributed with Linux distributions,
like aMule.
<http://packman.jacobs-university.de/suse/11.2/>

installing kernel sources
kernel sources are in /usr/src
run uname to know the current kernel version (kernel-default, kernel-desktop, ...):
uname -r
run the following command to install last version of the corresponding kernel:
sudo zypper install kernel-default
run the following command to install the corresponding kernel sources:
sudo zypper install kernel-source
or
sudo zypper install --type srcpackage kernel-default

### `emerge` (gentoo)

Updating:
```bash
sudo emerge --sync
```

Searching:
```bash
equery mypkg
```

If you do not have `equery` you can install it with:
```bash
emerge -a gentoolkit
```

Installing:
```bash
sudo emerge mypkg
```

### pkg (FreeBSD)

Search for a package:
```bash
pkg search mypkg
```

## Sound & video

### alsactl

Configure sound on Debian with ALSA system:
```bash
alsactl init
```

Restore default:
```bash
alsactl -F restore
```

### microphone setup

 * [No microphone input](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture/Troubleshooting#Microphone).

Run `alsamixer`, and then:
 * In 'Playback' view (F3), set microphone to "Follow Capture".
 * In 'Capture' view (F4), increase volume of CAPTURE and "Internal Mic".

To test microphone:
```sh
arecord --duration=5 --format=dat test-mic.wav
aplay test-mic.wav
```

**Skype** for Linux needs `pulseaudio` in order to recognize microphone, so with alsa configuration, you need first to install `apulse`, a PulseAudio emulator for ALSA and then run:
```sh
apulse skypeforlinux
```

### alsamixer

Ncurses console ALSA tool to manage sound card configuration.
Move with left/right to select.
Press up/down to modify.

Disabling "Auto-Mute Mode" is possible.

### amixer

Command line ALSA tool to manage sound card.

Get a list of available controls:
```sh
amixer scontrols
```

Get a list of available controls with their set values:
```sh
amixer scontents
```

Set microphone boost level (values: 0, 1, 2 and 3):
```sh
amixer sset "Internal Mic Boost" 0
```

Set microphone LED indicator (values: On, Off, Follow Capture, Follow Mute):
```sh
amixer sset "Mic Mute-LED Mode" Off
```

### pacmd


### mplayer

	-dvd-device /dev/hdd	: set dvd device
	Dvd://1			: read track 1 of DVD
	-ss 0:16:00		: start at position "16 minutes after the beginning"
	-aid <ID>		: select audio channel by ID (0x80, 0x81, ...)
	-alang code		: select audio channel by language code (fr, en, ...)
	-fs			: fullscreen

Play DVD menu:
```sh
mplayer dvdnav:// -dvd-device /dev/sr0
```

To enable support for encrypted DVD (region DVD support), install `libdvdcss`.

To select audio output, look first at available audio devices with `aplay` (`alsa-utils` package on ArchLinux):
```sh
aplay -l
```
Then run mplayer with option `-ao`:
```sh
mplayer -ao alsa:device=hw=1,0,0
```
Where the three indices are in order: the card index, the device index, the subdevice index.

Keys:
 * `o`: display time elapsed and time remaining for a video.
 * `f`: video full screen.

### eject

Eject disk:
```sh
eject
```

### ffmpeg

To convert from AIFF to Apple Lossless:
```bash
ffmpeg -i audio.wav -acodec alac audio.m4a
```

To convert m4a into mp3:
```bash
ffmpeg -i myfile.m4a -acodec libmp3lame -ab 96k myfile.mp3
```

We can also use ffmpeg directly to encode the images files into a movie. If we start with files name 001.jpg, 002.jpg, ..., we can use:
```bash
ffmpeg -r 10 -b 1800 -i %03d.jpg test1800.mp4
```

Concat two audio files, one after the other:
```bash
ffmpeg -i file1.mp3 -i file2.mp3 -filter_complex '[0:0][1:0]concat=n=2:v=0:a=1[out]' -map '[out]' output.mp3
```

Convert mp4 to avi:
```bash
ffmpeg -i input.mp4 -c:v libx264 -c:a libmp3lame -b:a 384K output.avi
```

### feh

Light image viewer.

Display images of the current directory:
```sh
feh -g 640x480 --auto-rotate -. -d -S filename .
```
	-g ...x... set/force geometry
	-. scale image
	-d Print filename onto the image
	-S ... sort by type: filename, name, dirname, mtime, width, size, ...

Set X background image:
```sh
feh --bg-scale /path/to/image.file
```
Other scaling for background:
	--bg-tile FILE
	--bg-center FILE
	--bg-max FILE
	--bg-fill FILE

Set randomly the background image:
```sh
feh --bg-fill --randomize ~/data/wallpapers/
```

### xawtv

display default camera:
```sh
xwatv
```

display USB camera:
```sh
xawtv -c /dev/video2
```

Press 'j' to Shoot a photo and save it in JPEG format.

### dd

To make an ISO from your CD/DVD, place the media in your drive but do not mount it. If it automounts, unmount it.
```bash
dd if=/dev/dvd of=dvd.iso # for dvd
dd if=/dev/cdrom of=cd.iso # for cdrom
dd if=/dev/scd0 of=cd.iso # if cdrom is scsi 
```

To write an ISO on a device (and make it bootable):
```bash
dd if=myiso.iso of=/dev/sdb # Do not use the index, /dev/sdb1 or /dev/sdb2, ...
```

Command for making a USB key bootable with Archlinux on it:
```bash
dd bs=4M if=myiso.iso of=/dev/sdx status=progress oflag=sync && sync
```

### mkisofs

Create an ISO from a directory:
```bash
Mkisofs -r -f -iso-level 4 -V <volume_label> <directory> > file.iso
```
	-f : follow links
	-r : Rock Ridge protocol extension

Pour des fichiers volumineux, utiliser le format udf:
```perl6
Mkisofs -iso-level 4 -r -f -udf -V <volume_label> <directory> > file.iso
```

### transcode

Pour éliminer les bords noirs :
```bash
transcode -i 78\ Tours.avi -J detectclipping=limit=24 -y null,null
transcode -i 78\ Tours.avi -j 0,8,0,8 - R 1 -y xvid4,null && transcode -i 78\ Tours.avi -j 0,8,0,8 - R 2 -y xvid4 -o 78tours_2.avi

nice transcode -i grease.1800.avi -w 900 -R 1 -y divx4,null && nice transcode -i grease.1800.avi -w 900 -R 2 -y divx4,null -o grease.900.divx4.avi

nice -19 transcode -i The\ Young\ Master.avi -j 0,8,0,8 -w 810 -R 1 -y xvid4,null && nice -19 transcode -i The\ Young\ Master.avi -j 0,8,0,8 -w 810 -R 2 -y xvid4 -o youngmaster.avi

transcode -i easter.avi -w 240 -c 70-22071 -R 1 -y xvid4,null && transcode -i easter.avi -w 240 -c 70-22071 -R 2 -y xvid4 -o easter.2.avi
```
	
Convert mkv to avi:
```bash
mkvmerge -i movie.mkv # to obtain the list of tracks
mkvextract tracks movie.mkv 1:movie.xvid
mkvextract tracks movie.mkv 2:movie.ogg
transcode -i movie.xvid -p movie.ogg -y xvid4 -o movie.avi
```

Pour extraire une piste audio d'un avi et l'écrire dans un fichier ogg:
```bash
transcode -i movie.avi -y null,ogg -o movie.ogg
```

	-J : filter
	-T : dvd title
	-a : audio track
	-j : select frame region by clipping border.
	-o : output file
	-y : output encoder
	-R n : n=1 first pass, n=2 second pass
	-Z wxh : resize
	-w : bitrate
		$video_bitrate = int($video_size/$runtime/1000*1024*1024*8);
		  with $video_size in MB and $runtime in seconds
	-c f1-f2	: frames range in frame numbers or time (HH:MM:SS)
	-I 5 : deinterlace
	-C 3 : anti-aliasing, full frame
	--import_asr <number> : aspect ratio
			1:	1:1
			2:	4:3	= 1.33
			3:	16:9	= 1.78
			4:	2.21:1
	
```bash
transcode -i Zorba\ The\ Greek.avi -x mplayer -w 800 --import_asr 3 -I 5 -C 3 -Z 720 -J detectclipping=limit=24 -y null,null
nice -19 transcode -i Zorba\ The\ Greek.avi -x mplayer -y null,ogg -o zorba.ogg && nice -19 transcode -i Zorba\ The\ Greek.avi -x mplayer -w 800 --import_asr 3 -I 5 -C 3 -Z 720 -j 16,0,16,0 -R 1 -y xvid4,null && nice -19 transcode -i Zorba\ The\ Greek.avi -x mplayer -w 800 --import_asr 3 -I 5 -C 3 -Z 720 -j 16,0,16,0 -R 2 -y xvid4,null -o zorba.avi

nice -19 transcode -i Why\,\ Charlie\ Brown\,\ Why.mpg --import_asr 2 -Z 768 -w 600 -I 5 -j 8,16,0,16 -R 1 -y xvid4,null && nice -19 transcode -i Why\,\ Charlie\ Brown\,\ Why.mpg --import_asr 2 -Z 768 -w 600 -I 5 -j 8,16,0,16 -R 2 -y xvid4 -o why.avi

nice -19 transcode -i grease.1800.avi -x mplayer -w 900 -R 1 -y xvid4,null && nice -19 transcode -i grease.1800.avi -x mplayer -w 900 -R 2 -y xvid4,null -o grease.900.avi

nice -19 transcode -i Fast\ Film.avi -j 8,0,8,0 -R 1 -y xvid4,null && nice -19 transcode -i Fast\ Film.avi -j 8,0,8,0 -R 2 -y xvid4 -o fast.avi

nice -19 transcode -i Fast\ Film.avi -j 8,0,8,0 -w 10 -R 3 -y xvid4 -o fast.R3.10.avi

transcode -i For\ the\ Birds.mpg --import_asr 3 -Z 640 -j 64,8,72,8 -w 5 -R 3 -y xvid4 -o birds.avi
nice -19 transcode -i For\ the\ Birds.mpg --import_asr 3 -Z 640 -j 64,8,72,8 -w 300 -R 1 -y xvid4,null && nice -19 transcode -i For\ the\ Birds.mpg --import_asr 3 -Z 640 -j 64,8,72,8 -w 300 -R 2 -y xvid4 -o birds.avi

nice -19 transcode -i Martinko.avi -j 0,8,0,8 -w 900 -R 1 -y xvid4,null && nice -19 transcode -i Martinko.avi -j 0,8,0,8 -w 900 -R 2 -y xvid4 -o matrinko.R12.900.avi
nice -19 transcode -i Martinko.avi -x mplayer -j 0,8,0,8 -w 5 -R 3 -y xvid4 -o martinko.R3.5.avi

nice -19 transcode -i glace.avi -x mplayer --import_asr 3 -I 5 -C 3 -Z 720 -j 16,0,16,0 -w 5 -R 3 -y xvid4,ogg -o glace.R3W5.avi

transcode -i 05-At\ the\ ends\ of\ the\ earth\ -\ Konstantion\ Bronzit\ -annecy\ 1999.mpg -c 0:0:12-10000000 -j 56,8,56,0 -y xvid4 -o ends.trans.avi

transcode -i Ce\ Qui\ Me\ Meut.avi -j 0,8,0,8 -w 5 -R 3 -y xvid4 -o meut.avi
```	

Pour calculer la zone de clipping :
```bash
transcode -i /dev/dvd -T 2,-1 -a 1 -J detectclipping=limit=24 -y null,null
	
nice -19 transcode -i /dev/dvd1 -T 1,-1 -j 16,32,16,32 -I 5 -C 3 --import_asr 3 -w 3 -R 3 -y xvid4 -o porco.avi
```

Normal encoding :
```bash
transcode -i /dev/dvd -T 2,-1 -a 1 -j 70,0,70,0 -Z 720x306 -o poignards.avi -y xvid4
```
	
Multiple pass encoding :
First pass :
```bash
transcode -i /dev/dvd -T 2,-1 -a 1 -j 70,0,70,0 -Z 720x306 -R 1 -y xvid4,null
```
Second pass :
```bash
transcode -i /dev/dvd -T 2,-1 -a 1 -j 70,0,70,0 -Z 720x306 -R 2 -o poignards.avi -y xvid4
```

	-R 3 : constant quantizer encoding
	For -R 2 : -w bitrate
	For -R 3 : -w quantizer (1..31) (1=perfect, 31=bad)
	-C 3 : anti-aliasing

### tcextract

Extract sub-titles:
```bash
tccat -i /dev/dvd -T 2 -L | tcextract -x ps1 -t vob -a 0x21 > subs-fr
```

Pour un format vob :
```bash
Subtitle2vobsub
```

Pour un format srt :
```bash
subtitle2pgm -o french -c 255,255,0,255 < subs-fr
pgm2txt -v -f fr french
srttool -s -w < french.srtx > french.srt
aspell --lang=french --encoding=iso8859-1 french.srt
```

### mkvmerge

Pour les .srt s'assurer que le fichier est bien encodé en UTF-8. Exemple :
```bash
cat Le\ Secret\ des\ Poignards\ Volants.fr.srt | perl -e 'binmode (STDOUT, ":utf8"); while(<STDIN>) { print $_; }' > poignards.fr.srt

mkvmerge -o Le\ Secret\ des\ Poignards\ Volants.mkv Le\ Secret\ des\ Poignards\ Volants.avi --language 0:fre Le\ Secret\ des\ Poignards\ Volants.fr.srt

mkvmerge -o Dial\ M\ For\ Murder.mkv dialm.avi --language 0:eng --language 1:fre dialm.idx

mkvmerge -o Shrek\ 2.mkv Shrek\ 2.avi --language 0:eng --language 1:fre Shrek\ 2.idx

mkvmerge -o Robin\ Hood.mkv -A Robin\ Hood.avi Robin\ Hood.ogg --language 0:eng --language 1:fre Robin\ Hood.idx

mkvmerge -o "Breakfast at Tiffany's.mkv" --aspect-ratio 16/9 -A breakfast.avi breakfast.ogg --language 0:eng --language 1:fre breakfast.idx
```

Pour s'assurer qu'un fichier srt est en utf8:
```bash
Perl -e 'binmode (STDOUT, ":utf8"); while(<STDIN>) { print $_;}' <input.srt >output.srt
```

### mencoder

With mencoder, we can use the vbitrate option to set the degree of lossy compression. Note that the default mpeg4 option will add a "DivX" logo to the movie when playin in windows media player, so we prefer to use one of the other mpeg4 encoders, such as msmpeg4 or msmpeg4v2. The commmand line I've used is:

```bash
mencoder "mf://*.jpg" -mf fps=10 -o test.avi -ovc lavc -lavcopts vcodec=msmpeg4v2:vbitrate=800 
```
	

### youtube-dl

Download a youtube video:
```sh
youtube-dl "https://www.youtube.com/watch?v=JVzyoMDF9JA&feature=emb_title"
```

Set output file name:
```sh
youtube-dl -o myfile.mp4 "https://www.youtube.com/watch?v=JVzyoMDF9JA&feature=emb_title"
```

Output file name may be a template, see manpage.

## aspell

To decompress a words list from installation tar.bz2 file:
```sh
precat *.cwl
preunzip *.cwl
```

To have correct UTF-8 handling by *aspell*, the `LC_CTYPE` locale environment variable must be set accordingly:
```sh
export LC_CTYPE=UTF-8
# or
export LC_CTYPE=en_US.UTF-8
```

To dump full list of words for a language:
```sh
aspell -l fr dump master
```

## Programming

### pkg-config

List all supported packages:
```bash
pkg-config --list-all
```

Get include directory:
```bash
pkg-config --variable=includedir axis2c
```

Get library directory:
```bash
pkg-config --variable=libdir axis2c
```

## Terminals and consoles

### Enabling 256 colors in Linux kernel console

Install `kmscon`.
On ArchLinux:
```bash
sudo pacman -S kmscon
```

The in console:
```bash
sudo kmscon
```
Which will start `login` process and once logged in, `TERM` will be defined as `xterm-256colors` even if not in X.

Starting X from kmscon:
	`startx` won't work.
	See <https://github.com/dvdhrm/kmscon/issues/103>. Maybe something like `startx -- vt8`.

## tmux

For reloading the config file inside current tmux session, run the following command in shell:
```bash
tmux source-file ~/.tmux.conf
```

Change window name/title from a bash script:
```bash
echo $'\ekMYTITLE\e\\'
```
Use script name as title:
```bash
echo $'\ek'$(basename $0)$'\e\\'
```
For this to work, you must first enable renaming:
```tmux
set -g allow-rename on
```

### Prefix

Prefix is by default `C-b`.

Set prefix:
```
unbind C-b
set -g prefix C-a
bind C-a send-prefix
```

### Attaching and detaching

Reattach an already attached session:
```bash
tmux attach -d
```

Command    | Description
---------- | ----------------------
`prefix d` | Detach.

### Windows & panes

Command                   | Description
------------------------- | ----------------------
`prefix d`                | Detach.
`prefix ,`                | Rename current window.
`prefix "`                | Split pane horizontally.
`prefix %`                | Split pane vertically.
`prefix arrow key`        | Switch pane.
`prefix {`                | Swap current pane with previous pane.
`prefix }`                | Swap current pane with next pane.
`prefix c`                | Create a new window.
`prefix n`                | Move to the next window.
`prefix p`                | Move to the previous window.
`prefix Ctrl-o`           | Rotate panes in increasing order.
`prefix Alt-o`            | Rotate panes in decreasing order.
`prefix q`                | Show pane number.
`prefix &`                | Kill window.
`prefix x`                | Kill pane.
`prefix <space>`          | Toggle between layout.
`prefix Esc-1`            | Select layout 1 even-horizontal
`prefix Esc-2`            | Select layout 2 even-vertical
`prefix Esc-3`            | Select layout 3 main-horizontal
`prefix Esc-4`            | Select layout 4 main-vertical
`prefix Esc-5`            | Select layout 5 tiled
`prefix +`                | Break pane into window
`prefix -`                | Restore pane from window

Resize the current pane down:
```
resize-pane -D
resize-pane -D 20
```
Use `-U` for upward, `-L` for left and `-R` for right.


Swap two windows:
```
swap-window -s 3 -t 1
```

Swap current window with a specific window:
```
swap-window -t 1
```

Split current pane and use window 4 as second pane:
```
join-pane -s 4
```

### Binding keys

Grabs the pane from the target window and joins it to the current:
```
bind-key j command-prompt -p "join pane from:"  "join-pane -s '%%'"
```

### Plugins

 * [Battery plugin](https://github.com/tmux-plugins/tmux-battery).

## Terminal common key shortcuts

	^ = CTRL
	
	^C      Terminate process
	^A      Go to beginning of line
	^E      Go to end of line
	^K      Cut from current cursor position to end of line
	^U      Cut from current cursor position to beginning of line
	^W      Same as ^U ?

## test / [

File test operators:

Flag | Description
---- | -------------------
`-e` | File exists.
`-a` | File exists (deprecated).
`-f` | File is a regular file (not a directory or device file).
`-s` | File is not zero size.
`-d` | File is a directory.
`-b` | File is a block device.
`-h` | File is a symbolic link.
`-L` | File is a symbolic link.
`-r` | File has read permission (for the user running the test).
`-w` | File has write permission (for the user running the test).
`-x` | File has execute permission (for the user running the test).

```bash
if test -z "$var" ; then
	echo empty var
fi
```

You can use '[' instead of 'test'.
Be careful to put spaces before and after [ and ], because [ is a real command and ] is a real argument
```bash
if [ -z "$var" ] ; then
	echo empty var
fi
```

Compare integers:
```bash
if [ $v -eq 1 ] ; then
	echo yesh
fi
```

Grouping expressions:
```bash
if [ "$a" = 'x' -a '(' "$b" = 'y' -o "$c" = 'z' ')' ] ; then
	echo yesh
fi
```

## install

It has the interesting property of changing the ownership of any file it copies to the owner and group of the containing directory. So it automatically sets the owner and group of our installed files to root:root if the user tries to use the default /usr/local prefix, or to the user’s id and group if she tries to install into a location within her home directory.

Create directories:
```bash
install -d mydir
```

Install file:
```bash
install src_file dst_file
```

Install several files in a directory:
```bash
install src_file_1 src_file2 ... dst_directory
```

Setting mode (by default set to `rwxr-xr-x`):
```bash
install -m <MODE> ...
```

## vercmp

On ArchLinux, the `vercmp` script is available for  comparison versions:
```bash
if [ $(vercmp $myver $requiredver) -ge 0 ] ; then
	# Wrong version
	# ...
fi
```

## mount

Monter un fichier iso en disque pour explorer son contenu :
```bash
mount -o loop file.iso <folder>
```

## xargs

Flag        | Description
----------- | -------------------------------
-I replstr  | Use a replace string, instead of appending arguments to the end of the command.

Execute the command with one argument at a time:
```bash
my_command | xargs -n 1 chmod a-x
```

To use \0 for strings separator instead of spaces or newlines:
```bash
... | xargs -0 ...
```

To place the arguments at a specified place instead of appending them, use the `-I` flag. The replace_string must be a distinct argument to xargs, it can't be inside a string for instance or it will not be replaced.
```bash
/bin/ls -1d [A-Z]* | xargs -I % cp -rp % destdir
```

## redshift

Control color temperature of display.

```bash
redshift -l geoclue2 -t 5700:3600 -g 0.8 -m randr -o
```
Use `-p` instead of `-o` to just print what the temperature will be set to.

Use `~/.config/redshift.conf` file to set configuration. See man page.

## su & sudo

Login as root user and stay in current directory:
```bash
su
```

Login as root user inside root's home directory:
```bash
su -
```

Editing a file:
```bash
sudo -e /etc/some/system/filerc
```

Running a shell:
```bash
sudo -s
```

Running a command:
```bash
sudo <command>
```

## zenity

Opens a dialog box and possibly get user input.
```bash
zenity –question –title="Query" –text="Would you like to run the script?"
```

## crontab

To edit user's own crontab:
```bash
crontab -e
```

Environment variables already set by cron:

Variable    | Value
----------- | --------------------
`PATH`      | `/usr/bin:/bin`.
`HOME`      | From `/etc/passwd`.
`LOGNAME`   | From `/etc/passwd`.
`SHELL`     | `/bin/sh`.

To receive mails with output of run commands, you must set the `MAILTO` variable:
```crontab
MAILTO="username" # local mail
```
or
```crontab
MAILTO="someone@mail.server"
```

The format of a crontab line is `m h d M D command`, where 5 first fields define the time when to run the specified command.

Description of the five time fields, in order:

field        | allowed values
------------ | --------------
minute       | 0-59
hour         | 0-23
day of month | 1-31
month        | 1-12 (or names, see below)
day of week  | 0-7 (0 or 7 is Sun, or use names)

Ranges can be specified
```crontab
0 6-11 * * * command
```
Command will be run each day from 6 to 11 o'clock.

Several values or ranges can be separated by commas
```crontab
0 6,10,18 * * * command
```
Command will be run each day at 6:00, 10:00 and 18:00

Timesteps can be specified using a slash: `*/5`.

Run command each day at 9:00 and 21:00:
```crontab
0 9-23/12 * * * command
```

Run a command every 2 hours:
```crontab
0 */2 * * * command
```

## gettext

 * [GNU gettext utilities](https://www.gnu.org/software/gettext/manual/gettext.html).

Internationalization of applications.

Create a template file by extracting strings to translate from the code:
```bash
xgettext --from-code=UTF-8 -o messages.pot *.php
```

## winehq (wine and winetricks)

 * [WineHQ](https://www.winehq.org/).

Default prefix is `~/.wine`.

Install .NET 4.5:
```sh
winetricks dotnet45
```

Remove wine installation:
```sh
winetricks annihilate
```

Run a program:
```sh
wine myprog.exe
```

## Numbers (calculate and compute)

### seq

Generate a sequence of numbers:
```bash
seq 4 # --> 1 2 3 4
seq 100 104 # --> 100 101 102 103 104
```

### bc

Set the number of decimals to print for output:
```bc
scale=2
```
By default only integer parts are printed (zero decimals).

`;` can be used to separate instructions.
```bc
scale=3;print 1.2356
```

Taking the integer part of a number:
```bc
scale=0;print 1.23
```

### calc

For printing a number in hexadecimal base:
```
base(16),134525
```

### expr

Measure length of a string:
```bash
expr 'abcd' : '.*'
```


## Installing another UNIX like system on a Mac

 * [The rEFInd Boot Manager](http://www.rodsbooks.com/refind/).
 * [Single boot Linux on an Intel Mac Mini](https://major.io/2011/01/26/single-boot-linux-on-an-intel-mac-mini/).
 * [MacMiniIntel, Installing Debian on a Mac Mini](https://wiki.debian.org/MacMiniIntel)
 * [Single boot Gentoo mac mini](https://forums.gentoo.org/viewtopic-p-7128354.html).

Use CD install with non-free firmware included: <https://cdimage.debian.org/cdimage/unofficial/non-free/cd-including-firmware/current/amd64/iso-cd/>.

Bootloader:
 * Macs use EFI bootloader.
 * Standard Grub and LILO don't do EFI.
 * Grub2 may do EFI -> to check.
 * See [rEFIt](http://refit.sourceforge.net/).
 * See also [rEFInd](http://www.rodsbooks.com/refind/) that is based on rEFIt with Macs consideration.
 * More precisely the MacMini 3,1 boots into EFI mode when booting from USB device, and into BIOS Compatibility mode when booting from CD/DVD.

Gentoo:
 * [Gentoo Linux in Mac Mini 2009, soundcard issue](https://forums.gentoo.org/viewtopic-t-749525-start-0.html).


## keyctl

List keys in keyring:
```sh
keyctl show
```

## Graphics

### exiftool

Package `perl-image-exiftool` on ArchLinux.

Read EXIF information:
```bash
exiftool myfile.jpeg
```

Remove a orientation information:
```bash
exiftool -Orientation= myfile.jpeg
```

### masterpdfeditor

A powerful GUI PDF editor.

### pdftk

A PDF tool.

Reverse order of pages:
```sh
pdftk my.pdf cat end-1 output my_reversed.pdf
```

Merge a PDF containg odd pages with a PDF containg even pages:
```sh
pdftk A=odd.pdf B=even.pdf shuffle output merged.pdf
```

### pdfcrack

Tool for cracking user password and/or owner password in PDF files.

```bash
pdfcrack myfile.pdf
```

### pdfimages

From package xpdf or poppler.

Extract images from PDF:
```bash
mkdir myfolder
pdfimages -j myfile.pdf myfolder/myprefix
```

### pdfunite

Concatenate multiple PDF files:
```sh
pdfunite a.pdf b.pdf c.pdf out.pdf
```

### pdfarranger

Reorganize PDF file (delete pages, move pages, ...)

### convert (ImageMagick)

Resize to 50%:
```bash
magick convert -resize 50% input.jpg output.jpg
```

Make a PDF from images:
```bash
magick convert *.jpg myfile.pdf
```

Image quality for jpeg and mpeg (1 lowest, 100 best):
```bash
magick convert -quality 60% input.jpg output.jpg
```
See <http://www.imagemagick.org/script/command-line-options.php#quality>.

Convert to gray scale:
```bash
magick convert -colorspace Gray input.jpg output.jpg
```

```bash
for f in *ppm ; do convert -quality 100 $f `basename $f ppm`jpg; done 
```

Rotate 180 degrees:
```bash
magick convert -rotate 180 input.jpeg output.jpeg
```

### dia

Key shortcuts:
	Ctrl E : Fit diagram on screen
	Ctrl + : Zoom in
	Crtl - : Zoom out
	Arrows : Move diagram
Export to a file and exit:
```sh
dia -e <output_file> -t <format> <input_file>
```
Formats:
	cgm (Computer Graphics Metafile, ISO 8632)
	dia (Native dia diagram)
	dxf (Drawing Interchange File)
	eps or eps-builtin or eps-pango (Encapsulated PostScript) The format specifications eps and eps-pango both use the font renderer of the Pango library, while eps-builtin uses a dia specific font renderer. If you have problems with Pango rendering, e.g. Unicode, try eps-builtin instead.
	fig (XFig format)
	mp (TeX MetaPost macros)
	plt or hpgl (HP Graphics Language)
	png (Portable Network Graphics)
	shape (Dia Shape File)
	svg (Scalable Vector Graphics)
	tex (TeX PSTricks macros)         --> BAD OUTPUT, the figure is full of bugs.
	wpg (WordPerfect Graphics)
	wmf (Windows MetaFile)

Remove splash screen:
```sh
dia -n ...
```

#### dia under macos

Under MacOS-X, dia is no more available in Homebrew.
A MacOS-X integrated version must be downloaded and installed.

Unfortunately it doesn't allow to use options from command line.
The script /Applications/Dia.app/Contents/Resources/bin/dia that launches dia-bin, doesn't accept arguments.
The solution is to modify the last line of the script so it allows passing of arguments and doesn't run in GUI mode by default.
```sh
exec "$CWD/dia-bin" --integrated
```
becomes:
```sh
# From MacOS-X GUI, dia script is called with the command "dia -psn_0_??????"
if [ $# -gt 1 ] ; then
	"$CWD/dia-bin" "$@"
else
	exec "$CWD/dia-bin" --integrated
fi
```
Then add `/Applications/Dia.app/Contents/Resources/bin` to the PATH.

### vimiv

 * [vimiv](https://karlch.github.io/vimiv-qt/documentation/index.html).

Config dir: `$XDG_CONFIG_HOME/vimiv/`.

General keys:
	`gi`    Enters image mode.
	`gl`    Enters library mode.
	`gt`    Enters thumbnail mode.
	`gm`    Enters manipulate mode.

Keys:
	`+`     Zoom in
	`-`     Zoom out
	`n`     Next image
	`p`     Previous image
	`gg`    First image
	`G`     Last image
	`h`     Scroll image
	`j`     Scroll image
	`k`     Scroll image
	`l`     Scroll image
	`w`     Fit window size
	`e`     Fit horizontally
	`E`     Fit vertically
	`ss`    Start slideshow
	`sh`    Decrease speed of slideshow
	`sl`    Increase speed of slideshow
	`>`     Rotate right.
	`<`     Rotate left.
	`|`     Flip vertically.
	`_`     Flip horizontally.

## X11 & other graphical display managers

 * [256 Xterm 24bit RGB color chart](http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html).
 * [X colors rgb.txt decoded](http://sedition.com/perl/rgb.html).

### mimeapps.list

`~/.config/mimeapps.list` defines default applications for MIME types.
It defines the browser to use when clicking a link in the terminal.

### Take screenshots

 * [Take pictures of the screen on your Mac](https://support.apple.com/en-sa/KM204852?cid=acs::applesearch).

macOS Command     | Description
----------------- | -----------------
Shift-Cmd-3       | Whole screen.
Shift-Cmd-4       | Zone.
Shift-Cmd-4-Space | Window.

The PNG picture is written on the desktop.

### Window managers and desktop environements

Installing Ubuntu graphical desktop:
```bash
sudo apt-get install ubuntu-desktop
sudo shutdown -r now
```

### Init scripts

 * [Difference between .xinitrc, .xsession and .xsessionrc](https://unix.stackexchange.com/questions/281858/difference-between-xinitrc-xsession-and-xsessionrc).
 * [Xsession](https://wiki.debian.org/Xsession), on Debian.

`.xinitrc` is part of X11. It is used when starting GUI from the console (using `startx`, that calls `xinit`, which parse `.xinitrc`).

`.xsession` is part of X11. It is read at GUI login, from a display manager. Beware that you must tell the display manager to invoke the "custom" session type.
On Debian the `xsession` is not parsed but executed in order to run the window manager.

`.xsessionrc` is specific to Debian and Ubuntu.

`.xprofile` is specific to GDM (Gnome).

### Touchpad

 * [Enable tap to click in i3 WM](https://cravencode.com/post/essentials/enable-tap-to-click-in-i3wm/).

### XDG

 XDG = X Desktop Group

 * [freedesktop.org](https://www.freedesktop.org/wiki/).
 * [xdg-utils](https://www.freedesktop.org/wiki/Software/xdg-utils/).

Default trash directory: `$XDG_DATA_HOME/Trash`.

#### xdg-settings

Get and set settings for the desktop environment.

Get default browser:
```sh
xdg-settings get default-web-browser
```

Change default browser:
```sh
xdg-settings set default-web-browser firefox.desktop
```

#### xdg-open 

Opens a file with the preferred user's application.

### xset

Set user preferences for X.

Get current settings:
```sh
xset q
```

Set DPMS (Display Power Management Settings / Energy Star):
```sh
xset dpms 240 480 720 # standby suspend off (in seconds)
```

### xrdb

Load Xresources file.

Load values and merge with current settings:
```sh
xrdb -merge ~/.Xresources
```

Load values and replace current settings:
```sh
xrdb ~/.Xresources
```

Print current values:
```sh
xrdb -query -all
```

### xrandr

Setup external screens for use. Improvement of xinerama.

To get a list of available screens:
```sh
xrandr
```

To use a screen:
```sh
xrandr --output HDMI-2 --auto --right-of eDP1
```

To disable a screen:
```sh
xrandr --output DP-1-2 --off
```

Create a virtual monitor from two monitors:
```sh
xrandr --setmonitor NameOfDisplay auto HDMI-A-0,HDMI-A-1
```

### i3wm

 * [i3](https://i3wm.org/).

Basic commands:
	$mod+<Enter> open a terminal
	$mod+d open dmenu (text based program launcher)
	$mod+r resize mode ( or to leave resize mode)
	$mod+shift+e exit i3
	$mod+shift+r restart i3 in place
	$mod+shift+c reload config file
	$mod+shift+q kill window (does normal close if application supports it)

Windows layout:
	$mod+w tabbed layout
	$mod+e vertical and horizontal layout (switches to and between them)
	$mod+s stacked layout
	$mod+f fullscreen
	$mod+shift+<direction key> Move window in direction (depends on direction keys settings)

### xmonad

 * [xmonad](https://xmonad.org/).
 * [XMonad.Doc.Configuring](https://hackage.haskell.org/package/xmonad-contrib-0.16/docs/XMonad-Doc-Configuring.html) --> how to write an xmonad configuration.
 * [Xmonad default bindings](https://wiki.haskell.org/File:Xmbindings.png).

`mod` is left Alt by default.

Default commands:
	mod-shift-return    Open terminal
	mod-shift-q         Quit xmonad
	mod-q               Compile and reload configuration
	mod-space           Cycles through tiling algorithms.
	mod-j               Move focus to previous window
	mod-k               Move focus to next window
	mod-,               Increase the number of windows in the master pane
	mod-.               Decrease the number of windows in the master pane
	mod-return          Swap focused window with window in master pane
	mod-shift-j         Swap focused window with next window
	mod-shift-k         Swap focused window with previous window
	mod-h               Increase/Decrease window size
	mod-l               Increase/Decrease window size
	mod-button1         Drag a window and make it float
	mod-t               Put back a floating window into the tiling layer.
	mod-button2         Bring floating window to the top
	mod-button3         Resize floating window
	mod-shift-c         Kill window
	mod-p               Open dmenu
	mod-n               Switch to workspace n (1-9)
	mod-shift-n         Move focused window to workspace n (1-9)

Compile configuration file:
```sh
xmonad --recompile
```

### Xfce

Installing on Debian, see <https://wiki.debian.org/Xfce>:
```bash
apt-get install xfce4
#apt-get install xfce4-goodies
#apt-get install task-xfce-desktop
```

Installing on ArchLinux:
```bash
pacman -S xorg
pacman -S extra/xfce4
```

Packages/plugins:
```bash
extra/thunar # Thunar file manager.
extra/xfce4-battery-plugin # Battery plugin
extra/xfce4-pulseaudio-plugin # Audio
extra/xfce4-power-manager # Power management
extra/xfce4-screenshooter # Screen shots
```

How to modify key shortcuts for file manager Thunar:
 * Edit file `~/.config/Thunar/accels.scm`.
 * For changing rename key from F2 to Return, find line with F2 key, and replace it with `"<>Return"`.
 * Quit Thunar: `thunar -q`.
 * Re-open Thunar.

### Screen saver, locking and energy saving

Under macOS:
```bash
/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend
```

Under Linux Xfce4:
```bash
xflock4
```

### Fonts
	
Getting list of fonts:
```bash
xlsfonts
```

Open a window and display characters of a font:
```bash
xfd -fn fontname
```

After installing a font run the following command in order to reload the fonts list dynamically:
```sh
xset fp rehash
```

Selecting a font using "X logical font description":
```sh
xfontsel
```

### xterm

Nice font:
```bash
xterm -fa monaco
```

Enable 16 colors:
```bash
export TERM=xterm-color
```

Enable 256 colors:
```bash
export TERM=xterm-256color
```

To set background color:
```bash
xterm -bg black
```

Enable cursor blinking:
```bash
xterm -bc
```

Set cursor color:
```bash
xterm -cr white
```

### urxvt

 * [Configuring URxvt to Make It Usable and Less Ugly](https://addy-dclxvi.github.io/post/configuring-urxvt/).

Help:
```sh
man urxvt # main manpage
man 7 urxvt # reference, FAQ
```

Press M-s (Alt-s) to search in scrollback.

### xsel

 A clipboard manager.
 Can be used in combination with urxvt, since urxvt has no copy&paste feature by default (it needs a perl extesion). See [Configuring URxvt to Make It Usable and Less Ugly](https://addy-dclxvi.github.io/post/configuring-urxvt/).

### xscreesaver

 * [XScreenSaver](https://wiki.archlinux.org/index.php/XScreenSaver).

To configure:
```sh
xscreensaver-demo
```

To run xscreensaver automatically, add the following line in `~/.xinitrc`:
```sh
xscreensaver -no-splash &
```

Once the daemon is started, call `xscreensaver-command` to control it.

To run immediatly:
```sh
xscreensaver-command -activate
```
### unclutter

 * [Auto Hide Mouse Pointer Using Unclutter After A Certain time](https://ostechnix.com/auto-hide-mouse-pointer-using-unclutter-after-a-certain-time/).

