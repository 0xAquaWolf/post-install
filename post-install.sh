#!/bin/bash

# TODO: 
# - make sure github is installed
# - Install Neofetch
# - Install Rust
# - Install Pip, pipx
# - install node with fnm
# - Install Nerd Font
# - Set as default in terminal
# - Install lunarvim

print_header() {
cat << EOF
 ██████╗ ██╗  ██╗ █████╗  ██████╗ ██╗   ██╗ █████╗ ██╗    ██╗ ██████╗ ██╗     ███████╗
██╔═████╗╚██╗██╔╝██╔══██╗██╔═══██╗██║   ██║██╔══██╗██║    ██║██╔═══██╗██║     ██╔════╝
██║██╔██║ ╚███╔╝ ███████║██║   ██║██║   ██║███████║██║ █╗ ██║██║   ██║██║     █████╗  
████╔╝██║ ██╔██╗ ██╔══██║██║▄▄ ██║██║   ██║██╔══██║██║███╗██║██║   ██║██║     ██╔══╝  
╚██████╔╝██╔╝ ██╗██║  ██║╚██████╔╝╚██████╔╝██║  ██║╚███╔███╔╝╚██████╔╝███████╗██║     
 ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══▀▀═╝  ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝  ╚═════╝ ╚══════╝╚═╝     
EOF
echo "Fedora Post Install Script"
}

main() {
  print_header

  # Update dnf package manager to best faster
  DNF_CONF=/etc/dnf/dnf.conf

  echo "max_parallel_downloads=10" >> "$DNF_CONF"
  echo "fastestmirror=True" >> "$DNF_CONF"

  cat /etc/dnf/dnf/conf
  
  # # update the system

  # sudo dnf update -y
  # sudo dnf upgrade -y
  
  # enable RPM Fussion
  #
  # sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  # sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  # sudo dnf upgrade --refresh
  # sudo dnf groupupdate core
}

main



