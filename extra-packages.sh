## Make .config
mkdir ~/.config

## Extra Pacakges Install
sudo xbps-install -S --yes alacritty fff fzf gnupg gtk+3-devel mercurial olm python3-pip zathura zip zsh

## Alacritty Config
cd
mkdir ~/.config/alacritty/
cd ~/void-deploy/configs
cp alacritty.yml ~/.config/alacritty/
cd

## WIP
