#!/bin/bash

echo -e "\nInstallation Starts"
echo $pwd
############################################################
########## apt-get updates and preparation
############################################################
sudo dpkg --configure -a # consolidate previous installs
sudo apt-get update
sudo apt-get upgrade -y

############################################################
########## Essentials untilities
############################################################
sudo apt-get install -y emacs
sudo apt-get install -y screen ntpdate 
sudo apt-get install -y tightvncserver 
sudo apt-get install -y bash-completion

############################################################
########## Untilities
############################################################
sudo apt-get install -y git 
sudo apt-get install -y motion

############################################################
########## Compilers and program languages
############################################################
# sudo apt-get install -y 
# Programming tools

# System driver and libraries
sudo apt-get install -y i2c-tools  libi2c-dev samba-common 

# C and C++
sudo apt-get install -y clang 

# Python
sudo apt-get install -y python python-dev python-pip python-pandas python-smbus spyder  pep8

# Java
sudo apt-get install -y openjdk-7-jdk -y

# C sharp
sudo apt-get install -y  mono-complete

# other compilers
sudo apt-get install -y g++      
############################################################
########## Non-essentials
############################################################

# Less common editors
sudo apt-get install -y vim eclipse nano

sudo apt-get install -y iselect screenie   tcsh   htop   nload  iftop iptraf nethogs  bmon slurm tcptrack bwm-ng cbm  lsof collectl  inkscape bashdb    samba 

# X related dependencies
sudo apt-get install -y xorg-dev libpng12-dev libjpeg8-dev libgif-dev libtiff5 libtiff5-dev  libncurses5-dev

# texlive
# sudo apt-get install texlive-xetex latexmk -y 
#sudo apt-get install motion iselect screenie ntpdate python python-dev python-pip python-pandas openjdk-7-jdk tightvncserver  git  emacs tcsh screen vim emacs tcsh g++ nano i2c-tools python-smbus libi2c-dev samba-common eclipse htop screen spyder nload  iftop iptraf nethogs  bmon slurm tcptrack bwm-ng cbm  lsof collectl mono-complete inkscape latexmk bashdb vim pep8 texlive-xetex samba -y

sudo apt-get upgrade -y
