#!/bin/bash
# Save some shit

#Save bashrc
cat ~/.bashrc > ./bashrc

#Save flatpak apps
flatpak list --columns=application --app > ./flatlist

#Save GNOME extensions
ls ~/.local/share/gnome-shell/extensions/ | cat > extensionlist
tar -cf extensions.tar ~/.local/share/gnome-shell/extensions/

echo "Everything saved"
