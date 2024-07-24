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

# TODO (Post-install)
All optional installs need their own file..

Rewrite python scritps in Go? (use this link to get args and read config files... https://elewis.dev/charming-cobras-with-bubbletea-part-1)
- Could then add more support for editing configs on the fly...
    - Need to do this for ease of changing configs for: monitor, wallpaper..
    - Bubbletea TUI?!
- Could elimenate the need for bash... would need a make file to get the go interpreter...

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

Japanse UTF-8 font to see the smile emoticon
