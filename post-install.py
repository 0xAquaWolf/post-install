#!/usr/bin/env python3

import os
import subprocess

def print_header():
    header = """
 ██████╗ ██╗  ██╗ █████╗  ██████╗ ██╗   ██╗ █████╗ ██╗    ██╗ ██████╗ ██╗     ███████╗
██╔═████╗╚██╗██╔╝██╔══██╗██╔═══██╗██║   ██║██╔══██╗██║    ██║██╔═══██╗██║     ██╔════╝
██║██╔██║ ╚███╔╝ ███████║██║   ██║██║   ██║███████║██║ █╗ ██║██║   ██║██║     █████╗  
████╔╝██║ ██╔██╗ ██╔══██║██║▄▄ ██║██║   ██║██╔══██║██║███╗██║██║   ██║██║     ██╔══╝  
╚██████╔╝██╔╝ ██╗██║  ██║╚██████╔╝╚██████╔╝██║  ██║╚███╔███╔╝╚██████╔╝███████╗██║     
 ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚══▀▀═╝  ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝  ╚═════╝ ╚══════╝╚═╝     
"""
    print(header)
    print("Fedora Post Install Script")


def check_display():
    session_type = os.getenv("XDG_SESSION_TYPE", "").lower()
    print(session_type)
    has_display = False

    if session_type == "x11" or session_type == "wayland":
        print("has display is TRUE")
        has_display = True

    return has_display


def main():
    print_header()

    # ===== | Update dnf package manager to best fastestmirror | ==========

    session_type = os.getenv("XDG_SESSION_TYPE", "").lower()
    has_display = False

    if session_type == "x11" or session_type == "wayland":
        has_display = True

    print(has_display)

    DNF_CONF = "/etc/dnf/dnf.conf"

    # Check if the lines already exist in DNF_CONF
    if not all(line in open(DNF_CONF).read() for line in [
        "max_parallel_downloads=10\n",
        "fastestmirror=True\n",
        "deltarpm=True\n"
    ]):
        # Append the lines to DNF_CONF if they don't exist
        print_current_cmd("updating dnf conf")

        with open(DNF_CONF, "a") as f:
            f.write("max_parallel_downloads=10\n")
            f.write("fastestmirror=True\n")
            f.write("deltarpm=True\n")

    # ===== | update the system | ==========
    print_current_cmd("updating packages")
    subprocess.run(["sudo", "dnf", "update", "-y"])
    subprocess.run(["sudo", "dnf", "upgrade", "-y"])

    # ===== | enable RPM Fusion | ==========
    print_current_cmd("enabling RPM Fusion")
    subprocess.run(["sudo", "rpm", "-Uvh",
                    f"http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-{subprocess.run(['rpm', '-E', '%fedora'], capture_output=True, text=True).stdout.strip()}.noarch.rpm", "-y"])
    subprocess.run(["sudo", "rpm", "-Uvh",
                    f"http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-{subprocess.run(['rpm', '-E', '%fedora'], capture_output=True, text=True).stdout.strip()}.noarch.rpm", "-y"])
    subprocess.run(["sudo", "dnf", "upgrade", "--refresh", "-y"])
    subprocess.run(["sudo", "dnf", "groupupdate", "core", "-y"])

    # ===== | Change Host Name | ==========
    print_current_cmd("Changing hostname")
    subprocess.run(["sudo", "hostnamectl", "set-hostname", "AquaOS"])

    # ===== | Securing Server | ==========
    print_current_cmd("Securing Server")
    subprocess.run(["sudo", "firewall-cmd", "--permanent", "--zone=public", "--add-service=http"])
    subprocess.run(["sudo", "firewall-cmd", "--permanent", "--zone=public", "--add-service=https"])
    subprocess.run(["sudo", "firewall-cmd", "--reload"])
    subprocess.run(["sudo", "setsebool", "httpd_can_network_connect", "on"])

    # ===== | install packages for both | ==========
    print_current_cmd("installing applications")
    subprocess.run(["sudo", "dnf", "install", "-y", "unzip", "unrar", "neovim", "htop", "lsd", "zsh", "fastfetch", "neofetch"])

    if has_display:
        # ===== | Install Desktop packages | ==========
        print_current_cmd("Has Display")
        # subprocess.run(["sudo", "dnf", "install", "-y", "vlc", "virtualbox", "akmod-VirtualBox", "alacritty"])
    else:
        # ===== | Install server packages | ==========
        print_current_cmd("No Display Present")
        # subprocess.run(["sudo", "dnf", "install", "-y", "caddy", "nodejs"])

    # ===== | Configuring Python | ==========
    # print_current_cmd("Installing pip")
    # subprocess.run(["python", "-m", "ensurepip", "--upgrade"])
    # print_current_cmd("Installing pipx")
    # subprocess.run(["python3", "-m", "pip", "install", "--user", "pipx"])
    # subprocess.run(["python3", "-m", "pipx", "ensurepath"])

    # # ===== | install rust | ==========
    # subprocess.run(["curl", "--proto", "=https", "--tlsv1.2", "-sSf", "https://sh.rustup.rs", "|", "sh"])


def print_current_cmd(cmd):
    print("\n")
    print(cmd)


if __name__ == "__main__":
    result = check_display()

    if result:
        print("The session has a display")
    else:
        print("The session does not have a display")

    # main()
