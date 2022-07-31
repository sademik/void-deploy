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

## Copy fonts
mkdir ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Bold.ttf ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Bold\ Italic.ttf ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Italic.ttf ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Regular.ttf ~/.fonts

## WIP
