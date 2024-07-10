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
remember /etc/host(s) -> 127.0.0.1 localhost -> ::1 localhost -> 127.0.0.1 hostname

On full run with base system, here are errors: - these need developing changes
- I don't believe lightdm.service gets enabled automatically...
- Hack Nerd Font dies... - NOT BEING CALLED EVER
- Can't use dmenu or type in wezterm... might be a vm thing
- Remove alias cd from .mybashrc - meant for .myoptionalbashrc -- this is causing an annoying cd headache
- Something is wrong with lightdm.. think I will need to do tests on a laptop to really figure it out
- node-lts-iron == nodejs-lts-iron

# TODO (Post-install)
All optional installs need their own file..

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
