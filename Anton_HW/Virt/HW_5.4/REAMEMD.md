Задача 1 
---
````bash
vagrant@NETOLOGY:~$ yc init
Welcome! This command will take you through the configuration process.
Please go to https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6                                                                                                                                                             990aa636648e9b2ef855fa7bec2fb in order to obtain OAuth token.

Please enter OAuth token: AQAAAA*******************7zmrskM
You have one cloud available: 'antonsergeev-devopsnetology' (id = b1g53m3oi7gunbee2up1). 
It is going to be used by default.
Please choose folder to use:
 [1] default (id = b1gtfhn8k74du29stfr9)
 [2] Create a new folder
Please enter your numeric choice: 1
Your current folder has been set to 'default' (id = b1gtfhn8k74du29stfr9).
Do you want to configure a default Compute zone? [Y/n] y
Which zone do you want to use as a profile default?
 [1] ru-central1-a
 [2] ru-central1-b
 [3] ru-central1-c
 [4] Don't set default zone
Please enter your numeric choice: 1
Your profile default Compute zone has been set to 'ru-central1-a'.
vagrant@NETOLOGY:~$ yc config list
token: AQAAAAB.....................
cloud-id: b1g53m3oi7gunbee2up1
folder-id: b1gnpng2kd9kthf4bqtl
compute-default-zone: ru-central1-a
---
vagrant@NETOLOGY:~$ yc --version
Yandex Cloud CLI 0.93.0 linux/amd64
vagrant@NETOLOGY:~$
---
vagrant@NETOLOGY:/opt/packer$ yc compute image list
+----+------+--------+-------------+--------+
| ID | NAME | FAMILY | PRODUCT IDS | STATUS |
+----+------+--------+-------------+--------+
+----+------+--------+-------------+--------+

---
vagrant@NETOLOGY:/opt/packer$ yc vpc network create --name net --labels my-label=netology --description 
"my first network via yc"
id: enp4h5m9rs2s15d7s6mm
folder_id: b1gnpng2kd9kthf4bqtl
created_at: "2022-08-24T09:51:10Z"
name: net
description: my first network via yc
labels:
  my-label: netology

vagrant@NETOLOGY:/opt/packer$ yc vpc subnet create --name my-subnet-a --zone ru-central1-a --range 10.1.2.0/24 
--network-name net --description "my first subnet via yc"
id: e9bcjl74rrrrg48srms6
folder_id: b1gnpng2kd9kthf4bqtl
created_at: "2022-08-24T09:51:51Z"
name: my-subnet-a
description: my first subnet via yc
network_id: enp4h5m9rs2s15d7s6mm
zone_id: ru-central1-a
v4_cidr_blocks:
  - 10.1.2.0/24


----
vagrant@NETOLOGY:/opt/packer$ yc vpc network list
+----------------------+------+
|          ID          | NAME |
+----------------------+------+
| enphrknscbin3064kleo | net  |
+----------------------+------+

vagrant@NETOLOGY:/opt/packer$ yc config list
token: AQAAAABiY8BkAATuwWP4pG6KckHmmZJ37zmrskM
cloud-id: b1g53m3oi7gunbee2up1
folder-id: b1gtfhn8k74du29stfr9
compute-default-zone: ru-central1-a
vagrant@NETOLOGY:/opt/packer$ yc vpc subnet list
+----------------------+-------------+----------------------+----------------+---------------+---------------+
|          ID          |    NAME     |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |     RANGE     |
+----------------------+-------------+----------------------+----------------+---------------+---------------+
| e9b0g3fen9s7vj2ltbuj | my-subnet-a | enphrknscbin3064kleo |                | ru-central1-a | [10.1.2.0/24] |
+----------------------+-------------+----------------------+----------------+---------------+---------------+

---
vagrant@NETOLOGY:/opt/packer$ ./packer --version
1.8.3


root@NETOLOGY://opt/terraform/1.2.7# ./terraform --version
Terraform v1.2.7

---


vagrant@NETOLOGY:/opt/packer$ ./packer validate centos-7-base.json
The configuration is valid.

vagrant@NETOLOGY:/opt/packer$ ./packer build centos-7-base.json
yandex: output will be in this color.

==> yandex: Creating temporary RSA SSH key for instance...
==> yandex: Using as source image: fd88d14a6790do254kj7 (name: "centos-7-v20220620", family: "centos-7")
==> yandex: Use provided subnet id e9b7ua4ac1dph0jp0ns1
==> yandex: Creating disk...
==> yandex: Creating instance...
==> yandex: Waiting for instance with id fhmjbtsua05l63ll9m9c to become active...
    yandex: Detected instance IP: 84.252.128.212
