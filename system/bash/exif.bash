#!/bin/bash

_exif(){
  mode='FileName'
  [[ "$2" == "-n" ]] && mode='TestName'

  exiftool \
    -if 'not $DateTimeOriginal' '-FileModifyDate>DateTimeOriginal' -execute \
    '-DateTimeOriginal>'${mode} -d '%Y%m%d%H%M%S%%-2c.%%le' -common_args -r -P -overwrite_original \
    "${1%/}/" 2>&1 | sed -n "s/'.*\/\(.*\)' --> '.*\/\(.*\)'/\2 <-- \1/p"
}

exif(){
  [[ "$@" == *"-h"* ]] && {
    echo "exif <directory> [-n|-h]"
    echo "        Rename files based on their EXIF datetime."
    echo "  -n    Do not rename files, only print changes."
    echo "  -h    Show this help message."
    return 0
  }

  [[ ! -d "$1" ]] && echo "Error: Directory does not exist." && return 1

  echo $'\n'"${1%/}/"$'\n'
  _exif "${1%/}/" -n
  echo # newline

  [[ "$2" == "-n" ]] || _exif "${1%/}/"
}
