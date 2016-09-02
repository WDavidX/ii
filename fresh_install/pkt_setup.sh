#!/bin/bash

############################################################
########## Global varibles
############################################################
n_pkg=0

############################################################
########## functions
############################################################

init_setup(){
    sudo dpkg --configure -a # consolidate previous installs
    sudo apt-get update
    sudo apt-get dist-upgrade
    sudo apt-get install -y software-properties-common # get software sources
    sudo apt-get build-dep -y ntp 
}

inst_pkgs(){
    n_chunk=0
    for i in "$@"
    do
        echo -e "\n#package  $((n_pkg+1)) $i"
        sudo -i apt-get install -y $1
        n_pkg=$((n_pkg+1))
        n_chunk=$((n_chunk+1))
    done 
}

wrap_up(){
    sudo apt-get upgrade --all -y
}


############################################################
########## apt-get updates and preparation
############################################################
INIT_SETUP_DIR=$(pwd)
echo -e "\nInstallation starts $(pwd)"

############################################################
########## Essential tools
############################################################

apt_pkgs=(
    "emacs"                
    "screen"            
    "tightvncserver"
    "bash-completion"
    "git"
    "htop"    
    "ntpdate"
    "openssh-client"
    "openssh-server"
    "vim"
    "picocom"
)
inst_pkgs "${apt_pkgs[@]}"

############################################################
########## Python
############################################################


########## system library
apt_pkgs=(
    "build-essential" "libssl-dev" "libffi-dev" "libncurses5-dev"
    "ntp" "pps-tools" "setserial"
    "i2c-tools"  "libi2c-dev" "samba-common"
    "xorg-dev" "libpng12-dev" "libjpeg8-dev" "libgif-dev" 
    "libtiff5" "libtiff5-dev" 
)
inst_pkgs "${apt_pkgs[@]}"

########## programming packages
apt_pkgs=(
    "python"  "python-pip"  "python3" "python3-pip" 
    "python-dev" "pep8" "python-pandas" "python-smbus"
    "spyder"
    "gpsd" "gpsd-clients" "python-gps"
    "clang" "g++" "openjdk-7-jdk" "mono-complete"
)
inst_pkgs "${apt_pkgs[@]}"

########## addtional packages
apt_pkgs=(
    "iselect" "screenie" "tcsh" "nload" "iptraf" "iftop"
    "nethogs" "slurm" "bmon" "collectl" "" 
)
inst_pkgs "${apt_pkgs[@]}"

wrap_up

echo -e "############################################################"
echo -e "########## Total number of packages: $n_pkg"
echo -e "############################################################"
