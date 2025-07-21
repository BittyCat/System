#!/bin/bash

ytdl_help(){
  echo "ytdl [-a|-v] <directory>"
  echo "  -a: Audio only (m4a)"
  echo "  -v: Video and audio (mp4)"
}

ytdl(){
  case "$1" in
    -a) fmt='ba[ext=m4a]';;
    -v) fmt='bv[ext=mp4]+ba[ext=m4a]';;
     *) ytdl_help && return 1;;
  esac
  yt-dlp -f ${fmt} -o "${2%/}/%(title)s.%(ext)s" -a -
}
