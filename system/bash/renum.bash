#!/bin/bash

_prevent_overwrite(){
  dirname="${1%/}"

  for file in "${dirname}"/*;do
    ext="${file##*.}"
    basename="${file##*/}"
    mv "${file}" "${dirname}/_${basename}_.${ext}" 2>/dev/null
  done
}

_renum(){
  dirname="${1%/}"
  filename="$2"
  index=$3

  for file in "${dirname}"/*;do
    renum=`printf '%02d' ${index}`
    ext="${file##*.}"
    renamed="${dirname}/${filename}_${renum}.${ext}"
    [[ "$4" == "-n" ]] && echo "${renamed##*/} <-- ${file##*/}" || mv "${file}" "${renamed}"
    ((index++))
  done
}

renum(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "renum <directory> <prefix> <start_index> [options]"
    echo "        Renumber files in a directory with a prefix and zero-padded index."
    echo "  -n    Do not rename files, only print changes."
    echo "  -h    Show this help message."
    return 0
  }

  [[ ! -d "$1" ]] && {
    echo "Error: Directory '$1' does not exist or is not a directory."
    return 1
  }
  [[ -z "$2" ]] && {
    echo "Error: Prefix is required."
    return 1
  }
  [[ -z "$3" ]] && {
    echo "Error: Start index is required."
    return 1
  }

  _renum "$@" -n

  [[ "$4" == "-n" ]] && return 0

  _prevent_overwrite "$1"
  _renum "$@"
}
