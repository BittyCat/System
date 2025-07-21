# System Commands

## Print lines between two line numbers

```bash
tail -n +[from_line_number] <file> | head -n [number_of_lines]
```

## Pattern Matching

```bash
grep -B [before_lines] -A [after_lines] '[pattern]' <file>
```

## Permissions

```bash
chown -R 1000:1000 .
find . -type d -exec chmod -R 755 {} \;
find . -type f -exec chmod -R 644 {} \;
```

## Compare Files

```bash
diff <file1> <file2>
```

## Collate Pages

```bash
pdftk A=<pdf_with_odd_pages> B=<pdf_with_even_pages> shuffle A Bend-1 output <pdf_with_collated_pages>
```

## Partitions & Filesystems

```bash
lsblk

sudo umount /dev/sdxN
sudo parted /dev/sdx
mklabel gpt
mkpart prim(ary) fat32 0% 100%
mkpart prim(ary) ntfs 0% 100%
mkpart prim(ary) ext4 0% 100%

sudo mkfs.fat -F 32 -n label /dev/sdxN
sudo mkfs.ntfs -f -L label /dev/sdxN
sudo mkfs.ext4 -L label /dev/sdxN

sudo fatlabel /dev/sdxN label
sudo ntfslabel /dev/sdxN label
sudo e2label /dev/sdxN label

sudo blkid /dev/sdxN

sudo rsync -aHog /etc/fstab ~/fstab
sudo vim /etc/fstab
```

## Media Transfer Protocol

```bash
mkdir -p ~/mnt/samsung
cd ~/mnt/samsung
mtp-detect
jmtpfs ~/mnt/samsung
fusermount -u ~/mnt/samsung
```
