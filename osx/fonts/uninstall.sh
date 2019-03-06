#!/bin/sh

# Set source and target directories
powerline_fonts_dir="$( cd "$( dirname "$0" )" && pwd )"

# if an argument is given it is used to select which fonts to uninstall
prefix="$1"

font_dir="$HOME/Library/Fonts"

# Remove all fonts from user fonts directory
echo "Removing fonts..."
find "$powerline_fonts_dir" \( -name "$prefix*.[ot]tf" -or -name "$prefix*.pcf.gz" \) -type f -print0 | xargs -n1 -0 -I % sh -c "rm -f \"\$0/\${1##*/}\"" "$font_dir" %

echo "Powerline fonts uninstalled from $font_dir"
