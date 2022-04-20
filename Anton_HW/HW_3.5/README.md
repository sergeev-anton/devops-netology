1. Узнайте о sparse (разряженных) файлах.

---
```bash
Разреженные файлы – это специальные файлы, которые с большей эффективностью используют файловую систему, 
они не позволяют ФС занимать свободное дисковое пространство носителя, когда разделы не заполнены.
То есть, «пустое место» будет задействовано только при необходимости. Пустая информация в виде нулей, 
будет хранится в блоке метаданных ФС. Поэтому, разреженные файлы изначально занимают меньший объем носителя,
чем их реальный объем.
```
---

2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

---
```bash
Нет, не могут, т.к. это просто ссылки на один и тот же inode - в нём и хранятся права доступа и имя владельца.
```
---
3. Сделайте vagrant destroy на имеющийся инстанс Ubuntu. Замените содержимое Vagrantfile
---
```bash
vagrant@vagrant:~$ fdisk -l
fdisk: cannot open /dev/loop0: Permission denied
fdisk: cannot open /dev/loop1: Permission denied
fdisk: cannot open /dev/loop2: Permission denied
fdisk: cannot open /dev/loop3: Permission denied
fdisk: cannot open /dev/loop4: Permission denied
fdisk: cannot open /dev/sda: Permission denied
fdisk: cannot open /dev/sdb: Permission denied
fdisk: cannot open /dev/sdc: Permission denied
fdisk: cannot open /dev/mapper/ubuntu--vg-ubuntu--lv: Permission denied
vagrant@vagrant:~$ sudo !!
sudo fdisk -l
Disk /dev/loop0: 55.45 MiB, 58130432 bytes, 113536 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop1: 70.32 MiB, 73728000 bytes, 144000 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop2: 32.3 MiB, 33865728 bytes, 66144 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop3: 43.64 MiB, 45748224 bytes, 89352 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/loop4: 55.53 MiB, 58212352 bytes, 113696 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sda: 64 GiB, 68719476736 bytes, 134217728 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: B4F1CD46-1589-455C-BA21-5171874A019C

Device       Start       End   Sectors Size Type
/dev/sda1     2048      4095      2048   1M BIOS boot
/dev/sda2     4096   2101247   2097152   1G Linux filesystem
/dev/sda3  2101248 134215679 132114432  63G Linux filesystem


Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/ubuntu--vg-ubuntu--lv: 31.51 GiB, 33822867456 bytes, 66060288 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```
---

4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство.
---
```bash
vagrant@vagrant:~$ sudo fdisk /dev/sdb

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xa76d126c.

Command (m for help): p
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xa76d126c

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1):
First sector (2048-5242879, default 2048):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-5242879, default 5242879): +2G

Created a new partition 1 of type 'Linux' and of size 2 GiB.

Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2):
First sector (4196352-5242879, default 4196352):
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-5242879, default 5242879): +510M

Created a new partition 2 of type 'Linux' and of size 510 MiB.

Command (m for help): p
Disk /dev/sdb: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xa76d126c

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdb1          2048 4196351 4194304    2G 83 Linux
/dev/sdb2       4196352 5240831 1044480  510M 83 Linux

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
---

5.Используя sfdisk, перенесите данную таблицу разделов на второй диск.

---
```bash
vagrant@vagrant:~$ sudo sfdisk -d /dev/sdb|sfdisk /dev/sdc
sfdisk: cannot open /dev/sdc: Permission denied

vagrant@vagrant:~$ sudo !!
sudo sudo sfdisk -d /dev/sdb|sfdisk /dev/sdc
sfdisk: cannot open /dev/sdc: Permission denied

vagrant@vagrant:~$ sudo su
root@vagrant:/home/vagrant# sfdisk -d /dev/sdb|sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 2.51 GiB, 2684354560 bytes, 5242880 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new DOS disklabel with disk identifier 0xa76d126c.
/dev/sdc1: Created a new partition 1 of type 'Linux' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux' and of size 510 MiB.
/dev/sdc3: Done.

New situation:
Disklabel type: dos
Disk identifier: 0xa76d126c

