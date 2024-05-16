#!/bin/bash
#go1.22.2.linux-amd64.tar.gz

if [ -d ./tmp/alacritty ]; then rm -rf ./tmp/alacritty fi
git clone https://github.com/alacritty/alacritty.git ./tmp/

./scripts/rustinstaller.sh -y
#add a way to curl a new version: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustinstaller.sh
rustup override set stable
rustup update stable
#rustup self uninstall

sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cd ./tmp/alacritty
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
cd ../../

sudo cp ./tmp/alacritty/target/release/alacritty /usr/local/bin
# sudo rm /usr/local/bin/alacritty

sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
#sudo update-alternatives --remove "x-terminal-emulator" "/usr/local/bin/alacritty"

# config file as follows
#$HOME/.alacritty.toml
