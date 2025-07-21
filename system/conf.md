# Configuration for Ubuntu

## Repositories and Packages

```bash
sudo apt -y update
xargs -a repo.conf sudo add-apt-repository -y
xargs -a pkg.conf sudo apt install -y
sudo apt -y upgrade
sudo apt -y autoremove
```

## Synchronize Files

```bash
rsync -aHog -vPin sync/home/ ~/
sudo rsync -aHog -vPi sync/etc/ /etc/
```

## GNOME Configuration

```bash
dconf load / < gnome.conf
```

## Append bashrc

```bash
echo >> ~/.bashrc # Empty line
cat bash.rc >> ~/.bashrc
```

## Save Files

```bash
sudo rsync -aHog -vPin /etc/fstab save/
rsync -aHog -vPin ~/.local/share/rhythmbox/rhythmdb.xml save/
```
