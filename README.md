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

`systemctl enable lightdm.service`

`sudo reboot now`

### Notes
On full run with base system, here are errors: - these need developing changes
- I don't believe lightdm.service gets enabled automatically. Need to decide if I want this to be automated

#### External Monitor
`mons` - Lists connected monitors

`mons -e right` - Extends display to the right

`xrandr --output {EXTERNAL-DISPLAY} --mode 1920x1080` - changes the resolution


# TODO (Post-install)
All optional installs need their own file..

Configure greeter, seems the mini one is borked

Write .myoptionalbashrc script and add functionality to the source bash file to allow for this as well

Optimizations?

asdf
- runtime version manager

rclone
- Google drive

list user installed programs? versions?
- Everything in the config file? Seperate installation scripts? Even more abstraction?!?!

centralize colors?
- Will probably need a script for resetting color values in files if I do this...

Most recent git repo clones?
- Will probably want to do this in a cool way
