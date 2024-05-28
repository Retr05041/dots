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
echo -e "n\n3\n\n\n\nw" | fdisk $disk

# Formatting partitions
mkfs.vfat -F32 "${disk}1" # Format EFI partition
mkfs.ext4 "${disk}2"
mkswap "${disk}3"
