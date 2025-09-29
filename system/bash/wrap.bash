#!/bin/bash

wrap(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "wrap <file> [options]"
    echo "        Wraps a file using vim's wrap.vim script."
    echo "  -E    Display $ at the end of each line."
    echo "  -h    Show this help message."
    return 0
  }

  cp "$1" "$1".bak
  vim -c "call Wrap()" -c "qa!" "$1".bak
  cat $2 "$1".bak
  rm -f "$1".bak
}

print(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "print <file> [file2 ...]"
    echo "        Prints file(s) with $ at the end of each line."
    echo "  -h    Show this help message."
    return 0
  }

  for file in "$@"; do
    echo $'\033[36m'$'\n'"$file"$'\n'$'\033[0m'
    while IFS= read -r line; do
      echo "  $line"$'\033[36m''$'$'\033[0m'
    done < "$file"
    echo
  done
}
