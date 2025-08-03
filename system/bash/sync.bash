#!/bin/bash

sync(){
  [[ "$@" == *"-h"* || -z "$1" || -z "$2" ]] && {
    echo "sync <source> <destination> [-n]"
    echo "        Synchronize files from source to destination."
    echo "  -n    Perform a dry run without making changes."
    return 1
  }

  ionice -c 2 -n 4 \
    rsync -HagPov --delete --out-format=" %t %i %n%L" "${1%/}/" "${2%/}/" $3
}

free(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "free <mountpoint> [<mountpoint> ...]"
    echo "        Display free space on the specified mount points."
    return 1
  }

  df --block-size 1000 --output="source,size,used,pcent,iused,target" "$@"
}
