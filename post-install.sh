#!/bin/bash

echo "Hello, World"

# Update dnf package manager to best faster
DNF_CONF=/etc/dnf/dnf.conf

max_parallel_downloads=10
fastestmirror=True

# update the system

sudo dnf update -y
sudo dnf upgrade -y

# enable RPM Fussion
sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf upgrade --refresh
sudo dnf groupupdate core


