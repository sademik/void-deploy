#!/bin/bash
# Void Linux with DWM and SOWM Deployment (my flavour)


## System Update
sudo xbps-install -Syy
sudo xbps-install -u xbps
sudo xbps-install -Syu


## Enable Non-Free/Multilib Repos
sudo xbps-install -S -v --yes void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree
sudo xbps-install -Syy


## Define Minimal Installation Packages Function
minimal-install () {
sudo xbps-install -S -v --yes base-devel xorg libXft-devel libX11-devel libXinerama-devel libXt-devel libcurl-devel dbus-devel dbus-glib-devel curl wget xtools ranger xdg-desktop-portal pulseaudio pulseaudio-devel ntp micro pcmanfm firefox nodejs htop btop mpv feh exa neofetch vim alacritty fzf cmus gnupg gtk+3-devel p7zip mercurial zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip xz binutils ffmpeg ufetch w3m w3m-img xsel wally-cli setxkbmap xbindkeys task ntfs-3g
}


## Define Full Installation Packages Function
full-install () {
sudo xbps-install -S -v --yes base-devel xorg libXft-devel libX11-devel libXinerama-devel libXt-devel libcurl-devel dbus-devel dbus-glib-devel curl wget xtools ranger xdg-desktop-portal pulseaudio pulseaudio-devel ntp micro pcmanfm firefox nodejs htop btop mpv feh terminus-font nerd-fonts-ttf exa neofetch vim alacritty fff fzf cmus gnupg gtk+3-devel p7zip mercurial python3-pip zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip xz binutils ffmpeg bluez mdadm bridge-utils cryptsetup element-desktop dejavu-fonts-ttf dmidecode font-misc-misc github-cli glxinfo gvfs-afc gvfs-mtp gvfs-smb libcurl-devel libdrm-32bit libgcc-32bit libopencv-python3 libstdc++-32bit libvirt lvm2 mesa-dri-32bit mesa-vaapi mesa-vdpau mesa-vulkan-radeon mono ncdu network-manager-applet noto-fonts-cjk noto-fonts-emoji ntfs-3g olm olm-python3 openbsd-netcat pfetch python-devel python3-devel python3-distutils-extra qemu steam udisks2 virt-manager virt-viewer vkd3d vkd3d-devel w3m w3m-img weechat weechat-python wmctrl xarchiver xauth xorg-input-drivers xorg-minimal xorg-video-drivers xsel void-docs-browse rust cargo ufetch rxvt-unicode SDL SDL-32bit SDL-devel SDL-devel-32bit SDL_image-devel SDL_image SDL_ttf ImageMagick dhclient exiftool glu gimp fuse-overlayfs libglvnd-32bit moc python3-argh python3-ConfigArgParse python3-distlib python-distutils-extra wally-cli tree setxkbmap task xbindkeys idle-python3
}


## Define ZSH Installation and Configuration Function
zsh-install () {
sudo xbps-install -S -v --yes zsh
sudo chsh -s /bin/zsh faen
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cd
cp ~/void-deploy/configs/zsh/.zshrc ~/.zshrc
cp ~/void-deploy/configs/zsh/.p10k.zsh ~/.p10k.zsh
}


## Define FISH Installation and Configuration Function
fish-install () {
sudo xbps-install -S -v --yes fish-shell
sudo echo /bin/fish | sudo tee -a /etc/shells
sudo chsh -s /bin/fish faen
}

## User Chooses 'Minimal' or 'Full' Installation
PS3='Installation type: '
options=("Minimal" "Full" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Minimal")
      echo "Minimal package installation initialized."
      minimal-install
      echo "Minimal package installation successful."
      break
      ;;
    "Full")
      echo "Full package installation initialized."
      full-install
      echo "Full package installation successful."
      break
      ;;
    "Quit")
      break
      ;;
    *) echo "Invalid option: $REPLY";;
  esac
done


## User Chooses Their Shell
PS3='Decide a shell: '
options=("Zsh" "Fish" "Bash" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Zsh")
      echo "Zsh selected."
      zsh-install
      echo "Zsh installation successful."
      break
      ;;
    "Fish")
      echo "Fish selected."
      fish-install
      echo "Fish installation successful."
      break
      ;;
    "Bash")
      echo "Bash selected."
      echo "Bash installation successful."
      break
      ;;
    "Quit")
      break
      ;;
    *) echo "Invalid option: $REPLY";;
  esac
done


## DWM Setup
mkdir suckless
cd suckless
## Eventually these will be changed to my own repos with my self-configured versions of the Suckless tools.
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


## Constructing .xinitrc files (temporary, will eventually come with repo)
touch ~/.xinitrc_dwm
echo 'if [ -d /etc/X11/xinit/xinitrc.d ] ; then' >> .xinitrc_dwm 
echo 'for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do' >> .xinitrc_dwm
echo '[ -x "$f" ] && . "$f"' >> .xinitrc_dwm
echo 'done' >> .xinitrc_dwm
echo 'unset f' >> .xinitrc_dwm
echo 'fi' >> .xinitrc_dwm
echo "setxkbmap us &" >> .xinitrc_dwm
echo "exec dwm & wmpid=$!" >> .xinitrc_dwm
echo "exec slstatus &" >> .xinitrc_dwm
echo "sleep 5" >> .xinitrc_dwm
echo "xset r rate 175" >> .xinitrc_dwm
echo "~/void-deploy/scripts/.set_monitor.sh" >> .xinitrc_dwm
echo "feh --bg-fill ~/void-deploy/wallpapers/blame1.jpg" >> .xinitrc_dwm
echo "~/void-deploy/scripts/.set_time.sh" >> .xinitrc_dwm
echo "wait $wmpid" >> .xinitrc_dwm
touch ~/.xinitrc_sowm
echo 'if [ -d /etc/X11/xinit/xinitrc.d ] ; then' >> .xinitrc_sowm
echo 'for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do' >> .xinitrc_sowm
echo '[ -x "$f" ] && . "$f"' >> .xinitrc_sowm
echo 'done' >> .xinitrc_sowm
echo 'unset f' >> .xinitrc_sowm
echo 'fi' >> .xinitrc_sowm
echo "setxkbmap us &" >> .xinitrc_sowm
echo "exec sowm & wmpid=$!" >> .xinitrc_sowm
echo "sleep 5" >> .xinitrc_sowm
echo "xset r rate 175" >> .xinitrc_sowm
echo "~/void-deploy/scripts/.set_monitor.sh" >> .xinitrc_sowm
echo "feh --bg-fill ~/void-deploy/wallpapers/blame1.jpg" >> .xinitrc_sowm
echo "~/void-deploy/scripts/.set_time.sh" >> .xinitrc_sowm
echo "wait $wmpid" >> .xinitrc_sowm


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
