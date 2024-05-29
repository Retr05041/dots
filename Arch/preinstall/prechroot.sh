#!/bin/bash

# Set timezone if wrong
if ! [[ "$(timedatectl | grep -oP 'Time zone: \K\S+')" == "America/Vancouver" ]]; then
	timedatectl set-timezone America/Vancouver
fi

# Disk to partition (change this to match your disk)
disk="/dev/sda"

# Partition sizes in gigabytes 
efi_size_gb=1 # Size for EFI partition
swap_size_gb=2 # Size for swap partition

# Destroy old partitions and format the disk
wipefs -af "$disk"
dd if=/dev/zero of="$disk" bs=1M count=1
partprobe "$disk"

# Partition the disk with fdisk
echo -e "g\nn\n1\n\n+${efi_size_gb}G\nt\n1\nw" | fdisk $disk
echo -e "n\n2\n\n+${swap_size_gb}G\nt\n2\n19\nw" | fdisk $disk
echo -e "n\n3\n\n\n\nt\n3\n20\nw" | fdisk $disk

# Format EFI/Boot & Swap
mkfs.vfat -F32 "${disk}1" # Format EFI partition
mkswap "${disk}2"

# Crypt setup
cryptsetup luksFormat "${disk}3"
cryptsetup open --type luks "${disk}3" lvm

# LVM setup
pvcreate /dev/mapper/lvm
vgcreate volgroup0 /dev/mapper/lvm
lvcreate -L 19GB volgroup0 -n lv_root # For some reason LVM takes 2Mb off.. so we round down...
modprobe dm_mod
vgscan
vgchange -ay

# Format Root
mkfs.ext4 /dev/volgroup0/lv_root

# Mount Root, EFI/Boot, & Swap
mount /dev/volgroup0/lv_root /mnt
mount --mkdir "${disk}1" /mnt/boot
swapon "${disk}2"

# Install meta-packages
pacstrap -K /mnt base linux linux-firmware amd-ucode e2fsprogs lvm2 sof-firmware networkmanager vim man-db man-pages

# Auto mount
genfstab -U /mnt >> /mnt/etc/fstab