Device     Boot   Start     End Sectors  Size Id Type
/dev/sdc1          2048 4196351 4194304    2G 83 Linux
/dev/sdc2       4196352 5240831 1044480  510M 83 Linux

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
root@vagrant:/home/vagrant#
```
---

6. Соберите mdadm RAID1 на паре разделов 2 Гб.

---
```bash
root@vagrant:/home/vagrant# mdadm --create /dev/md1 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90

Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 55.4M  1 loop  /snap/core18/2128
loop1                       7:1    0 70.3M  1 loop  /snap/lxd/21029
loop3                       7:3    0 43.6M  1 loop  /snap/snapd/15177
loop4                       7:4    0 55.5M  1 loop  /snap/core18/2344
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1405
loop6                       7:6    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdb2                      8:18   0  510M  0 part
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdc2                      8:34   0  510M  0 part
root@vagrant:/home/vagrant#
```
---
7. Соберите mdadm RAID0 на второй паре маленьких разделов.
---
```bash
root@vagrant:/home/vagrant# mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb2 /dev/sdc2
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 55.4M  1 loop  /snap/core18/2128
loop1                       7:1    0 70.3M  1 loop  /snap/lxd/21029
loop3                       7:3    0 43.6M  1 loop  /snap/snapd/15177
loop4                       7:4    0 55.5M  1 loop  /snap/core18/2344
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1405
loop6                       7:6    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdb2                      8:18   0  510M  0 part
  └─md0                     9:0    0 1016M  0 raid0
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdc2                      8:34   0  510M  0 part
  └─md0                     9:0    0 1016M  0 raid0
root@vagrant:/home/vagrant#
```
---

8. Создайте 2 независимых PV на получившихся md-устройствах.
---
```bash
root@vagrant:/home/vagrant# pvcreate /dev/md0 /dev/md1
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.
root@vagrant:/home/vagrant#
```
---
9. Создайте общую volume-group на этих двух PV.
---
```bash
root@vagrant:/home/vagrant# vgcreate vg1 /dev/md0 /dev/md1
  Volume group "vg1" successfully created
root@vagrant:/home/vagrant# vgdisplay
  --- Volume group ---
  VG Name               ubuntu-vg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  2
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <63.00 GiB
  PE Size               4.00 MiB
  Total PE              16127
  Alloc PE / Size       8064 / 31.50 GiB
  Free  PE / Size       8063 / <31.50 GiB
  VG UUID               aK7Bd1-JPle-i0h7-5jJa-M60v-WwMk-PFByJ7

  --- Volume group ---
  VG Name               vg1
  System ID
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               2.98 GiB
  PE Size               4.00 MiB
  Total PE              764
  Alloc PE / Size       0 / 0
  Free  PE / Size       764 / 2.98 GiB
  VG UUID               Te5fwV-foMy-FYX9-c2kd-6iYN-RMwO-uXJevL

root@vagrant:/home/vagrant#
```
---

10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.
---
```bash
root@vagrant:/home/vagrant# lvcreate -L 100M vg1 /dev/md0
  Logical volume "lvol0" created.
root@vagrant:/home/vagrant# vgs
  VG        #PV #LV #SN Attr   VSize   VFree
  ubuntu-vg   1   1   0 wz--n- <63.00g <31.50g
  vg1         2   1   0 wz--n-   2.98g  <2.89g
root@vagrant:/home/vagrant# lvs
  LV        VG        Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  ubuntu-lv ubuntu-vg -wi-ao----  31.50g
  lvol0     vg1       -wi-a----- 100.00m
root@vagrant:/home/vagrant#
```
---

11. Создайте mkfs.ext4 ФС на получившемся LV.
---
```bash
root@vagrant:/home/vagrant# mkfs.ext4 /dev/vg1/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done

root@vagrant:/home/vagrant#

