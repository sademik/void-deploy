# Void Linux with DWM Deployment

## System Update
echo "Updating the system."
sudo xbps-install -Syy
sudo xbps-install -u xbps
sudo xbps-install -Syu

## Necessary Packages
echo "Installing some necessary packages."
sudo xbps-install -S --yes base-devel xorg libXft-devel libX11-devel libXinerama-devel libXt-devel libcurl-devel dbus-devel dbus-glib-devel curl wget ranger xdg-desktop-portal pulseaudio pulseaudio-devel ntp micro pcmanfm chromium nodejs htop mpv feh terminus-font nerd-fonts-ttf exa neofetch

## Setting up DWM
echo "Setting up DWM."
mkdir suckless
cd suckless
## Eventually thesee will be changed to my own repos with my self-configured versions of the Suckless tools.
git clone https://git.suckless.org/dwm 
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
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
cd
touch ~/.xinitrc
echo "setxkbmap us &" >> .xinitrc
echo "exec dwm" >> .xinitrc
## Run 'startx' from tty
echo "Run 'startx' from tty"

sudo reboot
