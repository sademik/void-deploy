# void-deploy
deploys my dwm flavor of void linux, makes life easier

---

### change privileges

`$ sudo EDITOR=vi visudo`

uncomment `(#%wheel ALL=(ALL:ALL) NOPASSWD: ALL) ===> (%wheel ALL=(ALL:ALL) NOPASSWD: ALL)`

### git this repo

`$ sudo xbps-install -Syy && sudo xbps-install -u xbps`

`$ sudo xbps-install -S git`

`$ git clone https://github.com/sademik/void-deploy`

### run the script

`$ chmod +x void-deploy/void-deploy.sh`

`$ ./void-deploy/void-deploy.sh`

### run `startx` to enter DWM
