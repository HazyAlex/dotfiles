# Troubleshooting

If a disk fails (or if you've simply removed it), you can still access the files in the other disk (RAID 1).

```
mdadm --run /dev/md0
cryptsetup luksOpen /dev/md0 cryptroot

mkdir /mnt
mount -o subvol=@ /dev/mapper/cryptroot /mnt
mount -o subvol=@home /dev/mapper/cryptroot /mnt/home
```

Your data is available in `/mnt` and you can now follow other guides to restore the system or alternatively just backup the latest data.

To rebuild the RAID1 after you've added the new disk (or the old one you removed), run the following commands (note that the disk paths might be different and you need to partition the disk!):

```
mdadm --detail /dev/md0

# Check which disk is missing and then add it, if you're unsure see `lsblk -o NAME,TYPE,SIZE,UUID`:
mdadm --add /dev/md0 /dev/nvme1n1p2

# Re-check that both disks are present:
mdadm --detail /dev/md0

# To monitor the RAID1 status:
watch -n 1 cat /proc/mdstat

# If you need to force a rebuild:
echo "repair" > /sys/block/md0/md/sync_action

# And then use the previous command to monitor the status
```
