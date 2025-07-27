#!/bin/bash

pass(){
  [[ "$@" == *"-h"* ]] && {
    echo "pass <directory> [options]"
    echo "        List all files in the given directory."
    echo "  -a    Exclude audio files (m4a, mp3)."
    echo "  -i    Exclude image files (jpg, jpeg, png, mov, avi, mp4)."
    echo "  -e    Exclude files with timestamps (YYYYMMDDHHMMSS)."
    echo "  -d    Print duplicate (exif) files with timestamps (YYYYMMDDHHMMSS-CC)."
    echo "  -h    Show this help message."
    return 1
  }

  case "$2" in
    -a) rgx='.*\.(m4a|mp3)$'; opt="-not";;
    -i) rgx='.*\.(jpg|JPG|jpeg|png|PNG|mov|MOV|avi|mp4)$'; opt="-not";;
    -e) rgx='.*/[0-9]{14}(-[0-9]{2})?\..*'; opt="-not";;
    -d) rgx='.*/[0-9]{14}-[0-9]{2}\..*'; opt="";;
     *) rgx='.*/.*'; opt="";;
  esac

  [[ ! -d "$1" ]] && echo "Error: Directory does not exist." && return 1

  echo $'\n'"${1%/}/"$'\n'
  find "${1%/}/" -type f -regextype posix-extended ${opt} -regex ${rgx} -printf "%P\n"
  echo # newline
}
