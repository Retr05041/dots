# Dots Repo
*My main workstation configuration repo*

# Arch Install Notes
section 1.7 connect to internet: use iwctl

section 1.8 disks: list disks -> wipe main disk -> create partitions and specify types -> format using specified type -> temp mount

section 2.2 programs: intel/amd-ucode, e2fsprogs (ext4), lvm2, sof-firmware (possibly alsa-firmware), networkmanager, vim, man-db, man-pages

section 3.4 network config: remember /etc/host(s) -> 127.0.0.1 localhost -> ::1 localhost -> 127.0.0.1 hostname

section 3.8 boot loader: pacman -S grub efibootmgr -> grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=GRUB -> grub-mkconfig -o /boot/grub/grub.cfg

# Post installation notes
Start NetworkManager: systemctl enable/start NetworkManager.service -> nmcli connect "{ssid}" password {password}

Install sudo: pacman -S sudo

Setup user: useradd -m -G wheel {name} -> passwd {name}
- Go to sudoers file and allow wheel 

Install git: pacman -S git

Git clone repo

Use besmart.sh to setup system
- Display Manager: -> Remember to set greeter in /etc/lightdm/lightdm.conf -> greeter-session=lightdm-mini-greeter

# TODO
besmart
- cleanup whole script for ease of development and use

tmux
- Start configuring

rclone
- Google drive

list user installed programs? versions?
- Rust, neovim, tmux, etc. etc.

centralize colors?
- Will probably need a script for resetting color values in files if I do this...

Drive encryption
- personal and work data partitions...
- rsync?

Most recent git repo clones?
- Will probably want to do this in a cool way
