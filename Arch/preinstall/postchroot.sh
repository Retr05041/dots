#!/bin/bash

# Time
ln -sf /usr/share/zoneinfo/America/Vancouver /etc/localtime
hwclock --systohc

# Localization
sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen 
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Hostname
echo "voyager" >> /etc/hostname

# Install grub
pacman -S grub efibootmgr

# MISSING:
# - Edit /etc/mkinitcpio.conf
# 	Add 'encrypt' & 'lvm2' in between 'block' and 'filesystems'
#
# mkinitcpio -p linux
#
# - Edit /etc/default/grub
# 	Find 'GRUB_CMDLINE_LINUX_DEFAULT' and add 'cryptdevice=/dev/sda3:volgroup0' (device-name:volume-group)
#
# mount /dev/sda1 /boot
#
# grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=grub_uefi
#
# cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
#
# grub-mkconfig -o /boot/grub/grub.cfg
#
# systemctl enable NetworkManger.service
#
#
#
# TODO: (pre besmart, post this file...)
# - Central settings file... (preinstall and besmart..)
# - Add admin user / edit sudoers file
# - Check preinstall python availability...
