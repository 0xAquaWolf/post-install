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
  

  DNF_CONF=/etc/dnf/dnf.conf

  # Check if the lines already exist in DNF_CONF
  if ! grep -Fxq "max_parallel_downloads=10" "$DNF_CONF" && \
     ! grep -Fxq "fastestmirror=True" "$DNF_CONF" && \
     ! grep -Fxq "deltarpm=True" "$DNF_CONF"; then
    # Append the lines to DNF_CONF if they don't exist
    print_current_cmd "updating dnf conf"

    echo "max_parallel_downloads=10" >> "$DNF_CONF"
    echo "fastestmirror=True" >> "$DNF_CONF"
    echo "deltarpm=True" >> "$DNF_CONF"
  fi
  
  # ===== | update the system | ==========
  print_current_cmd "updating packages"
  sudo dnf update -y && sudo dnf upgrade -y
  
  # ===== | enable RPM Fusion | ==========
  
  print_current_cmd "enabling RPM Fusion"
  sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
  sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  sudo dnf upgrade --refresh
  sudo dnf groupupdate core

  # ===== | Change Host Name | ==========
  print_current_cmd "Changing hostname"
  sudo hostnamectl set-hostname "AquaOS"
}

print_current_cmd() {
  echo -e "\n"
  echo $1;
}


main
