# Post Install script for Fedora 38 Linux

The main purpose of this install script is to quickly bootstrap and setup a Fedora instance locally or in the cloud with all of my favorite tools and config

### How to run the post install script
```shell
parent_dir=$(pwd) ; [ -d "tmp" ] && rm -rf "tmp" ; mkdir -p "tmp" && cd "tmp" || exit 1 ; git clone https://github.com/0xAquaWolf/post-install.git ; cd "post-install" || exit 1 ; git checkout testing ; chmod +x post-install.sh ; ./post-install.sh ; cd "$parent_dir"
```
