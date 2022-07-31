## Make .config
mkdir ~/.config

## Extra Pacakges Install
sudo xbps-install -S --yes alacritty fff fzf cmus gnupg gtk+3-devel p7zip mercurial olm python3-pip zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip zsh

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

## Configure Zathura
xdg-mime default org.pwmt.zathura.desktop application/pdf
mkdir ~/.config/zathura/
cp ~/void-deploy/configs/zathurarc ~/.config/zathura/zathurarc


## WIP
