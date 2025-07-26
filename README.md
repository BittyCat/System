# System
Check out my System for Linux, Ubuntu and WSL!

This repository contains a collection of scripts and tools designed to enhance the functionality of Linux, Ubuntu, and WSL (Windows Subsystem for Linux). The scripts are primarily written in Bash and are intended to automate various tasks, improve system management, and streamline workflows.

Scripts:
- **exif.bash**: Rename files based on their EXIF datetime.


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
run/

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


