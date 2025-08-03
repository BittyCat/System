#!/bin/bash

renum(){
  [[ "$@" == *"-h"* ]] && {
    echo "renum <directory> <prefix> <start_index> [-n]"
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

  index=$3
  for file in "${1%/}"/*;do
    renum=`printf '%02d' ${index}`
    renamed="${1%/}/$2_${renum}.${file##*.}"
    echo "${renamed##*/} <-- ${file##*/}"
    ((index++))
  done

  [[ "$4" == "-n" ]] && return 0

  for file in "${1%/}"/*;do # prevent overwrite
    mv "${file}" "${file}_renum.${file##*.}" 2>/dev/null
  done

  index=$3
  for file in "${1%/}"/*;do
    renum=`printf '%02d' ${index}`
    renamed="${1%/}/$2_${renum}.${file##*.}"
    mv "${file}" "${renamed}"
    ((index++))
  done
}
