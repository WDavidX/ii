#!/bin/bash

DIR_SCRIPT_PWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR_DOWNLOAD_NAME="dowload_packages"
DIR_DOWNLOAD_PATH="${DIR_SCRIPT_PWD}/${DIR_DOWNLOAD_NAME}"

git clone https://github.com/emacs-helm/helm.git "${DIR_DOWNLOAD_PATH}/helm" 2>/dev/null

cd "${DIR_DOWNLOAD_PATH}/helm"
git pull origin master

emacs_lisp_list=("cl-lib.el" "eieio-base.el" "eieio-compat.el" "eieio-core.el" "eieio-custom.el" "eieio-datadebug.el" "eieio-opt.el" "eieio-speedbar.el" "eieio.el" "gv.el")
emacs_lisp_link="https://raw.githubusercontent.com/emacs-mirror/emacs/master/lisp/emacs-lisp"

for i in ${emacs_lisp_list[@] }; do
  file_link="${emacs_lisp_link}/${i}"
  file_local="${DIR_DOWNLOAD_PATH}/helm/${i}"
  rm -f ${file_local}
  wget  -q -nc  -O "${file_local}" --no-check-certificate "${file_link}" 
done

cd "${DIR_SCRIPT_PWD}"