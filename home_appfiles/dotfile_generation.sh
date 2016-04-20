#!/bin/bash


if [ -v "${II_DIR}" ]; then 
  II_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
fi

if [ -v "${II_HOMEAPP_DIR}" ]; then 
  II_HOMEAPP_DIR="${II_DIR}/home_appfiles"
fi

########## .emacs
echo -e ";; Generated .emacs on `date`" > "$II_HOMEAPP_DIR/.emacs"
echo -e "(load-file \"${II_DIR}/emacs.el\")\n" >> "$II_HOMEAPP_DIR/.emacs"

########## .bashrc
echo -e "## Generated .bashrc on `date`" > "$II_HOMEAPP_DIR/.bashrc"
echo -e "if [ -f ${II_DIR}/bashrc.sh ]; then \n  source ${II_DIR}/bashrc.sh \nfi\n" >> "$II_HOMEAPP_DIR/.bashrc"


    
