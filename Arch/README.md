# Base Arch installation notes
section 1.7 connect to internet: use iwctl

section 1.8 disks: list disks -> wipe main disk -> create partitions and specify types -> format using specified type -> temp mount

section 2.2 programs: intel/amd-ucode, e2fsprogs (ext4), lvm2, sof-firmware (possibly alsa-firmware), networkmanager, vim, man-db, man-pages

section 3.4 network config: remember /etc/host(s) -> 127.0.0.1 localhost -> ::1 localhost -> 127.0.0.1 hostname

section 3.8 boot loader: pacman -S grub efibootmgr -> grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=GRUB -> grub-mkconfig -o /boot/grub/grub.cfg

# Post installation notes
Start NetworkManager: systemctl enable/start NetworkManager.service -> nmcli connect "{ssid}" password {password}
Install sudo: pacman -S sudo

Use besmart.sh to setup system
