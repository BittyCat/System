#!/bin/bash

ytdl(){
  [[ "$@" == *"-h"* || -z "$1" ]] && {
    echo "ytdl [options] <directory>"
    echo "  -a    Audio only (m4a)."
    echo "  -v    Video and audio (mp4)."
    echo "  -h    Show this help message."
    return 0
  }

  fmt='ba[ext=m4a]'
  case "$1" in
    -v) fmt='bv[ext=mp4]+ba[ext=m4a]';;
     *) echo "Invalid option. Use -h for help."; return 1;;
  esac

  yt-dlp -f ${fmt} -o "${2%/}/%(title)s.%(ext)s" -a -
}
