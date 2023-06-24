#!/usr/bin/sudo bash

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

  # ===== | Update dnf package manager to best fastestmirror | ==========
  #
  
  current_status "updating dnf conf"

  DNF_CONF=/etc/dnf/dnf.conf
  echo "max_parallel_downloads=10" >> "$DNF_CONF"
  echo "fastestmirror=True" >> "$DNF_CONF"
  echo "deltarpm=True" >> "$DNF_CONF"
  
  # ===== | update the system | ==========
  current_status "updating packages"
  # sudo dnf update -y && sudo dnf upgrade -y
  
  # ===== | enable RPM Fusion | ==========
  
  # current_status "enabling RPM Fusion"
  # sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  # sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  # sudo dnf upgrade --refresh
  # sudo dnf groupupdate core
}

current_status() {
  echo -e "\n"
  echo $1;
}


main
