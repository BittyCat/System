# System
Check out my System for Linux, Ubuntu and WSL!

This repository contains a collection of scripts and tools designed to enhance the functionality of Linux, Ubuntu, and WSL (Windows Subsystem for Linux). The scripts are primarily written in Bash and are intended to automate various tasks, improve system management, and streamline workflows.

Scripts:
- **exif.bash**: Rename files based on their EXIF datetime.
- **pass.bash**: Print files in a directory excluding audio files, image files, exif files, or print duplicate (exif) files.
- **renum.bash**: Renumber files in a directory with a prefix and zero-padded index.

## exif.bash
```
exif <directory> [-n|-h]
        Rename files based on their EXIF datetime.
  -n    Do not rename files, only print changes.
  -h    Show this help message.
```

### Example
```
rsync -aHog --delete-after test/ run/
. system/bash/exif.bash
exif run/ -n
```

**Output**
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

### Example
```
rsync -aHog --delete-after test/ run/
. system/bash/pass.bash
```

#### Exclude audio files (m4a, mp3)
```
pass run/ -a
```

**Output**
```
run/

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

#### Exclude image files (jpg, jpeg, png, mov, avi, mp4)
```
pass run/ -i
```

**Output**
```
run/

calming-rain-257596.mp3
```

#### Exclude files with timestamps (YYYYMMDDHHMMSS)
```
. system/bash/exif.bash
exif run/
pass run/ -e
```

**Output**
```
run/

calming-rain-257596.mp3
```

#### Print duplicate files with timestamps (YYYYMMDDHHMMSS-SS)
```
pass run/ -d
```

**Output**
```
run/

20250721174222-01.jpg
```

## renum.bash
```
renum <directory> <prefix> <start_index> [-n]
        Renumber files in a directory with a prefix and zero-padded index.
  -n    Do not rename files, only print changes.
```

### Example
```
rsync -aHog --delete-after test/ run/
. system/bash/renum.bash
renum run/ file 1 -n
```

**Output**
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
```

