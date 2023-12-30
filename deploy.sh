#!/bin/bash
# Restore some shit

#Restore bashrc
cat ./bashrc > ~/.bashrc

#Restore flatpak apps
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
xargs flatpak install -y < ./flatlist

#Restore GNOME extensions
echo "FIXME! Restore gnome extensions"
#ls ~/.local/share/gnome-shell/extensions/ | cat > extensionlist
#tar -cf extensions.tar ~/.local/share/gnome-shell/extensions/

echo "Everything restored"
