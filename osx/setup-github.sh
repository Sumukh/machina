CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read -p "What is your full name: "
git config --global user.name $REPLY
read -p "Your git email: "
git config --global user.email $REPLY
echo "When you're prompted to 'Enter a file in which to save the key' press Enter"
ssh-keygen -t ed25519 -C $REPLY
# open "https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent"
if [ -f '~/.ssh/config' ]; then
    touch ~/.ssh/config && cp $CURR_DIR/.ssh-config ~/.ssh/config 
fi

eval "$(ssh-agent -s)"

echo "---- Here's your key. It has also been copied to your clipboard ----"
cat ~/.ssh/id_ed25519.pub | pbcopy
cat ~/.ssh/id_ed25519.pub;

ssh-add --apple-use-keychain ~/.ssh/id_ed25519
open "https://github.com/settings/keys"
