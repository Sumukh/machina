#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install --cask alfred google-chrome iterm2 1password visual-studio-code spotify slack tableplus docker spectacle zoom notion bartender clocker tunnelblick tailscale
brew install zsh tmux ctags git hub reattach-to-user-namespace the_silver_searcher ghi wget watch dockutil

brew install ruby-install ruby-build rbenv nvm yarn redis

echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zprofile
echo '[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm'    >> ~/.zprofile
echo '[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion'  >> ~/.zprofile
echo 'eval "$(rbenv init - zsh)"' >> ~/.zprofile

echo "Consider running these commands:"
echo "bundle config set force_ruby_platform true"
dockutil -r all
dockutil  -a ~/Downloads --display stack
dockutil  -a /Applications  --display stack

# brew cask install macvim --with-override-system-vim --with-lua --with-luajit

# Command line utilities to make cli usage faster https://github.com/clvv/fasd
brew install fasd

# Fonts
source fonts/install.sh

# Setup ZSH

read -p "Setup ZSH (yes/no)? (Reccomended response: yes) : "
if [ "$REPLY" != "yes" ]; then
  echo "Not setting up ZSH"
else
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ln -s $CURR_DIR/zsh/aliases.sh ~/.aliases
    ln -s $CURR_DIR/zsh/aliases.sh ~/.oh-my-zsh/custom/aliases.zsh
    ln -s $CURR_DIR/zsh/aliases.zsh ~/.oh-my-zsh/custom/zaliases.zsh
    ln -s $CURR_DIR/zsh/theme.zsh ~/.oh-my-zsh/custom/ztheme.zsh
    ln -s $CURR_DIR/zsh/fasd.zsh ~/.oh-my-zsh/custom/fasd.zsh
    ln -s $CURR_DIR/zsh/zzz_custom.zsh ~/.oh-my-zsh/custom/zzz_custom.zsh
fi
echo "In iTerm2, import $CURR_DIR/iTerm2/machina.json as your default iTerm Profile to get the right color settings"

# iTerm Color Profile

/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Light' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Light.itermcolors' :'Custom Color Presets':'Solarized Light'" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist
/usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Dark.itermcolors' :'Custom Color Presets':'Solarized Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist

# Setup OH-MY-ZSH


if [ -f '~/.vimrc' ]; then
    mv ~/.vimrc ~/.vimrc.bak;
fi
ln -s $CURR_DIR/vim/vimrc ~/.vimrc
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/backupf

if [ -f '~/.gitconfig' ]; then
    mv ~/.gitconfig ~/.gitconfig.bak
fi
cp $CURR_DIR/git/gitconfig ~/.gitconfig

if [ -f '~/.gitignore' ]; then
    mv ~/.gitignore ~/.gitignore.bak
fi
ln -s $CURR_DIR/git/gitignore ~/.gitignore

mkdir -p ~/.tmux
if [ -f '~/.tmux/tmux.conf' ]; then
    mv ~/.tmux/tmux.conf ~/.tmux/tmux.conf.bak
fi
ln -s $CURR_DIR/tmux/tmux.conf ~/.tmux/tmux.conf

# Disable last login prompt
touch ~/.hushlogin

read -p "Run OSX Changes (yes/no)? (Reccomended response: yes) : "
if [ "$REPLY" != "yes" ]; then
    echo "Not running OSX changes"
else
   source $CURR_DIR/osx-defaults/os-changes.sh
fi

read -p "Setup new SSH key (yes/no)? (Reccomended response: yes) : "
if [ "$REPLY" != "yes" ]; then
    echo "Not running SSH KEY"
else
   ./setup-github.sh
fi

