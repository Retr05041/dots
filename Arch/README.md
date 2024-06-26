# Dots Repo
*My main workstation configuration repo*

## Pre-install
<!-- Watch all the Arch normies cry over archinstall lol -->

`iwctl` - Internet

`pacman -Sy` - Sync repos

`archinstall` - Cause we lazy -> Any option not specified below can be left blank or up to the users discretion

- Disk configuration = default partition layout -> ext4
- Disk encryption = Set password -> Encryption type: Luks -> Partitions: /
- Profile = Type: xorg -> Graphics Driver: Best for your hardware
- Audio = Pipewire
- Additional packages = intel/amd-ucode e2fsprogs sof-firmware networkmanager vim man-db man-pages
- Network configuration = Use Networkmanager
 
## Post-install
`besmart.sh -a`

### Notes
remember /etc/host(s) -> 127.0.0.1 localhost -> ::1 localhost -> 127.0.0.1 hostname

On full run with base system, here are errors:
- No .config folder at ~
- Setting wallpaper failed due to ./configs/core/conf/lightdm-mini-greeter & ./configs/core/config/i3/config being invalid paths
- On reboot after -a 'tmux' command not found gets sent
- I don't believe lightdm.service gets enabled automatically...
- yay doesn't get installed and consequentially other yay dependant programs don't get installed - Yay packages also are having problems installing automatically

# TODO (Post-install)
asdf
- runtime version manager

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
