# System
Check out my System for Linux, Ubuntu and WSL!

This repository contains a collection of scripts and tools designed to enhance the functionality of Linux, Ubuntu, and WSL (Windows Subsystem for Linux). The scripts are primarily written in Bash and are intended to automate various tasks, improve system management, and streamline workflows.

Scripts:
- **exif.bash**: Rename files based on their EXIF datetime.
- **pass.bash**: Print files in a directory excluding audio files, image files, exif files, or print duplicate (exif) files.
- **renum.bash**: Renumber files in a directory with a prefix and zero-padded index.

For every script:\
`. system/bash/<script_name>.bash`\
For some scripts, when using `run/`:\
`rsync -aHog --delete-after test/ run/`

## exif.bash
```
exif <directory> [-n|-h]
        Rename files based on their EXIF datetime.
  -n    Do not rename files, only print changes.
  -h    Show this help message.
```

`exif run/ -n`
```
20250721174321.jpg <-- 17677.jpg
20250721174157.jpg <-- 2148799121.jpg
20250721174329.jpg <-- 2149271448.jpg
20250721174140.jpg <-- 2149512970.jpg
20250721174239.jpg <-- 26163.jpg
20250721174125.jpg <-- 26171.jpg
20250721174231.jpg <-- aromatic-cup-tea-winter-table-forest.jpg
20250721174222.jpg <-- happy-marshmallow-snowmen-christmas-winter-holiday-decorations copy.jpg
20250721174222-01.jpg <-- happy-marshmallow-snowmen-christmas-winter-holiday-decorations.jpg
```

## pass.bash
```
pass <directory> [options]
        List all files in the given directory.
  -a    Exclude audio files (m4a, mp3).
  -i    Exclude image files (jpg, jpeg, png, mov, avi, mp4).
  -e    Exclude files with timestamps (YYYYMMDDHHMMSS).
  -d    Print duplicate (exif) files with timestamps (YYYYMMDDHHMMSS-CC).
  -h    Show this help message.
```

`pass run/ -a`
```
17677.jpg
2148799121.jpg
2149271448.jpg
2149512970.jpg
26163.jpg
26171.jpg
aromatic-cup-tea-winter-table-forest.jpg
happy-marshmallow-snowmen-christmas-winter-holiday-decorations copy.jpg
happy-marshmallow-snowmen-christmas-winter-holiday-decorations.jpg
```

`pass run/ -i`
```
calming-rain-257596.mp3
```

`pass run/ -e` (after running `exif run/`)
```
calming-rain-257596.mp3
```

`pass run/ -d` (after running `exif run/`)
```
20250721174222-01.jpg
```

## renum.bash
```
renum <directory> <prefix> <start_index> [-n]
        Renumber files in a directory with a prefix and zero-padded index.
  -n    Do not rename files, only print changes.
  -h    Show this help message.
```

`renum run/ file 1 -n`
```
file_01.jpg <-- 17677.jpg
file_02.jpg <-- 2148799121.jpg
file_03.jpg <-- 2149271448.jpg
file_04.jpg <-- 2149512970.jpg
file_05.jpg <-- 26163.jpg
file_06.jpg <-- 26171.jpg
file_07.jpg <-- aromatic-cup-tea-winter-table-forest.jpg
file_08.mp3 <-- calming-rain-257596.mp3
file_09.jpg <-- happy-marshmallow-snowmen-christmas-winter-holiday-decorations copy.jpg
file_10.jpg <-- happy-marshmallow-snowmen-christmas-winter-holiday-decorations.jpg
```

## sync.bash

### sync
```
sync <source> <destination> [-n]
        Synchronize files from source to destination.
  -n    Perform a dry run without making changes.
  -h    Show this help message.
```

`sync test/ test2/ -n`
```
sending incremental file list
 2025/08/10 19:06:37 .d..t...... ./
 2025/08/10 19:06:37 >f+++++++++ 17677.jpg
 2025/08/10 19:06:37 >f+++++++++ 2148799121.jpg
 2025/08/10 19:06:37 >f+++++++++ 2149271448.jpg
 2025/08/10 19:06:37 >f+++++++++ 2149512970.jpg
 2025/08/10 19:06:37 >f+++++++++ 26163.jpg
 2025/08/10 19:06:37 >f+++++++++ 26171.jpg
 2025/08/10 19:06:37 >f+++++++++ aromatic-cup-tea-winter-table-forest.jpg
 2025/08/10 19:06:37 >f+++++++++ calming-rain-257596.mp3
 2025/08/10 19:06:37 >f+++++++++ happy-marshmallow-snowmen-christmas-winter-holiday-decorations copy.jpg
 2025/08/10 19:06:37 >f+++++++++ happy-marshmallow-snowmen-christmas-winter-holiday-decorations.jpg

sent 444 bytes  received 49 bytes  986.00 bytes/sec
total size is 21,699,082  speedup is 44,014.37 (DRY RUN)
```

### free
```
free <mountpoint> [<mountpoint> ...]
        Display free space on the specified mount points.
  -h    Show this help message.
```

`free /mnt/c`
```
Filesystem     1kB-blocks      Used Use%   IUsed Mounted on
C:\             510694257 442355512  87% -999001 /mnt/c
```

## vim.bash
```
```