==> yandex: Using SSH communicator to connect: 84.252.128.212
==> yandex: Waiting for SSH to become available...
==> yandex: Connected to SSH!
==> yandex: Provisioning with shell script: /tmp/packer-shell3476647988
    yandex: Loaded plugins: fastestmirror
    yandex: Determining fastest mirrors
    yandex:  * base: mirrors.datahouse.ru
    yandex:  * extras: mirror.corbina.net
    yandex:  * updates: mirror.corbina.net
    yandex: Resolving Dependencies
    yandex: --> Running transaction check
    yandex: ---> Package kernel.x86_64 0:3.10.0-1160.76.1.el7 will be installed
    yandex: ---> Package kernel-tools.x86_64 0:3.10.0-1160.66.1.el7 will be updated
    yandex: ---> Package kernel-tools.x86_64 0:3.10.0-1160.76.1.el7 will be an update
    yandex: ---> Package kernel-tools-libs.x86_64 0:3.10.0-1160.66.1.el7 will be updated
    yandex: ---> Package kernel-tools-libs.x86_64 0:3.10.0-1160.76.1.el7 will be an update
    yandex: ---> Package krb5-libs.x86_64 0:1.15.1-51.el7_9 will be updated
    yandex: ---> Package krb5-libs.x86_64 0:1.15.1-54.el7_9 will be an update
    yandex: ---> Package microcode_ctl.x86_64 2:2.1-73.13.el7_9 will be updated
    yandex: ---> Package microcode_ctl.x86_64 2:2.1-73.14.el7_9 will be an update
    yandex: ---> Package python.x86_64 0:2.7.5-90.el7 will be updated
    yandex: ---> Package python.x86_64 0:2.7.5-92.el7_9 will be an update
    yandex: ---> Package python-libs.x86_64 0:2.7.5-90.el7 will be updated
    yandex: ---> Package python-libs.x86_64 0:2.7.5-92.el7_9 will be an update
    yandex: ---> Package python-perf.x86_64 0:3.10.0-1160.66.1.el7 will be updated
    yandex: ---> Package python-perf.x86_64 0:3.10.0-1160.76.1.el7 will be an update
    yandex: --> Finished Dependency Resolution
    yandex:
    yandex: Dependencies Resolved
    yandex:
    yandex: ================================================================================
    yandex:  Package               Arch       Version                     Repository   Size
    yandex: ================================================================================
    yandex: Installing:
    yandex:  kernel                x86_64     3.10.0-1160.76.1.el7        updates      50 M
    yandex: Updating:
    yandex:  kernel-tools          x86_64     3.10.0-1160.76.1.el7        updates     8.2 M
    yandex:  kernel-tools-libs     x86_64     3.10.0-1160.76.1.el7        updates     8.1 M
    yandex:  krb5-libs             x86_64     1.15.1-54.el7_9             updates     810 k
    yandex:  microcode_ctl         x86_64     2:2.1-73.14.el7_9           updates     4.5 M
    yandex:  python                x86_64     2.7.5-92.el7_9              updates      96 k
    yandex:  python-libs           x86_64     2.7.5-92.el7_9              updates     5.6 M
    yandex:  python-perf           x86_64     3.10.0-1160.76.1.el7        updates     8.2 M
    yandex:
    yandex: Transaction Summary
    yandex: ================================================================================
    yandex: Install  1 Package
    yandex: Upgrade  7 Packages
    yandex:
    yandex: Total download size: 86 M
    yandex: Downloading packages:
    yandex: Delta RPMs disabled because /usr/bin/applydeltarpm not installed.
    yandex: --------------------------------------------------------------------------------
    yandex: Total                                               57 MB/s |  86 MB  00:01
    yandex: Running transaction check
    yandex: Running transaction test
    yandex: Transaction test succeeded
    yandex: Running transaction
    yandex:   Updating   : python-libs-2.7.5-92.el7_9.x86_64                           1/15
    yandex:   Updating   : python-2.7.5-92.el7_9.x86_64                                2/15
    yandex:   Updating   : kernel-tools-libs-3.10.0-1160.76.1.el7.x86_64               3/15
    yandex:   Updating   : kernel-tools-3.10.0-1160.76.1.el7.x86_64                    4/15
    yandex:   Updating   : python-perf-3.10.0-1160.76.1.el7.x86_64                     5/15
    yandex:   Installing : kernel-3.10.0-1160.76.1.el7.x86_64                          6/15
    yandex:   Updating   : krb5-libs-1.15.1-54.el7_9.x86_64                            7/15
    yandex:   Updating   : 2:microcode_ctl-2.1-73.14.el7_9.x86_64                      8/15
    yandex:   Cleanup    : python-perf-3.10.0-1160.66.1.el7.x86_64                     9/15
    yandex:   Cleanup    : python-2.7.5-90.el7.x86_64                                 10/15
    yandex:   Cleanup    : kernel-tools-3.10.0-1160.66.1.el7.x86_64                   11/15
    yandex:   Cleanup    : 2:microcode_ctl-2.1-73.13.el7_9.x86_64                     12/15
    yandex:   Cleanup    : kernel-tools-libs-3.10.0-1160.66.1.el7.x86_64              13/15
    yandex:   Cleanup    : python-libs-2.7.5-90.el7.x86_64                            14/15
    yandex:   Cleanup    : krb5-libs-1.15.1-51.el7_9.x86_64                           15/15
    yandex:   Verifying  : python-2.7.5-92.el7_9.x86_64                                1/15
    yandex:   Verifying  : kernel-tools-3.10.0-1160.76.1.el7.x86_64                    2/15
    yandex:   Verifying  : python-libs-2.7.5-92.el7_9.x86_64                           3/15
    yandex:   Verifying  : 2:microcode_ctl-2.1-73.14.el7_9.x86_64                      4/15
    yandex:   Verifying  : kernel-tools-libs-3.10.0-1160.76.1.el7.x86_64               5/15
    yandex:   Verifying  : python-perf-3.10.0-1160.76.1.el7.x86_64                     6/15
    yandex:   Verifying  : krb5-libs-1.15.1-54.el7_9.x86_64                            7/15
    yandex:   Verifying  : kernel-3.10.0-1160.76.1.el7.x86_64                          8/15
    yandex:   Verifying  : kernel-tools-libs-3.10.0-1160.66.1.el7.x86_64               9/15
    yandex:   Verifying  : python-libs-2.7.5-90.el7.x86_64                            10/15
    yandex:   Verifying  : kernel-tools-3.10.0-1160.66.1.el7.x86_64                   11/15
    yandex:   Verifying  : python-2.7.5-90.el7.x86_64                                 12/15
    yandex:   Verifying  : krb5-libs-1.15.1-51.el7_9.x86_64                           13/15
    yandex:   Verifying  : 2:microcode_ctl-2.1-73.13.el7_9.x86_64                     14/15
    yandex:   Verifying  : python-perf-3.10.0-1160.66.1.el7.x86_64                    15/15
    yandex:
    yandex: Installed:
    yandex:   kernel.x86_64 0:3.10.0-1160.76.1.el7
    yandex:
    yandex: Updated:
    yandex:   kernel-tools.x86_64 0:3.10.0-1160.76.1.el7
    yandex:   kernel-tools-libs.x86_64 0:3.10.0-1160.76.1.el7
    yandex:   krb5-libs.x86_64 0:1.15.1-54.el7_9
    yandex:   microcode_ctl.x86_64 2:2.1-73.14.el7_9
    yandex:   python.x86_64 0:2.7.5-92.el7_9
    yandex:   python-libs.x86_64 0:2.7.5-92.el7_9
    yandex:   python-perf.x86_64 0:3.10.0-1160.76.1.el7
    yandex:
    yandex: Complete!
    yandex: Loaded plugins: fastestmirror
    yandex: Loading mirror speeds from cached hostfile
    yandex:  * base: mirrors.datahouse.ru
    yandex:  * extras: mirror.corbina.net
    yandex:  * updates: mirror.corbina.net
    yandex: Package iptables-1.4.21-35.el7.x86_64 already installed and latest version
    yandex: Package curl-7.29.0-59.el7_9.1.x86_64 already installed and latest version
    yandex: Package net-tools-2.0-0.25.20131004git.el7.x86_64 already installed and latest version
    yandex: Package rsync-3.1.2-10.el7.x86_64 already installed and latest version
    yandex: Package openssh-server-7.4p1-22.el7_9.x86_64 already installed and latest version
    yandex: Resolving Dependencies
    yandex: --> Running transaction check
    yandex: ---> Package bind-utils.x86_64 32:9.11.4-26.P2.el7_9.9 will be installed
    yandex: --> Processing Dependency: bind-libs-lite(x86-64) = 32:9.11.4-26.P2.el7_9.9 for package:
     32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: bind-libs(x86-64) = 32:9.11.4-26.P2.el7_9.9 for package: 
    32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: liblwres.so.160()(64bit) for package: 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: libisccfg.so.160()(64bit) for package: 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: libisc.so.169()(64bit) for package: 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: libirs.so.160()(64bit) for package: 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: libdns.so.1102()(64bit) for package: 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: libbind9.so.160()(64bit) for package: 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: --> Processing Dependency: libGeoIP.so.1()(64bit) for package: 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64
    yandex: ---> Package bridge-utils.x86_64 0:1.5-9.el7 will be installed
    yandex: ---> Package tcpdump.x86_64 14:4.9.2-4.el7_7.1 will be installed
    yandex: --> Processing Dependency: libpcap >= 14:1.5.3-10 for package: 14:tcpdump-4.9.2-4.el7_7.1.x86_64
    yandex: --> Processing Dependency: libpcap.so.1()(64bit) for package: 14:tcpdump-4.9.2-4.el7_7.1.x86_64
    yandex: ---> Package telnet.x86_64 1:0.17-66.el7 will be installed
    yandex: --> Running transaction check
    yandex: ---> Package GeoIP.x86_64 0:1.5.0-14.el7 will be installed
    yandex: --> Processing Dependency: geoipupdate for package: GeoIP-1.5.0-14.el7.x86_64
    yandex: ---> Package bind-libs.x86_64 32:9.11.4-26.P2.el7_9.9 will be installed
    yandex: --> Processing Dependency: bind-license = 32:9.11.4-26.P2.el7_9.9 for package:
     32:bind-libs-9.11.4-26.P2.el7_9.9.x86_64
    yandex: ---> Package bind-libs-lite.x86_64 32:9.11.4-26.P2.el7_9.9 will be installed
    yandex: ---> Package libpcap.x86_64 14:1.5.3-13.el7_9 will be installed
    yandex: --> Running transaction check
    yandex: ---> Package bind-license.noarch 32:9.11.4-26.P2.el7_9.9 will be installed
    yandex: ---> Package geoipupdate.x86_64 0:2.5.0-1.el7 will be installed
    yandex: --> Finished Dependency Resolution
    yandex:
    yandex: Dependencies Resolved
    yandex:
    yandex: ================================================================================
    yandex:  Package            Arch       Version                        Repository   Size
    yandex: ================================================================================
    yandex: Installing:
    yandex:  bind-utils         x86_64     32:9.11.4-26.P2.el7_9.9        updates     261 k
    yandex:  bridge-utils       x86_64     1.5-9.el7                      base         32 k
    yandex:  tcpdump            x86_64     14:4.9.2-4.el7_7.1             base        422 k
    yandex:  telnet             x86_64     1:0.17-66.el7                  updates      64 k
    yandex: Installing for dependencies:
    yandex:  GeoIP              x86_64     1.5.0-14.el7                   base        1.5 M
    yandex:  bind-libs          x86_64     32:9.11.4-26.P2.el7_9.9        updates     157 k
    yandex:  bind-libs-lite     x86_64     32:9.11.4-26.P2.el7_9.9        updates     1.1 M
    yandex:  bind-license       noarch     32:9.11.4-26.P2.el7_9.9        updates      91 k
    yandex:  geoipupdate        x86_64     2.5.0-1.el7                    base         35 k
    yandex:  libpcap            x86_64     14:1.5.3-13.el7_9              updates     139 k
    yandex:
    yandex: Transaction Summary
    yandex: ================================================================================
    yandex: Install  4 Packages (+6 Dependent packages)
    yandex:
    yandex: Total download size: 3.8 M
    yandex: Installed size: 9.0 M
    yandex: Downloading packages:
    yandex: --------------------------------------------------------------------------------
    yandex: Total                                              3.2 MB/s | 3.8 MB  00:01
    yandex: Running transaction check
    yandex: Running transaction test
    yandex: Transaction test succeeded
    yandex: Running transaction
    yandex:   Installing : 32:bind-license-9.11.4-26.P2.el7_9.9.noarch                 1/10
    yandex:   Installing : geoipupdate-2.5.0-1.el7.x86_64                              2/10
    yandex:   Installing : GeoIP-1.5.0-14.el7.x86_64                                   3/10
    yandex:   Installing : 32:bind-libs-lite-9.11.4-26.P2.el7_9.9.x86_64               4/10
    yandex:   Installing : 32:bind-libs-9.11.4-26.P2.el7_9.9.x86_64                    5/10
    yandex:   Installing : 14:libpcap-1.5.3-13.el7_9.x86_64                            6/10
    yandex: pam_tally2: Error opening /var/log/tallylog for update: Permission denied
    yandex: pam_tally2: Authentication error
    yandex: useradd: failed to reset the tallylog entry of user "tcpdump"
    yandex:   Installing : 14:tcpdump-4.9.2-4.el7_7.1.x86_64                           7/10
    yandex:   Installing : 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64                   8/10
    yandex:   Installing : bridge-utils-1.5-9.el7.x86_64                               9/10
    yandex:   Installing : 1:telnet-0.17-66.el7.x86_64                                10/10
    yandex:   Verifying  : GeoIP-1.5.0-14.el7.x86_64                                   1/10
    yandex:   Verifying  : 14:libpcap-1.5.3-13.el7_9.x86_64                            2/10
    yandex:   Verifying  : 1:telnet-0.17-66.el7.x86_64                                 3/10
    yandex:   Verifying  : 32:bind-libs-9.11.4-26.P2.el7_9.9.x86_64                    4/10
    yandex:   Verifying  : geoipupdate-2.5.0-1.el7.x86_64                              5/10
    yandex:   Verifying  : 14:tcpdump-4.9.2-4.el7_7.1.x86_64                           6/10
    yandex:   Verifying  : 32:bind-license-9.11.4-26.P2.el7_9.9.noarch                 7/10
    yandex:   Verifying  : bridge-utils-1.5-9.el7.x86_64                               8/10
    yandex:   Verifying  : 32:bind-libs-lite-9.11.4-26.P2.el7_9.9.x86_64               9/10
    yandex:   Verifying  : 32:bind-utils-9.11.4-26.P2.el7_9.9.x86_64                  10/10
    yandex:
    yandex: Installed:
    yandex:   bind-utils.x86_64 32:9.11.4-26.P2.el7_9.9   bridge-utils.x86_64 0:1.5-9.el7
    yandex:   tcpdump.x86_64 14:4.9.2-4.el7_7.1           telnet.x86_64 1:0.17-66.el7
    yandex:
    yandex: Dependency Installed:
    yandex:   GeoIP.x86_64 0:1.5.0-14.el7
    yandex:   bind-libs.x86_64 32:9.11.4-26.P2.el7_9.9
    yandex:   bind-libs-lite.x86_64 32:9.11.4-26.P2.el7_9.9
    yandex:   bind-license.noarch 32:9.11.4-26.P2.el7_9.9
    yandex:   geoipupdate.x86_64 0:2.5.0-1.el7
    yandex:   libpcap.x86_64 14:1.5.3-13.el7_9
    yandex:
    yandex: Complete!
