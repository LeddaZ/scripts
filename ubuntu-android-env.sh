#!/usr/bin/env bash

# Script to setup an AOSP Build environment on Ubuntu and Linux Mint
# Based on https://github.com/akhilnarang/scripts/blob/master/setup/android_build_env.sh

# Install packages
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev jq python htop neofetch lm-sensors -y

# Compile git with openssl
git clone https://github.com/paul-nelson-baker/git-openssl-shellscript
cd git-openssl-shellscript
sudo bash ./compile-git-with-openssl.sh -skiptests
cd ..
source $HOME/.profile

# Setup git credentials
GIT_USERNAME="$(git config --get user.name)"
GIT_EMAIL="$(git config --get user.email)"
echo "Configuring git"
if [[ -z ${GIT_USERNAME} ]]; then
    echo -n "Enter your name: "
    read -r NAME
    git config --global user.name "${NAME}"
fi
if [[ -z ${GIT_EMAIL} ]]; then
    echo -n "Enter your email: "
    read -r EMAIL
    git config --global user.email "${EMAIL}"
fi
git config --global credential.helper "cache --timeout=7200"
echo "git identity setup successfully!"

# Install repo
echo "Installing repo"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
source $HOME/.profile
