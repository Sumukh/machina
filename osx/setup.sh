/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

brew install git

brew cask install alfred google-chrome iterm2 1password visual-studio-code spotify slack sequel-pro docker
brew install zsh tmux ctags git hub reattach-to-user-namespace the_silver_searcher ghi python3

# brew cask install macvim --with-override-system-vim --with-lua --with-luajit

# Command line utilities to make cli usage faster https://github.com/clvv/fasd
brew install fasd

# Fonts
source fonts/install.sh

# Setup ZSH

read -p "Setup ZSH (yes/no)? Reccomended "
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
echo "Import $CURR_DIR/iTerm2/machina.json as your default iTerm Profile"

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

if [ -f '~/.gitconfig' ]; then
    mv ~/.gitconfig ~/.gitconfig.bak
fi
ln -s $CURR_DIR/git/gitconfig ~/.gitconfig

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
   read -p "What is your full name: "
   git config --local user.name $REPLY
   read -p "Your git email: "
   git config --local user.email $REPLY
   echo "When you're prompted to 'Enter a file in which to save the key' press Enter"
   ssh-keygen -t rsa -b 4096 -C $REPLY
   open "https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent"
   echo "Heres the key you add to github:"
   echo "---- begin ----"
   cat ~/.ssh/id_rsa.pub
   echo "--- ^ end ^ ----"
fi

