#!/bin/bash

pass_help(){
  echo "pass <directory> [options]"
  echo "  -a: Exclude audio files (m4a, mp3)"
  echo "  -i: Exclude image files (jpg, jpeg, png, mov, avi, mp4)"
  echo "  -e: Exclude files with timestamps (YYYYMMDDHHMMSS)"
  echo "  -1: Duplicate files with timestamps (YYYYMMDDHHMMSS-SS)"
}

pass(){
  [[ "$1" == "-h" ]] && pass_help && return 0
  [[ ! -d "$1" ]] && {
    echo "Error: Directory does not exist."
    return 1
  }
  case "$2" in
    # Exclude audio files.
    -a) regex='.*\.(m4a|mp3)$'; op="-not";;
    # Exclude image files.
    -i) regex='.*\.(jpg|JPG|jpeg|png|PNG|mov|MOV|avi|mp4)$'; op="-not";;
    # Exclude files with timestamps (YYYYMMDDHHMMSS).
    -e) regex='.*/[0-9]{14}(-[0-9]{2})?\..*'; op="-not";;
    # Duplicate files with timestamps (YYYYMMDDHHMMSS-SS).
    -d) regex='.*/[0-9]{14}-[0-9]{2}\..*'; op="";;
    # Default case: no options.
    *) pass_help && return 1;;
  esac
  find "${1%/}/" -type f -regextype posix-extended ${op} -regex ${regex}
}
