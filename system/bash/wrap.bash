#!/bin/bash

vim_wrap_help(){
  echo "vim_wrap <file> [-E|--show-ends]"
  echo "  -E, --show-ends: Display $ at end of each line"
}

vim_wrap(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {

    return 0
  }


  [[ -z "$1" ]] && vim_wrap_help && return 1
  [[ "$1" == '-h' ]] && vim_wrap_help && return 1
  # Work on a copy of the file.
  cp "$1" "$1".bak
  # Use Vim to wrap the text.
  vim -c "call Wrap()" -c "qa!" "$1".bak
  # Display the wrapped text.
  cat $2 "$1".bak
  # Remove the backup file.
  rm -f "$1".bak
}

print(){
  for file in "$@"; do
    echo $'\033[36m'$'\n'"$file"$'\n'$'\033[0m' # Green color
    while IFS= read -r line; do
      echo "  $line"$'\033[36m''$'$'\033[0m' # Cyan color
    done < "$file"
    echo # newline
  done
}