==> yandex: Stopping instance...
==> yandex: Deleting instance...
    yandex: Instance has been deleted!
==> yandex: Creating image: centos-7-base
==> yandex: Waiting for image to complete...
==> yandex: Success image create...
==> yandex: Destroying boot disk...
    yandex: Disk has been deleted!
Build 'yandex' finished after 5 minutes 6 seconds.

==> Wait completed after 5 minutes 6 seconds

==> Builds finished. The artifacts of successful builds are:
--> yandex: A disk image was created: centos-7-base (id: fd8edicldkjcrdg668df) with family name centos

Итог  
  
vagrant@NETOLOGY:/opt/packer$ yc compute image list
+----------------------+---------------+--------+----------------------+--------+
|          ID          |     NAME      | FAMILY |     PRODUCT IDS      | STATUS |
+----------------------+---------------+--------+----------------------+--------+
| fd8edicldkjcrdg668df | centos-7-base | centos | f2euv1kekdgvc0jrpaet | READY  |
+----------------------+---------------+--------+----------------------+--------+
````
---
Задача 2 

---
````bash
root@NETOLOGY:/opt/terraform/1.2.5# yc iam key create --service-account-name sergeev --output key.json
id: aje4e2t9us3e6lrpfqqp
service_account_id: aje9fggpc5ar1a8fi0na
created_at: "2022-08-24T18:10:22.420609323Z"
key_algorithm: RSA_2048



````
![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.4/3.JPG)
---

Задача 3 

---


![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.4/1.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.4/2.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.4/4.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.4/graf%201.JPG)

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/Virt/HW_5.4/graf%202.JPG)


---