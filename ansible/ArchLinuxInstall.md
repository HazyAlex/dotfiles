# Arch Linux

This guide assumes you have booted into the live ISO (in UEFI mode).

Stack:

  - RAID 1
  - btrfs
  - systemd-boot

Disk layout:

  - /dev/sda -> 16GB USB (Live ISO)
  - /dev/nvme0n1 -> Disk 1 (1 TB)
  - /dev/nvme1n1 -> Disk 2 (1 TB)

## Table of Contents

1. [Wiping the partitions table](#1-wiping-the-partitions-table)
2. [Partition the disks](#2-partition-the-disks)
3. [Format ESPs](#3-format-esps)
4. [Creating the RAID1](#4-creating-the-raid1)
5. [Encrypt the RAID](#5-encrypt-the-raid)
6. [Mounting (btrfs)](#6-mounting-btrfs)
7. [Wifi setup (optional)](#7-wifi-setup-optional)
8. [Installing the base system](#8-installing-the-base-system)
9. [System setup](#9-system-setup)
10. [Installing and configuring systemd-boot](#10-installing-and-configuring-systemd-boot)
11. [Synchronizing /boot between disks](#11-synchronizing-boot-between-disks)
12. [Finalizing and rebooting](#12-finalizing-and-rebooting)
13. [Wifi setup (part two) (optional)](#13-wifi-setup-part-two-optional)
14. [Updating the system](#14-updating-the-system)
15. [Creating a regular user](#15-creating-a-regular-user)
16. [Run the bootstrap script](#16-run-the-bootstrap-script)

## 1. Wiping the partitions table

Remove any pre-existing partition tables.

```
sgdisk --zap-all /dev/nvme0n1
sgdisk --zap-all /dev/nvme1n1
```

Validate the partitions with:

```
lsblk -o NAME,SIZE
```

## 2. Partition the disks

```
sgdisk -n1:0:+512M -t1:ef00 -c1:"EFI System" /dev/nvme0n1
sgdisk -n2:0:0     -t2:fd00 -c2:"Linux RAID" /dev/nvme0n1

sgdisk -n1:0:+512M -t1:ef00 -c1:"EFI System" /dev/nvme1n1
sgdisk -n2:0:0     -t2:fd00 -c2:"Linux RAID" /dev/nvme1n1
```

## 3. Format ESPs

```
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.fat -F32 /dev/nvme1n1p1
```

## 4. Creating the RAID1

```
mdadm --create --verbose /dev/md0 \
    --level=1 --raid-devices=2 \
    --metadata=1.2 --assume-clean \
    /dev/nvme0n1p2 /dev/nvme1n1p2
```

Check the status:

```
cat /proc/mdstat
mdadm --detail /dev/md0
```

## 5. Encrypt the RAID

```
cryptsetup luksFormat --type luks2 /dev/md0
cryptsetup open /dev/md0 cryptroot
```

Optionally add a second passphrase (useful for recovery):

```
cryptsetup luksAddKey /dev/md0
```

Check the status:

```
cryptsetup status cryptroot
```

## 6. Mounting (btrfs)

```
mkfs.btrfs -f /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
umount /mnt

mount -o defaults,compress=zstd,subvol=@ /dev/mapper/cryptroot /mnt

mkdir -p /mnt/home
mount -o defaults,compress=zstd,subvol=@home /dev/mapper/cryptroot /mnt/home

mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
mkdir -p /mnt/boot2
mount /dev/nvme1n1p1 /mnt/boot2
```

## 7. Wifi setup (optional)

```
iwctl device list
iwctl station <device> scan              # scan for networks
iwctl station <device> get-networks      # list networks
iwctl station <device> connect <SSID>    # connect to network
```

## 8. Installing the base system

```
pacstrap /mnt base linux linux-firmware vim networkmanager btrfs-progs mdadm cryptsetup dosfstools efibootmgr rsync
```

```
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt /bin/bash
```

## 9. System setup

```
ln -sf /usr/share/zoneinfo/{ZONE} /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf


# Choose a hostname
echo "{HOSTNAME}" > /etc/hostname

# Add a root password
passwd

# Ensure we have wifi after booting
systemctl enable NetworkManager

# Configure the RAID
mdadm --detail --scan >> /etc/mdadm.conf

# Configure disk encryption
LUKS_UUID=$(cryptsetup luksUUID /dev/md0)

echo "cryptroot UUID=${LUKS_UUID} none luks" >> /etc/crypttab
```

Configure mkinitcpio hooks:
`vim /etc/mkinitcpio.conf`

```
# Ensure it looks something like (the order is important, i.e. needs to have `mdadm_udev` before `encrypt`):
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block mdadm_udev encrypt filesystems fsck)
```

```
mkinitcpio -P
```

## 10. Installing and configuring systemd-boot

```
bootctl --path=/boot install

cat > /boot/loader/loader.conf <<EOF
    default arch
    timeout 3
    editor no
EOF

cat > /boot/loader/entries/arch.conf <<EOF
    title   Arch Linux
    linux   /vmlinuz-linux
    initrd  /initramfs-linux.img
    options cryptdevice=UUID=${LUKS_UUID}:cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rw
EOF
```

Copy the boot folder so we can boot from either disk if one of them fails:

```
mount /dev/nvme1n1p1 /boot2
bootctl --path=/boot2 install
cp -a /boot/* /boot2/
umount /boot2
```

## 11. Synchronizing /boot between disks

```
mkdir -p /etc/pacman.d/hooks
```

`vim /etc/pacman.d/hooks/95-esp-sync.hook`

```
[Trigger]
Operation = Install
Operation = Upgrade
Type = Package
Target = linux
Target = systemd

[Action]
Description = Sync ESP /boot to /boot2
When = PostTransaction
Exec = /usr/local/bin/sync-esp.sh
```

`vim /usr/local/bin/sync-esp.sh`

```
#!/bin/bash
set -e
rsync -a --delete /boot/ /boot2/
```

```
chmod +x /usr/local/bin/sync-esp.sh
```

## 12. Finalizing and rebooting

```
exit
umount -R /mnt
reboot

# Remove the USB with the Live ISO now!
```

## 13. Wifi setup (part two) (optional)

Since we're using NetworkManager we'll need to setup the wifi once again.

```
nmtui

# Select "Activate a connection"
# Choose the SSID and input the password
# We're done!
```

## 14. Updating the system

```
pacman -Sy archlinux-keyring
pacman -Syu
```

## 15. Creating a regular user

```
pacman -S sudo
useradd -m -G wheel {USER}
passwd {USER}

# Enable sudo for wheel group
# Uncomment "%wheel ALL=(ALL) ALL" in `/etc/sudoers`
```

## 16. Run the bootstrap script

```
# Log out (`exit`) and log back in with the newly created user (previous step).

wget https://raw.githubusercontent.com/HazyAlex/dotfiles/refs/heads/main/linux-bootstrap.sh
chmod u+x ./linux-bootstrap.sh
./linux-bootstrap.sh
```
