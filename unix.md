UNIX
====

These notes refer to UNIX and Linux operating systems.

 * [Debian](https://www.debian.org).
 * [CentOS](https://www.centos.org).
 * [Arch Linux](https://www.archlinux.org/).

## Network

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

### wget

Download recursively:
```bash
wget -r http://some.site.fr/
```

Resume a download:
```bash
wget -c http://some.site.fr/myfile.zip
```

```bash
wget -i blabla -o zop http://fsgjkbnkfjg.bgjnfdgb/dfbkjgn.xml
```

Quiet:
```bash
wget -q -O myfile.html http://jfvndfjvndf/fdj.html
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

Synchronize locally with a IMAP account.
Can use a mail app to access local mail boxes.

Install on MacOS-X:
```bash
brew install offline-imap
```

 * [Folder filtering and Name translation](https://offlineimap.readthedocs.org/en/latest/nametrans.html).
 * [Use Mac OS X's Keychain for Password Retrieval in OfflineIMAP](https://blog.aedifice.org/2010/02/01/use-mac-os-xs-keychain-for-password-retrieval-in-offlineimap/).

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
```bash
set sendmail="/usr/local/bin/msmtp"	# for normal msmtp
```

Using queuing in Mutt:
```bash
mkdir $HOME/.msmtp.queue
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
rsync -av --delete teddy:/home/data/documents .
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

### NTP, Network Time Protocol

 * [NTP configuration on Debian](https://wiki.debian.org/NTP).
 python3=$python36

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
```bash
dhclient -r enp2s0 # Revoke
dhclient enp2s0    # Obtain a new lease
```

### Wifi

Get wifi status on Debian:
```bash
nmcli radio wifi
```

Turn off wifi on Debian:
```bash
nmcli radio wifi off
```

Get help:
```bash
nmcli radio wifi help
```

### Samba

To setup Samba under macOS, declare the workgroup:
	System Preferences -> Network -> [your network device] -> Advanced -> WINS -> Workgroup
The path from a Windows computer is:
	\\<server name\<shared folder>

## System

### Installing

 * [How to reinstall macOS](https://support.apple.com/en-us/HT204904).
 * [Create a bootable USB stick on macOS](https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-macos?_ga=2.233519964.315784058.1525944550-1342623189.1521968110#0).
 * [Radeon kernel modesetting for r600 or later requires firmware-amd-graphics](https://joshtronic.com/2017/11/06/fixed-radeon-kernel-modesetting-for-r600-or-later-requires-firmware-amd-graphics/).

To upgrade to macOS High Sierra on a computer running with mac OS X Lion, one must first upgrade to OS X El Capitan. Use this [link](https://support.apple.com/en-us/HT206886) to download OS X El Capitan.

### Booting, starting and stoping

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
 
Putting a machine to sleep in Debian:
```bash
systemctl suspend
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

Shutdown an Alpine machine:
```bash
poweroff
```
Other commands: `reboot` and `halt`.

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

Add a user to a group in Linux:
```bash
usermod -a -G somegroup someuser
```

Get user UID and all groups to which he belongs:
```bash
id
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


### Hardware

Get list of PCI devides in Debian:
```bash
lspci
```

Get list of USB devices in Debian:
```bash
lsusb
```

 * [Use Apple’s USB SuperDrive with Linux](https://christianmoser.me/use-apples-usb-superdrive-with-linux/).

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

## Password managers

 * [pwsafe](https://github.com/nsd20463/pwsafe). Works in command line.

 * `keepass` password manager. Has an interactive command line interface: `kpcli`.
 * [KeePassC](http://raymontag.github.io/keepassc/). A command line interface to keepass.

`pass` password manager (too much complex, needs GPG setup):
 * [Pass](https://www.passwordstore.org/).
 * [Pass tutorial](http://www.tricksofthetrades.net/2015/07/04/notes-pass-unix-password-manager/).

Setting a password inside the keychain in macOS:
```bash
sudo /usr/bin/security -v add-internet-password -a pierrick.rogermele@icloud.com -s mail.icloud.com -w 'mypassword' 
```

Getting a password stored in the keychain on macOS:
```bash
security find-internet-password -w -a pierrick.rogermele@icloud.com
```
## File system

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

### du

To measure disk usage of a folder:
```bash
du -shc <folder>
```

See also:
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

### chmod

When the sgid bit is set on a directory, all files & dirs created in this directory will automatically have the same group as the directory:
```bash
chmod g+s mydir
```

Set execute/search flag for directories only:
```
chmod -R g+X mypath
```

### umask

`umask` set the default permissions for new files.

### ls

BSD ls and GNU ls are different.
GNU ls command is part of the coreutils package.

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

### which

The `which` command returns the path of a command. If the command cannot be found, an error is returned.

On BSD/macOS `which` has a silent option:
```bash
which -s myprog
```

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

## File viewing, formating and editing

### column

Align the column of a file for viewing:
```bash
column -t myfile
```
By default the columns are considered separated by white spaces (space and tab).

If you have a csv file:
```bash
column -t -s , myfile
```

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

## File filtering

### tr

Set in uppercase:
```bash
tr '[:lower:]' '[:upper:]'
```

Removing all carriage returns:
```bash
tr -d '\r'
```

### dos2unix

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

### sort

Sorting inplace:
```bash
sort myfile -o myfile
```

In MacOS-X, sort will not recognize unicide in UTF-8 files.
One must use iconv first to convert file into UTF8-MAC format:
```bash
iconv -t UTF8-MAC myfile.txt | sort
```

### split

Split a big file into several one giga bytes files:
```bash
split -b 1G myfile.bin myfile
```

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

### paste

Paste two or more files side by side:
```bash
paste a.txt b.txt c.txt >d.txt
```
By default, replace new line chars in a.txt and b.txt by tabulation.

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

To edit in-place:
```bash
sed -e mycommand -i .bkp myfile # save backup with .bkp extension
sed -e mycommand -i '' myfile # no backup
```

To edit the first line only:
```bash
sed -e '1s/foo/bar/g' myfile
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


### uniq

Filter out duplicated lines:
```bash
uniq myfile
```

Output only the duplicated lines:
```bash
uniq -d myfile
```

### awk

#### Running

Run an Awk script:
```bash
awk -f myscript.awk
```

Run on a file:
```bash
awk '// { print $0 }' myfile
```

Passing variables:
```bash
awk -v var=value ...
```

Use a shebang:
```awk
#!/usr/bin/env awk -f
{ print $1 }
```

#### Records and rules

Rules apply on record (a record is a line, by default, depending of the definition of the record separator (`RS`)).

General form of a rule is `[pattern] [{ action }]`.

All rules are processed in order, one after the other.
The 'next' statement can be used to stop processing rules and pass to the next record.
```awk
/some regexp patterm/ { next }
```

Any expression can be used for a pattern, if it is true, the rule is executed:
```awk
expression {}
```

A pattern can be a regular expression:
```awk
/regular expression/ {}
```

Range pattern:
```awk
pat1, pat2 {}
```

Start and end patterns:
```awk
BEGIN { print "START !" }
END { print "DONE !" }
```

The null pattern matches every input record:
```awk
{print} 
```

A pattern can be negated:
```awk
! /regexp/
```

Patterns can be combined:
```awk
/regexp1/ && /regexp2/
/regexp1/ || /regexp2/
```

#### Regex

The match function can be used in a pattern expression to get captured group in a regular expression:
```awk
match($NF, /^([0-9]+)h$/, g) { time += g[1] }
```

Regexp on a particular field:
```awk
$2 ~ /ddd/
$3 !~ /aa/
```

#### Strings

Getting length:
```awk
{ l = length(s) }
```

Lowercase:
```awk
{ lc = tolower(s) }
{ uc = toupper(s) }
```

Split a string:
```awk
{ number_of_elements = split(string, array, fieldsep) }
```

#### Function

Declaration:
```awk
function name (parameters) {
	# body
}
```	
All other variables (global) are normally accessible from inside a function body, and thus can be modified.

The parameters contain : the arguments passed to the function AND the local variables declaration.

The parameters declared (arguments and local variables) hide the global variables of the same name.

The parameters that don't receive a value from the function caller, are set to the null string.

A common practice is to separate arguments and local variables declarations by spaces in the function header.

```awk
function abs(v) { return v < 0 ? -v : v }
```

#### Built-in variables

`FILENAME` is the name of the current file:
```awk
{print FILENAME;}
```

`NR` is the row number (from the start of input):
```awk
{if (NR!=1) {print}}
```

`NFR` is the row number inside the current file:
```awk
{print FILENAME, FNR;}
```

`NF` is the number of fields in a record (i.e.: row):
```awk
{print NF;}
```

Input field separator (space by default):
```awk
BEGIN{FS = "\t"}
```

Input record separator (end-of-line by default):
```awk
BEGIN{RS = ";\n"}
```

Output field separator (space by default):
```awk
BEGIN{OFS = "\t"}
```

Output record separator (end-of-line by default):
```awk
BEGIN{ORS = ";\n"}
```

#### Getting command line arguments

For Awk, the command line arguments are a list of files.
To get the filename currently being processed by Awk, use the built-in variable `FILENAME`:
```awk
{ print FILENAME }
```

Reading command line arguments:
```awk
BEGIN {
	for (i = 1; i < ARGC; i++)
		printf "%s ", ARGV[i]
	printf "\n"
}
```

The problem is that awk interprets command line arguments as files, and try to open them.
The only exception is when a argument is of the form `var=value`, in which case awk will set the variable `var` to the value "value".
A cleaner way to do this is to use the `-v` option:
```bash
awk -v var=value
```

#### Statements

##### If

```awk
{ if (NR == 3) { print } }
{ if (NR > 1 && ) { print } }
```

##### Switch
	
The switch statement is an optional statement for the GNU version of Awk, that must be included at compile time with the option --enable-swtich passed to configure script.

#### Removing columns

```awk
{$1=$2="";sub("  "," ")}1
```

Removing 8th column, using tabulation as a separator:
```awk
BEGIN{FS=OFS="\t"} {$8="";sub("\t\t","\t")}1
```

#### Print

Printing fields:
```awk
print a, b, c, d
```

Print fields and strings:
```awk
print $2":"$3":"$4" "$5"-"$6
```

Extract first column:
```bash
awk '{print $1}' spiid-inchi.txt >myids.txt
```

Remove duplicates on output:
```bash
awk '!x[$0]++'
```

#### Mathematical operations

Take absolute value:
```awk
function abs(v) { return v < 0 ? -v : v }
{ printf("%f\n", abs($1-$2)) }
```

Summing on a column:
```awk
{ sum += $2 }
END { print sum }
```

Taking the integer part of float:
```awk
{ i = int(f) }
```

Rounding a float to an integer:
```awk
{ i = int(f + 0.5) }
```

#### Arrays

In awk arrays are associative.
	
Looping on an (numerically) indexed array:
```awk
for (i = 1 ; i <= size_of_array ; ++i)
	print array[i]
```

Looping on array indexes:
```awk
for (k in array)
	print k
```

Sorting an array (the array must be numerically indexed):
```awk
{ n = asort(array) } # n is the number of elements of the array
{ n = asorti(array) } # case insensitive
```

## Power management

### pmset

BSD command.

Get battery information:
```bash
pmset -g batt
```

## Package management

### Homebrew / brew

 * <http://mxcl.github.com/homebrew/>.
 * <https://github.com/mxcl/homebrew/>.

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

Install Xcode command line tools:
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

### dpkg

Install a package archive `.deb`:
```bash
dpkg -i mypkg.deb
```

### alien

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



## Media

### Sound configuration

Configure sound on Debian with ALSA system:
```bash
alsactl init
```

### mplayer

	-dvd-device /dev/hdd	: set dvd device
	Dvd://1			: read track 1 of DVD
	-ss 0:16:00		: start at position "16 minutes after the beginning"
	-aid <ID>		: select audio channel by ID (0x80, 0x81, ...)
	-alang code		: select audio channel by language code (fr, en, ...)
	-fs			: fullscreen

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

### pdfimages

From package xpdf or poppler.

Extract images from PDF:
```bash
mkdir myfolder
pdfimages -j myfile.pdf myfolder/myprefix
```

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
For f in *ppm ; do convert -quality 100 $f `basename $f ppm`jpg; done 
```

### dd

To make an ISO from your CD/DVD, place the media in your drive but do not mount it. If it automounts, unmount it.
```bash
dd if=/dev/dvd of=dvd.iso # for dvd
dd if=/dev/cdrom of=cd.iso # for cdrom
dd if=/dev/scd0 of=cd.iso # if cdrom is scsi 
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

## tmux

Reload config file from within tmux:
```tmux
source-file ~/.tmux.conf
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
`prefix "`                | Split pane horizontally.
`prefix %`                | Split pane vertically.
`prefix arrow key`        | Switch pane.
`prefix {`                | Move pane to previous position.
`prefix }`                | Move pane to next position.
`prefix c`                | Create a new window.
`prefix n`                | Move to the next window.
`prefix p`                | Move to the previous window.

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

## a2ps

```bash
A2ps -4 -A fill file1.txt file2.txt file3.txt -o output.ps
```
	-4 :		4 pages virtuelles par page
	-A fill :	mettre les fichiers les uns à la suite des autres sur une même page

## `test` / `[`

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

## diff

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

## patch

Patching a source tree:
```bash
patch -p1 < patch-file-name-here
```

Patching a file:
```bash
patch original_file patch_file
```

## ps

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

## Numbers (calculate and compute)

### seq

Generate a sequence of numbers:
```bash
seq 4 # --> 1 2 3 4
seq 100 104 # --> 100 101 102 103 104
```

### bc

Set the number of decimals to print for output:
```
scale=2
```
By default only integer parts are printed (zero decimals).

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
## X11 & other graphical display managers

 * [256 Xterm 24bit RGB color chart](http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html).
 * [X colors rgb.txt decoded](http://sedition.com/perl/rgb.html).

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

### Install Xfce

On Debian, see <https://wiki.debian.org/Xfce>:
```bash
apt-get install xfce4
#apt-get install xfce4-goodies
#apt-get install task-xfce-desktop
```

### Screen saver, locking and energy saving

Under macOS:
```bash
/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend
```

### Fonts
	
Getting list of fonts:
```bash
xlsfonts
```

Open a window with a list of fonts:
```bash
xfd -fn fontname
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
