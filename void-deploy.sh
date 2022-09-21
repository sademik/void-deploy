# Void Linux with DWM Deployment (my flavour)


## System Update
sudo xbps-install -Syy
sudo xbps-install -u xbps
sudo xbps-install -Syu


## Enable Non-Free/Multilib Repos
sudo xbps-install -S --yes void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree
sudo xbps-install -Syy


## Install Packages
sudo xbps-install -S --yes base-devel xorg libXft-devel libX11-devel libXinerama-devel libXt-devel libcurl-devel dbus-devel dbus-glib-devel curl wget xtools ranger xdg-desktop-portal pulseaudio pulseaudio-devel ntp micro pcmanfm firefox nodejs htop btop mpv feh terminus-font nerd-fonts-ttf exa neofetch vim alacritty fff fzf cmus gnupg gtk+3-devel p7zip mercurial olm python3-pip zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip zsh xz binutils tar ffmpeg bluez mdadm bridge-utils cryptsetup element-desktop dejavu-fonts-ttf dmidecode font-misc-misc github-cli glxinfo gvfs-afc gvfs-mtp gvfs-smb libcurl-devel libdrm-32bit libgcc-32bit libopenvc-python3 libstdc++-32bit libvirt lvm2 mesa-dri-32bit mesa-vaapi mesa-vdpau mesa-vulkan-radeon mono ncdu network-manager-applet noto-fonts-cjk noto-fonts-emoji ntfs-3g olm olm-python3 openbsd-netcat pfetch python-devel python3-devel python3-distutils-extra qemu steam udisks2 virt-manager virt-viewer vkd3d vkd3d-devel w3m w3m-img weechat weechat-python wmctrl xarchiver xauth xorg-input-drivers xorg-minimal xorg-video-drivers xsel void-docs-browse rust cargo ufetch fish-shell


## Setting up DWM
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
echo "xset r rate 175" >> .xinitrc
echo "~/void-deploy/scripts/.set_monitor.sh" >> .xinitrc
echo "feh --bg-fill ~/void-deploy/wallpapers/blame1.jpg" >> .xinitrc
echo "~/void-deploy/scripts/.set_time.sh" >> .xinitrc
echo "wait $wmpid" >> .xinitrc


## Make .set_monitor.sh and .set_time.sh executable
sudo chmod +x ~/void-deploy/scripts/.set_monitor.sh
sudo chmod +x ~/void-deploy/scripts/.set_time.sh


## Make .config
mkdir ~/.config


## Alacritty Configuration
cd
mkdir ~/.config/alacritty/
cp ~/void-deploy/configs/alacritty.yml ~/.config/alacritty/


## VIM Configuration
cp ~/void-deploy/configs/.vimrc .vimrc
sudo curl https://raw.githubusercontent.com/stayradiated/dotfiles/master/apps/vim/colors/shblah.vim --output /usr/share/vim/vim90/colors/shblah.vim
cd


## FISH Configuration
sudo echo /bin/fish | sudo tee -a /etc/shells
sudo chsh -s /bin/fish faen


## ZSH Configuration
#sudo chsh -s /bin/zsh faen
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#cd
#cp ~/void-deploy/configs/zsh/.zshrc ~/.zshrc
#cp ~/void-deploy/configs/zsh/.p10k.zsh ~/.p10k.zsh


## Copy fonts
mkdir ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Bold.ttf ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Bold\ Italic.ttf ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Italic.ttf ~/.fonts
cp ~/void-deploy/fonts/MesloLGS\ NF\ Regular.ttf ~/.fonts
cd ~/.fonts
wget https://github.com/slavfox/Cozette/releases/download/v.1.17.2/cozette_bitmap.ttf
cd


## Zathura configuration
xdg-mime default org.pwmt.zathura.desktop application/pdf
mkdir ~/.config/zathura/
cp ~/void-deploy/configs/zathurarc ~/.config/zathura/zathurarc


sudo reboot
