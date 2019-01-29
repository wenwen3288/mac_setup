#/bin/bash bash

################CONFIGUTATION START########################
brew=(
  awscli
  cheat
  gnu-sed\ --with-default-names
  gpg
  openssl
  python
  vim\ --with-override-system-vi
  wget\ --with-iri
  node
  swiftlint
  cocoapods
  cask
)

cask=(
  alfred
  flux
  google-chrome
  google-backup-and-sync
  java
  qlcolorcode
  qlimagesize
  qlmarkdown
  qlstephen
  quicklook-json
  sublime-text
  virtualbox
  vlc
  shiftit
)

extra_cask=(
  postman
  visual-studio-code
)

################ CONFIGUTATION END ########################

echo Installing xcode? [Y/N]
read -n 1 input
if [$input == "y"]; then
  echo ****Installing xcode start****
  xcode-select --install
else
  echo "Skipping xcode-select"
fi
echo ****Installing brew start****
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo ****Updating brew start****
brew update

echo **** install ${brew[@]} ****
for i in "${brew[@]}"; do
  brew install $i
done

echo **** install ${cask[@]} ****
for i in "${cask[@]}"; do
  brew cask install $i
done
#brew link openssl --force

echo **** install iOS sim ****
npm install -g ios-sim

echo **** adding alias ****

echo "alias git-log=\"git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'\"" >> ~/.zshrc
echo "alias git-log-all=\"git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset) —all\'\"" >> ~/.zshrc
echo "alias git-delete-merged=\"git fetch && git remote prune origin && git branch --merged | egrep -v '(^\*|master|dev)' | xargs git branch -d\"" >> ~/.zshrc
source ~/.zshrc

echo ****Install Font ****
echo ***User Roboto Thin****
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts



which = $(which pip)
echo ${which}

echo ****update pip start****
pip install --upgrade pip

echo ****update pip finish****

echo ****Install RVM****
curl -sSL https://get.rvm.io | bash -s stable --ruby

echo ****install awscli start****
sudo -H  pip install awscli --upgrade --ignore-installed six
echo ****install awscli finish****

#Support bigger file size. default is 100k
defaults write com.whomwah.quicklookstephen maxFileSize 1024000

echo **** Disble time machine when new media inserted to the system ****
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


echo **** Show file extention ****
defaults write com.apple.finder AppleShowAllFiles TRUE; 

echo ****  Don\'t write DS_Store file on USB and network drive ****
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo ****faster cursor****
defaults write NSGlobalDomain KeyRepeat -int 1

echo ****Change screenshot location****
defaults write com.apple.screencapture location ~/Desktop/screenshots

echo ****Show battery percent****
defaults write com.apple.menuextra.battery ShowPercent YES


echo "Cleanup"
brew cleanup
brew cask cleanup

killall SystemUIServer
killall Dock
killall Finder
#https://apple.stackexchange.com/questions/306867/can-defaults-write-command-line-configure-the-menu-bar-on-macos
#hello