root@vagrant:/home/vagrant# blkid
/dev/sda2: UUID="6062f85a-eb61-4c49-900d-65a91b7edafb" TYPE="ext4" PARTUUID="ff72af24-c59d-4944-96df-348799e4036b"
/dev/sda3: UUID="sDUvKe-EtCc-gKuY-ZXTD-1B1d-eh9Q-XldxLf" TYPE="LVM2_member" PARTUUID="c45ff860-2423-4860-a76e-21952819d388"
/dev/mapper/ubuntu--vg-ubuntu--lv: UUID="4855fb55-feed-4397-8ed6-ad6ccc89ef59" TYPE="ext4"
/dev/loop0: TYPE="squashfs"
/dev/loop1: TYPE="squashfs"
/dev/loop3: TYPE="squashfs"
/dev/loop4: TYPE="squashfs"
/dev/loop5: TYPE="squashfs"
/dev/loop6: TYPE="squashfs"
/dev/sda1: PARTUUID="a60c2aff-20c0-48f5-a4f6-0247b8b61491"
/dev/sdb1: UUID="fae7996f-b250-297f-eefa-58be47bb3c06" UUID_SUB="4c4a7d9a-67e5-a226-c696-2433eb9b4bed" LABEL="vagrant:1" TYPE="linux_raid_member" PARTUUID="a76d126c-01"
/dev/sdb2: UUID="9ac65df6-47ec-a89a-eeea-3cec93b1ec89" UUID_SUB="14b376df-ea45-2a74-0984-da331c48b0e2" LABEL="vagrant:0" TYPE="linux_raid_member" PARTUUID="a76d126c-02"
/dev/sdc1: UUID="fae7996f-b250-297f-eefa-58be47bb3c06" UUID_SUB="8092a5ce-4481-daec-d81e-6d41f54c9769" LABEL="vagrant:1" TYPE="linux_raid_member" PARTUUID="a76d126c-01"
/dev/sdc2: UUID="9ac65df6-47ec-a89a-eeea-3cec93b1ec89" UUID_SUB="f5418440-8763-4853-a1d8-f049d52a5718" LABEL="vagrant:0" TYPE="linux_raid_member" PARTUUID="a76d126c-02"
/dev/md1: UUID="2oXFtL-Xs2b-R6Wu-jdJE-vofM-POO5-Z8NKlq" TYPE="LVM2_member"
/dev/md0: UUID="ZoKvkJ-7amJ-qwCh-1dWs-miNU-7wi6-r3QrzV" TYPE="LVM2_member"
/dev/mapper/vg1-lvol0: UUID="35a860d4-ff51-47d5-bd18-c815246b97f5" TYPE="ext4"
root@vagrant:/home/vagrant#
```
---
12. Смонтируйте этот раздел в любую директорию, например, /tmp/new.
---
```bash
root@vagrant:/home/vagrant# mkdir /tmp/new_test
root@vagrant:/home/vagrant# mount /dev/vg1/lvol0 /tmp/new_test/
root@vagrant:/home/vagrant# mount
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
udev on /dev type devtmpfs (rw,nosuid,noexec,relatime,size=457116k,nr_inodes=114279,mode=755)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,noexec,relatime,size=100460k,mode=755)
/dev/mapper/ubuntu--vg-ubuntu--lv on / type ext4 (rw,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)
cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
none on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=28,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=17090)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
/var/lib/snapd/snaps/core18_2128.snap on /snap/core18/2128 type squashfs (ro,nodev,relatime,x-gdu.hide)
/var/lib/snapd/snaps/lxd_21029.snap on /snap/lxd/21029 type squashfs (ro,nodev,relatime,x-gdu.hide)
/dev/sda2 on /boot type ext4 (rw,relatime)
tmpfs on /run/snapd/ns type tmpfs (rw,nosuid,nodev,noexec,relatime,size=100460k,mode=755)
vagrant on /vagrant type vboxsf (rw,nodev,relatime,iocharset=utf8,uid=1000,gid=1000,_netdev)
/var/lib/snapd/snaps/snapd_15177.snap on /snap/snapd/15177 type squashfs (ro,nodev,relatime,x-gdu.hide)
/var/lib/snapd/snaps/core18_2344.snap on /snap/core18/2344 type squashfs (ro,nodev,relatime,x-gdu.hide)
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,size=100456k,mode=700,uid=1000,gid=1000)
/var/lib/snapd/snaps/core20_1405.snap on /snap/core20/1405 type squashfs (ro,nodev,relatime,x-gdu.hide)
/var/lib/snapd/snaps/lxd_22753.snap on /snap/lxd/22753 type squashfs (ro,nodev,relatime,x-gdu.hide)
nsfs on /run/snapd/ns/lxd.mnt type nsfs (rw)
/dev/mapper/vg1-lvol0 on /tmp/new_test type ext4 (rw,relatime,stripe=256)
root@vagrant:/home/vagrant#
```
---

13. Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.
---
```bash
root@vagrant:/home/vagrant# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new_test/test.gz
--2022-04-20 17:59:53--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 22278999 (21M) [application/octet-stream]
Saving to: ‘/tmp/new_test/test.gz’

/tmp/new_test/test.gz             100%[==============>]  21.25M  25.2MB/s    in 0.8s

2022-04-20 17:59:54 (25.2 MB/s) - ‘/tmp/new_test/test.gz’ saved [22278999/22278999]

root@vagrant:/home/vagrant# ls -l /tmp/new_test/
total 21776
drwx------ 2 root root    16384 Apr 20 17:49 lost+found
-rw-r--r-- 1 root root 22278999 Apr 20 16:57 test.gz
root@vagrant:/home/vagrant#
```
---

14. Прикрепите вывод lsblk.
---
```bash
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 55.4M  1 loop  /snap/core18/2128
loop1                       7:1    0 70.3M  1 loop  /snap/lxd/21029
loop3                       7:3    0 43.6M  1 loop  /snap/snapd/15177
loop4                       7:4    0 55.5M  1 loop  /snap/core18/2344
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1405
loop6                       7:6    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdb2                      8:18   0  510M  0 part
  └─md0                     9:0    0 1016M  0 raid0
    └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new_test
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
└─sdc2                      8:34   0  510M  0 part
  └─md0                     9:0    0 1016M  0 raid0
    └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new_test
