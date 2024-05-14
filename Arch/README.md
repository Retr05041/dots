# Base Arch installation notes
section 1.7 connect to internet: use iwctl

section 1.8 disks: list disks -> wipe main disk -> create partitions and specify types -> format using specified type -> temp mount

section 2.2 programs: intel/amd-ucode, e2fsprogs (ext4), lvm2, sof-firmware (possibly alsa-firmware), networkmanager, vim, man-db, man-pages

section 3.4 network config: remember /etc/host(s) -> 127.0.0.1 localhost -> ::1 localhost -> 127.0.0.1 hostname

section 3.8 boot loader: pacman -S grub efibootmgr -> grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=GRUB -> grub-mkconfig -o /boot/grub/grub.cfg

# Post installation notes
Start NetworkManager: systemctl enable/start NetworkManager.service -> nmcli connect "{ssid}" password {password}

Install sudo: pacman -S sudo

Setup user: useradd -m -G wheel {name} -> passwd {name}

Install git: pacman -S git

Git clone repo

Use besmart.sh to setup system
- Display Manager: -> Remember to set greeter in /etc/lightdm/lightdm.conf -> greeter-session=lightdm-slick-greeter

# TODO
Fix font issue (Want to use Nerd Hack Font and have Noto be a backup..)

Consolidate configurations and test symlink capability for pulling configs -- Possibly

Bring neovim config into the repo, test, and merge with main? (will have to deprecate old neovim config repo...)

Configure i3blocks with emojis and more functionality (battery state, volume controls?, etc.)

Edit besmart.sh to have 1 option for full setup, second for individual setups / configurations post option 1 

