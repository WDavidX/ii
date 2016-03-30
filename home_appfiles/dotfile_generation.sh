#!/bin/bash


if [ -v "${II_DIR}" ]; then 
  II_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
fi

if [ -v "${II_HOMEAPP_DIR}" ]; then 
  II_HOMEAPP_DIR="${II_DIR}/home_appfiles"
fi

########## .emacs
echo ";; Generated .emacs on `date`" > "$II_HOMEAPP_DIR/.emacs"
echo "(load-file \"${II_DIR}/emacs_basic.el\")" >> "$II_HOMEAPP_DIR/.emacs"

########## .bashrc
echo "## Generated .bashrc on `date`" > "$II_HOMEAPP_DIR/.bashrc"
echo -e "if [ -f ${II_DIR}/bashrc.sh ]; then \n  source ${II_DIR}/bashrc.sh \nfi" >> "$II_HOMEAPP_DIR/.bashrc"


    