root@vagrant:/home/vagrant#
```
---

15. Протестируйте целостность файла:
---
```bash
root@vagrant:/home/vagrant# gzip -t /tmp/new_test/test.gz
root@vagrant:/home/vagrant# echo $?
0
root@vagrant:/home/vagrant#
```
---

16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.
---
```bash
root@vagrant:/home/vagrant# pvmove /dev/md0
  /dev/md0: Moved: 88.00%
  /dev/md0: Moved: 100.00%
root@vagrant:/home/vagrant# lsblk
NAME                      MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT
loop0                       7:0    0 55.4M  1 loop  /snap/core18/2128
loop1                       7:1    0 70.3M  1 loop  /snap/lxd/21029
loop3                       7:3    0 43.6M  1 loop  /snap/snapd/15177
loop4                       7:4    0 55.5M  1 loop  /snap/core18/2344
loop5                       7:5    0 61.9M  1 loop  /snap/core20/1405
loop6                       7:6    0 67.8M  1 loop  /snap/lxd/22753
sda                         8:0    0   64G  0 disk
├─sda1                      8:1    0    1M  0 part
├─sda2                      8:2    0    1G  0 part  /boot
└─sda3                      8:3    0   63G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0 31.5G  0 lvm   /
sdb                         8:16   0  2.5G  0 disk
├─sdb1                      8:17   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
│   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new_test
└─sdb2                      8:18   0  510M  0 part
  └─md0                     9:0    0 1016M  0 raid0
sdc                         8:32   0  2.5G  0 disk
├─sdc1                      8:33   0    2G  0 part
│ └─md1                     9:1    0    2G  0 raid1
│   └─vg1-lvol0           253:1    0  100M  0 lvm   /tmp/new_test
└─sdc2                      8:34   0  510M  0 part
  └─md0                     9:0    0 1016M  0 raid0
root@vagrant:/home/vagrant#
```
---

17. Сделайте --fail на устройство в вашем RAID1 md.

---
```bash
root@vagrant:/home/vagrant# mdadm /dev/md1 --fail /dev/sdb1
mdadm: set /dev/sdb1 faulty in /dev/md1
root@vagrant:/home/vagrant# mdadm -D /dev/md1
/dev/md1:
           Version : 1.2
     Creation Time : Wed Apr 20 17:17:56 2022
        Raid Level : raid1
        Array Size : 2094080 (2045.00 MiB 2144.34 MB)
     Used Dev Size : 2094080 (2045.00 MiB 2144.34 MB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Wed Apr 20 18:11:05 2022
             State : clean, degraded
    Active Devices : 1
   Working Devices : 1
    Failed Devices : 1
     Spare Devices : 0

Consistency Policy : resync

              Name : vagrant:1  (local to host vagrant)
              UUID : fae7996f:b250297f:eefa58be:47bb3c06
            Events : 19

    Number   Major   Minor   RaidDevice State
       -       0        0        0      removed
       1       8       33        1      active sync   /dev/sdc1

       0       8       17        -      faulty   /dev/sdb1
root@vagrant:/home/vagrant#
```
---


18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.
---
```bash
root@vagrant:/home/vagrant# dmesg |grep md1
[ 1904.257511] md/raid1:md1: not clean -- starting background reconstruction
[ 1904.257512] md/raid1:md1: active with 2 out of 2 mirrors
[ 1904.257521] md1: detected capacity change from 0 to 2144337920
[ 1904.258208] md: resync of RAID array md1
[ 1914.436885] md: md1: resync done.
[ 5092.160748] md/raid1:md1: Disk failure on sdb1, disabling device.
               md/raid1:md1: Operation continuing on 1 devices.
root@vagrant:/home/vagrant#
```
---

19. Протестируйте целостность файла, несмотря на "сбойный" диск.
---
```bash
root@vagrant:/home/vagrant# gzip -t /tmp/new_test/test.gz
root@vagrant:/home/vagrant# echo $?
0
root@vagrant:/home/vagrant#
```
---

20. Погасите тестовый хост, vagrant destroy.
---
```bash
root@vagrant:/home/vagrant# exit
exit
vagrant@vagrant:~$ exit
logout
Connection to 127.0.0.1 closed.
PS C:\Users\Anton.Sergeev\vagrant_vm> vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
PS C:\Users\Anton.Sergeev\vagrant_vm>
```
---