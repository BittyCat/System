#!/bin/bash

sync_help(){
  echo "sync <source> <destination> [-n|--dry-run]"
  echo "  -n, --dry-run Perform a dry run without making changes"
}

sync(){
  [[ -z "$1" || -z "$2" ]] && sync_help && return 1
  ionice -c 2 -n 4 \
    rsync -HagPov --delete --out-format=" %t %i %n%L" "${1%/}/" "${2%/}/" $3
}

free(){
  df --block-size 1000 --output="source,size,used,pcent,iused,target" "$@"
}
