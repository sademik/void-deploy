# Void Linux with DWM Deployment (my flavour)

## System Update
echo "Updating the system."
sudo xbps-install -Syy
sudo xbps-install -u xbps
sudo xbps-install -Syu

## Install Packages
echo "Installing some packages."
sudo xbps-install -S --yes base-devel xorg libXft-devel libX11-devel libXinerama-devel libXt-devel libcurl-devel dbus-devel dbus-glib-devel curl wget xtools ranger xdg-desktop-portal pulseaudio pulseaudio-devel ntp micro pcmanfm chromium nodejs htop mpv feh terminus-font nerd-fonts-ttf exa neofetch vim alacritty fff fzf cmus gnupg gtk+3-devel p7zip mercurial olm python3-pip zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip zsh

## Setting up DWM
echo "Setting up DWM."
mkdir suckless
cd suckless
## Eventually thesee will be changed to my own repos with my self-configured versions of the Suckless tools.
git clone https://github.com/sademik/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
git clone https://github.com/sademik/slstatus
cd dwm
make
sudo make clean install
cd ..
cd st
make
sudo make clean install
cd ..
cd dmenu
make
sudo make clean install
cd ..
cd slstatus
make
sudo make clean install
cd

##Constructing .xinitrc
touch ~/.xinitrc
echo "setxkbmap us &" >> .xinitrc
echo "exec dwm & wmpid=$!" >> .xinitrc
echo "exec slstatus &" >> .xinitrc
echo "sleep 5" >> .xinitrc
echo "~/void-deploy/scripts/.set_monitor.sh" >> .xinitrc
echo "feh --bg-fill ~/void-deploy/wallpapers/blame1.jpg" >> .xinitrc
echo "~/void-deploy/scripts/.set_time.sh" >> .xinitrc
echo "wait $wmpid" >> .xinitrc

## Make .set_monitor.sh and .set_time.sh executable
sudo chmod +x ~/void-deploy/scripts/.set_monitor.sh
sudo chmod +x ~/void-deploy/scripts/.set_time.sh

## Set xrate to be lower
xset r rate 230

## Make .config
mkdir ~/.config

## Alacritty configuration
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

## Zathura configuration
xdg-mime default org.pwmt.zathura.desktop application/pdf
mkdir ~/.config/zathura/
cp ~/void-deploy/configs/zathurarc ~/.config/zathura/zathurarc

## Run 'startx' from tty
echo "Run 'startx' from tty"

sudo reboot
