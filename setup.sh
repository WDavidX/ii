#/bin/bash

############################################################
########## Environment Varibles Setup
############################################################
II_DIR_NAME='ii'
II_DIR=${HOME}/${II_DIR_NAME}
II_HOMEDOT_DIR=${II_DIR}/home_dotfiles
II_HOMEAPP_DIR=${II_DIR}/home_appfiles

#FLAG_APPEND_DOTFILE=0
#FLAG_HELP=0

export II_DIR

for i in "$@"; do
  case $i in
    -e=*|--extension=*)
    EXTENSION="${i#*=}"
    shift # past argument=value
    ;;
    -s=*|--searchpath=*)
    SEARCHPATH="${i#*=}"
    shift # past argument=value
    ;;
    -l=*|--lib=*)
    LIBPATH="${i#*=}"
    shift # past argument=value
    ;;
    -h=*|--help=*)
    FLAG_HELP=1
    ;;    
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    --append-dotfiles)
    FLAG_APPEND_DOTFILE=1
    ;;    
    *)
            # unknown option
    echo "Unknow argument: ${i}"
    ;;
  esac
done



############################################################
########## File manipulation
############################################################

## Creating or copying files to home

for i in ${II_HOMEDOT_DIR}/.??* ; # Whitespace-safe but not recursive.
do      
    filename=$(basename "$i")
    home_dot_filename="${HOME}/${filename}"
    if [ ! -f $home_dot_filename ] ; then
      echo -e "No file in $HOME, creating    $filename"
      cp -f $i $home_dot_filename
    else 
      echo -e "Existing file in $HOME, please remove file    $filename"
    fi    
done

## Generate the dot files and append them
if [[ $FLAG_APPEND_DOTFILE ]]; then
  echo -e "Appending the dot files in $HOME"  
  if [ -f ${II_HOMEAPP_DIR}/dotfile_generation.sh ]; then
      source ${II_HOMEAPP_DIR}/dotfile_generation.sh
  fi
  for i in ${II_HOMEAPP_DIR}/.??* ; # Whitespace-safe but not recursive.
  do 
    filename=$(basename "$i")
    home_dot_filename="${HOME}/${filename}"
    file_exist=0      
    if [ -f $home_dot_filename ]; then 
      file_exist=1
    fi
      
    touch ${home_dot_filename}      
    case $filename in
      .emacs)
      echo -e "\n\n\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n;;;;;;;;;; `date`\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n" >> ${home_dot_filename}
      ;;
      .bashrc)
      echo -e "\n\n\n############################################################\n########## `date`\n############################################################\n" >> ${home_dot_filename}
      ;;    
    esac
  
    if [ $file_exist ]; then
      echo -e "Existing file in $HOME, appending    $filename" 
    else 
      echo -e "No file in $HOME, creating    $filename"  
    fi
    cat "$i" >> "${home_dot_filename}"  
  done
fi
  
