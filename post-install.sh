#!/usr/bin/sudo bash

# TODO: 
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
  
  session_type=$(echo "$XDG_SESSION_TYPE" | tr '[:upper:]' '[:lower:]')

  has_display=false

  if [[ "$session_type" == "x11" || "$session_type" == "wayland" ]]; then
    has_display=true
  fi

  echo has_display

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
  sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
  sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
  sudo dnf upgrade --refresh -y
  sudo dnf groupupdate core -y

  # ===== | Change Host Name | ==========
  print_current_cmd "Changing hostname"
  sudo hostnamectl set-hostname "AquaOS"

  # ===== | Securing Server | ==========
  print_current_cmd "Securing Server"
  sudo firewall-cmd --permanent --zone=public --add-service=http
  sudo firewall-cmd --permanent --zone=public --add-service=https
  sudo firewall-cmd --reload
  sudo setsebool httpd_can_network_connect on

  # ===== | install packages for both | ==========
  print_current_cmd "installing applications"
  sudo dnf install -y unzip unrar neovim htop lsd zsh 
  
  if has_display; then
    # ===== | Install Desktop packages | ==========
    sudo dnf install -y vlc virtualbox akmod-VirtualBox alacritty
  else
    # ===== | Install server packages | ==========
    sudo dnf install -y caddy nodejs
  fi

  # ===== | Configuring Python | ==========
  # print_current_cmd "Installing pip"
  # python -m ensurepip --upgrade
  # print_current_cmd "Installing pipx"
  # python3 -m pip install --user pipx
  # python3 -m pipx ensurepath

  # # ===== | install rust | ==========
  # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

}

print_current_cmd() {
  echo -e "\n"
  echo $1;
}


main
