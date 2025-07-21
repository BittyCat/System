#!/bin/bash

exif_help(){
  echo "exif <directory> [-n]"
  echo "  -n: Do not rename files, only test changes"
}

# Print file changes without renaming.
exif_test(){
  echo $'\n'"${1%/}/"$'\n'
  exiftool \
    -if 'not $DateTimeOriginal' '-FileModifyDate>DateTimeOriginal' -execute \
    '-DateTimeOriginal>TestName' -d '%Y%m%d%H%M%S%%-2c.%%le' -common_args -r -P \
    "${1%/}/" 2>&1 | grep -v 'Warning' |
  while IFS= read -r line;do
    [[ "${line}" =~ (.*)"' --> "(.*)"'" ]] && {
      echo -en '\033[0;96m'"${BASH_REMATCH[2]##*/}"
      echo -en '\033[0m'" <-- "
      echo -e '\033[0;91m'"[${BASH_REMATCH[1]##*/}]"
    }
  done
  echo -e '\033[0m'
}

# Rename files based on their EXIF data.
exif_rename(){
  exiftool \
    -if 'not $DateTimeOriginal' '-FileModifyDate>DateTimeOriginal' -execute \
    '-DateTimeOriginal>FileName' -d '%Y%m%d%H%M%S%%-2c.%%le' -common_args -r -P \
    -overwrite_original \
    "${1%/}/" 2>&1 | grep -v 'Warning'
  echo # newline
}

# Main function to handle EXIF operations.
exif(){
  [[ "$1" == "-h" ]] && exif_help && return 0
  [[ ! -d "$1" ]] && echo "Error: Directory does not exist." && return 1
  exif_test "$1"
  [[ "$2" == "-n" ]] && return 0
  exif_rename "$1"
}
