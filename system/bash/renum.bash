#!/bin/bash

renum_help(){
  echo "renum <directory> <prefix> <start_index> [-n]"
  echo "  -n: Do not rename files, only print changes"
}

# Print file changes with a prefix and a zero-padded index.
renum_print(){
  index=$3
  for file in "${1%/}"/*;do
    renum=`printf '%02d' ${index}`
    renamed="${1%/}/$2_${renum}.${file##*.}"
    echo -en '\033[0;96m'"${renamed}"
    echo -en '\033[0m'" <-- "
    echo -e '\033[0;91m'"[${file##*/}]"
    ((index++))
  done
}

# Prevent overwriting existing files by renaming them.
renum_prevent_overwrite(){
  for file in "${1%/}"/*;do
    mv "${file}" "${file}_renum.${file##*.}" 2>/dev/null
  done
}

# Rename files with a prefix and a zero-padded index.
renum_rename(){
  index=$3
  for file in "${1%/}"/*;do
    renum=`printf '%02d' ${index}`
    renamed="${1%/}/$2_${renum}.${file##*.}"
    mv "${file}" "${renamed}"
    ((index++))
  done
}

# Main function to handle renumbering files.
renum(){
  [[ "$1" == "-h" ]] && renum_help && return 0
  [[ ! -d "$1" ]] && {
    echo "Error: Directory does not exist."
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
  renum_print "$1" "$2" "$3"
  [[ "$4" == "-n" ]] && return 0
  renum_prevent_overwrite "$1"
  renum_rename "$1" "$2" "$3"
}
