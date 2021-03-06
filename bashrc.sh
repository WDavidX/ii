#!/bin/bash

############################################################
########## Environment Varibles Setup
############################################################
umask 077

source_if_exist(){
  if [ -f "$1" ]; then source "$"
  fi
}

############################################################
########## Environment Varibles Setup
############################################################
II_DIR_NAME='ii'
#II_DIR=${HOME}/${II_DIR_NAME}
II_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
II_BASH_DIR=${II_DIR}/login_bash

export II_DIR

unset LS_COLORS
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.tbz=01;31:*.tbz2=01;31:*.bz=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.nnmng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=01;36:*.au=01;36:*.flac=01;36:*.mid=01;36:*.midi=01;36:*.mka=01;36:*.mp3=01;36:*.mpc=01;36:*.ogg=01;36:*.ra=01;36:*.wav=01;36:*.axa=01;36:*.oga=01;36:*.spx=01;36:*.xspf=01;36:*.txt=0:' 
LS_COLORS=$LS_COLORS:'di=4;34:ln=1;35:or=0;31;01:mi=01;05;95:' ; export LS_COLORS
# http://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console

############################################################
########## Terminal Only Configuration
############################################################

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ -t 1 ] ; then 
  # PS1=">\[\033[s\]\[\033[1;\$((COLUMNS-5))f\]\$(date +%H:%M)\[\033[u\]" Time on top right
  # PS1="\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[0;32m\];)\"; else echo \"\[\033[0;31m\];(\"; fi)\[\033[00m\] : "
  # PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\03
  if [ -f "${II_BASH_DIR}/login_1color.sh" ] 
  then 
    source "${II_BASH_DIR}/login_1color.sh"
  fi  
  
  # BASH_PS1_DEFAULT="\n# ${Cyan}\#/\! ${Green}\u@\h ${Cyan}\$(date +%k:%M:%S) ${BBlue}\w${Color_Off}   \n    "
  # BASH_PS1_DEFAULT="# ${Cyan}\#/\! ${Green}\u ${Cyan}\$(date +%k:%M) ${BBlue}\w${Color_Off}  "    # bash bug
  # BASH_PS1_DEFAULT="# ${Cyan}\#/\! ${Green}\u@\h ${Cyan}\$(date +%k:%M:%S) ${BBlue}\w${Color_Off}   \n    "
  # BASH_PS1_DEFAULT="\[1;37\]\#/\! \u@\h \$(date +%k:%M:%S) \w   "
  # BASH_PS1_DEFAULT="#${Cyan}\#/\! ${Green}\u@\h ${Cyan}\$(date +%k:%M) ${BBlue}\w${Color_Off}   "
  if [ -f "${II_BASH_DIR}/git_prompt.sh" ]
  then
    source "${II_BASH_DIR}/git_prompt.sh"
    BASH_PS1_DEFAULT="#${Cyan}\# ${Green}\u ${Cyan}\$(date +%k:%M) ${BBlue}\w${Purple}${Purple}\$(__git_ps1)${Color_Off} "
    # Please notice that the command __git_ps1 was enclosed by \$(__git_ps1) so it does not expand immediately.
    # It is expected to be expanded at each prompt. Normal $(__git_ps1) does not work at each prompt
  else
    BASH_PS1_DEFAULT="#${Cyan}\# ${Green}\u ${Cyan}\$(date +%k:%M) ${BBlue}\w${Color_Off}  "
  fi
fi
 
############################################################
########## BASH Only Configuration
############################################################


__git_ps1_foo(){
  echo -n $(__git_ps1 "(%s)  ")
}

if [ "${SHELL}" = "/bin/bash" ] ; then 
  export PS1=${BASH_PS1_DEFAULT}
  # . /etc/bash_completion
  source_if_exist "/etc/bash_completion"
fi
  

############################################################
########## BASH Alaises
############################################################
#for file_itr in $(find ${II_BASH_DIR}  -maxdepth 1 -name "bash_*.sh" -type f  ! -name "bash_bashrc.sh" ! -name "bash_color.sh" -printf "%f ")
for i in ${II_BASH_DIR}/login_??*
  do
    if [ $(basename $i) = "login_3startup.sh" ] ; then 
      continue
    fi
    if [ -t 1 ] ; then  # terminal output
      echo ${i} > /dev/null
      source $i > /dev/null
    else
      source $i > /dev/null  # accessing using SCP, avoiding buffer overflow
    fi  
done
  

############################################################
########## Programming compiler
############################################################
if [ hash clang 2>/dev/null ]; then
  export CC=clang
else
  export CC=gcc
fi

export CFLAGS="-ggdb3 -O0 -std=c99 -Wall -Werror"
export LDLIBS="-lm"
