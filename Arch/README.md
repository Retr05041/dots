# Dots Repo
*My main workstation configuration repo*

# Preinstall 
iwctl

intel/amd-ucode

remember /etc/host(s) -> 127.0.0.1 localhost -> ::1 localhost -> 127.0.0.1 hostname

On full run with base system, here are errors:
- No .config folder at ~
- install sudo: Install sudo: pacman -S sudo
- setup new user
    Setup user: useradd -m -G wheel {name} -> passwd {name}
    - Go to sudoers file and allow wheel 
- Setting wallpaper failed due to ./configs/core/conf/lightdm-mini-greeter & ./configs/core/config/i3/config being invalid paths
- On reboot after -a 'tmux' command not found gets sent
- Need to add light-mini-greeter to lightdm.conf...
- I don't believe lightdm.service gets enabled automatically...
- yay doesn't get installed and consequentially other yay dependant programs don't get installed - Yay packages also are having problems installing automatically
- Might have to do some digging as to see if there is a wait before continuing functin in bash
 
# Postinstall
`besmart.sh -a`

# TODO
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
