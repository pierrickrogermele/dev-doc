EMULATORS
=========

## Ansible

 * [Ansible](http://www.ansible.com/).
 * [Ansible as a provisioner for Vagrant](https://docs.vagrantup.com/v2/provisioning/ansible.html).
 * [Multi-Machine Vagrant Ansible Gotcha](http://blog.wjlr.org.uk/2014/12/30/multi-machine-vagrant-ansible-gotcha.html).

To install:
```bash
pip install ansible
```

Ansible needs an inventory file which lists all remote hosts:
```bash
cat >myinventory.txt <<EOF
my.remote.host.fr
EOF
ansible -i myinventory.txt all -m ping # Will ping all hosts listed inside the inventory file.
```

Choose user for connection:
```bash
ansible all -u myuser ... 
ansible all -u myuser -b ... # For running as super user (-b => sudo)
```

To run a command:
```bash
ansible all -a "/my/command/to/run"
```

## Docker

Automates the deployment of applications inside software containers.
Uses VirtualBox.

 * [Docker](http://docs.docker.com/).
 * [Docker wikipedia page](https://en.wikipedia.org/wiki/Docker_%28software%29).
 * [Ansible & containers - a natural fit](http://www.ansible.com/docker).
 * [Kubernetes](http://kubernetes.io/) is docker scheduler that can run applications contained inside docker images on a cluster/cloud.

To list images:
```bash
docker images
```

To list running containers:
```bash
docker ps
```

To run a command inside a running container:
```bash
docker exec 0440ee7a58e5 pwd
docker exec -i 0440ee7a58e5 /bin/bash # to run interactively
```

Searching for public docker base images:
```bash
docker search centos
```

To build a container from a Dockerfile image, run:
```bash
docker build -t myimage .
```

To run the container
```bash
docker run --name mycontainer myimage
```

To mount a local folder onto the container file system, in read/write mode:
```bash
docker run -v /Users/myname/somedir/blabla:/files/mydir myimage
```
In read-only mode:
```bash
docker run -v /Users/myname/somedir/blabla:/files/mydir:ro myimage
```

### macOS

Can be installed with `brew` on macOS:
```bash
brew install docker-machine
brew install docker
```

Docker runs containers inside a docker server (daemon) that needs to run on a Linux OS.
Thus on macOS, we need to run the docker server inside a Linux virtual machine.

The `docker-machine` utility creates such a virtual machine for you and configure the docker client to communicate with it, see [Docker Machine](https://docs.docker.com/machine/). VPNs must be stopped while using the docker-machine.
```bash
docker-machine create -d virtualbox mydockermachinename
```

To get a list of all created docker machines:
```bash
docker-machine ls
```

To run a stopped docker machine:
```bash
docker-machine start mymachine
```

Then run the following command to configure your host:
```bash
eval $(docker-machine env lucydocker)
```
Now you can use docker client.

On error `Error response from daemon: client is newer than server`, run:
```bash
docker-machine upgrade default
```

### Linux

 * [Docker installation on Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntulinux/).

Normally you have to be part of the group `docker` to run Docker. However it may not work, in which case you will be forced to run Docker as root (`sudo docker ...`).

## Vagrant

 * [Vagrant](https://www.vagrantup.com) official site.
 * [HashiCorp boxes](https://atlas.hashicorp.com/boxes/search).

Create a default `Vagrantfile` file:
```bash
vagrant init
```

Add a box:
```bash
vagrant box add hashicorp/precise32
```

Create and start a virtual machine:
```bash
vagrant up
```

Log on the virtual machine:
```bash
vagrant ssh
```

Stop and destroy the virtual machine:
```bash
vagrant destroy
```

Vagrant creates a shared directory `/vagrant` on the virtual machine, that points to the directory containing the `Vagrantfile` file on the host.

Reload (restart) the virtual machine:
```bash
vagrant reload
vagrant reload --provision  # in addition, run the provision scripts.
```

Run provision scripts when machine is running:
```bash
vagrant provision
```

Vagrant configuration file:
```ruby
Vagrant.configure(2) do |config|

  # Define the box to use
  config.vm.box = "puphpet/centos65-x64"

  # To forward port
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # To run installation/configuration scripts
  config.vm.provision :shell, path: "vagrant-bootstrap.sh"
  config.vm.provision :shell, privileged: false, path: "vagrant-install-galaxy.sh"
  config.vm.provision :shell, privileged: false, path: "vagrant-run-galaxy.sh", run: "always" # Run script each time we run `vagrant up` or `vagrant reload`.
end
```

Enable GUI:
```ruby
config.vm.provider "virtualbox" do |v|
  v.gui = true
end
```

Set memory:
```ruby
config.vm.provider "virtualbox" do |vb|
  vb.memory = "2048"
end
```

## VirtualBox

 * [VirtualBox](https://www.virtualbox.org) official site.

## VMWare

### Migration d'un PC en machine virtuelle
Vérifier que le disque est bien en NTFS.
Peut-être important aussi: les *Shadow* services doivent être en démarrage automatique.

### NAT configuration under MacOS-X (VMWare Fusion)

In order to get a fixed IP address for the virtual machine:

 * Note the MAC address of the network adapter card of the virtual machine.
 * Find the `dhcpd.conf` file of the `vmnet8` interface of the VMWare DHCP server: run `sudo find /Library -iname dhcpd.conf`. There could be several files, pay attention to take the one for the `vmnet8` interface.
 * Edit the file as root user.
 * Look at the section `subnet ... netmask ...`, it gives the `range` of IPs used by the DHCP server. Your fixed IP must be outside this range.
 * Write the following lines at the end of the file, but before the comment line saying 'DO NOT MODIFY SECTION':
			host your_vm_hostname {
				hardware ethernet FF:FF:FF:FF:FF:FF;
				fixed-address 111.222.333.444;
			}
    Where you must replace `FF:FF:FF:FF:FF:FF` by the MAC address of your virtual machine network adapter card, and `111.222.333.444` by the IP address you want.
 * Restart WMWare Fusion.
Explanations taken from <http://socalledgeek.com/blog/2012/8/23/fixed-dhcp-ip-allocation-in-vmware-fusion>.

## Parallels

### Installing Parallels Tools on Linux

Go to "Virtual Machine -> Install Parallels Tools".
Open the CDROM drive (on SUSE go to /media/Parallels Tools).
Then run:
```bash
sudo ./install
```

If the following error occurs :
Missing kernel sources.
Then install kernel sources for the current kernel.
You can check then current kernel version by running:
```bash
uname -r
```
And you can check installed kernel sources by looking into:
```bash
/usr/src
```

## QEmu

To convert from one virtual machine format to another:
```bash
qemu-img convert -f vpc -O raw "XP SP2 with IE7.vhd" XPIE7.bin
```

Format | Description
------ | -----------
qcow2  | New qemu format.
vdi	   | VirtualBox format.
vmdk   | VMWare 3 and 4.
vpc    | VirtualPC.

Create a new machine:
```bash
qemu-img create -f qcow2 bernie.qcow2 8G
```

For installing Windows 2000:
```bash
qemu -win2k-hack ...
```

For installing an OS:
```bash
qemu -cdrom os.iso -boot d
```

Option                               | Description
------------------------------------ | -----------
`-m 512`                             | Memory.
`-hda my_file`                       | Hard drive to use.
`-usb`                               | Enable USB.
`-localtime`                         | Use localtime for clock.
`-soundhw sb16`                      | Sound card.
`-no-acpi`                           | Disable ACPI (Advanced Configuration and Power Interface).
`-kernel-kqemu`                      | On Linux, kqemu is a kernel module that enhances emulation performance..
`-net nic -net user,hostname=bernie` | Use host machine's network card.

Example for installing Windows 2000 on macosx:
```bash
qemu -m 512 -hda bernie.qcow2 -usb -localtime -soundhw sb16 -no-acpi -net nic -net user,hostname=bernie -win2k-hack -cdrom win2000.iso -boot d
```

Example for installing WinXP:
```bash
qemu-img create -f qcow2 vmwinxp.qcow2 8G
qemu -m 512 -hda vmwinxp.qcow2 -usb -localtime -soundhw sb16 -no-acpi -net nic -net user,hostname=vmwinxp -cdrom winxp.iso -boot d
```

### Qemu-KVM

Go into BIOS and enable virtualization modes for CPU.
Shutdown and restart computer.

On Ubuntu and Debian:
```bash
apt-get install qemu-kvm
apt-get install aqemu
```

Check that modules are loaded:
```bash
lsmod | grep kvm
```
If they aren't loaded, run:
```bash
sudo modprob kvm-intel
sudo modprob kvm
```
or restart the computer.
## DOSBox

[DOSBOX](http://www.dosbox.com/) is a DOS emulator that runs on different plateforms (Windows, Linux, MacOS, ...).

For a tutorial, type `INTRO` on the command line.

Mounting a local dir to C:
```
mount c: ~/mydir
```

## Old computers

 * [DCMO5](http://dcmo5.free.fr/v11/dcmo5v11fr.html). THOMSON MO5/TO7. Multi-plateform, to compile.

