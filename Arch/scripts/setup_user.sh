#!/bin/bash
useradd -m -G wheel $1 -p $2
echo "User made, if you haven't already, please uncomment the '%wheel ALL=(ALL) ALL' line in /etc/sudoers"
