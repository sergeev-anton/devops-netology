1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

поместите его в автозагрузку,
предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

---

Создан файл node_exporter.service

root@vagrant:~# cat /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple

EnvironmentFile=/opt/node_exporter-1.3.1.linux-amd64/node_exporter_env
ExecStart=/opt/node_exporter-1.3.1.linux-amd64/node_exporter $OPTIONS

[Install]
WantedBy=default.target


root@vagrant:/opt/node_exporter-1.3.1.linux-amd64# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Wed 2022-04-06 17:37:06 UTC; 3s ago
   Main PID: 1648 (node_exporter)
      Tasks: 5 (limit: 4617)
     Memory: 2.4M
     CGroup: /system.slice/node_exporter.service
             └─1648 /opt/node_exporter-1.3.1.linux-amd64/node_exporter

Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=thermal_zone
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=time
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=timex
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=udp_queues
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=uname
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=vmstat
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=xfs
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:115 level=info collector=zfs
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=node_exporter.go:199 level=info msg="Listening on" address=:91>
Apr 06 17:37:06 vagrant node_exporter[1648]: ts=2022-04-06T17:37:06.026Z caller=tls_config.go:195 level=info msg="TLS is disabled." http2=false
root@vagrant:/opt/node_exporter-1.3.1.linux-amd64# Connection to 127.0.0.1 closed by remote host.
Connection to 127.0.0.1 closed.


 файле node_exporter_env задана одна переменная A=b. PID и системные переменные процесса node_exporter
заданные через файл node_exporter_env


vagrant@vagrant:~$ ps -e | grep node_exporter
   1755 ?        00:00:00 node_exporter


vagrant@vagrant:~$ sudo cat /proc/1755/environ
LANG=en_US.UTF-8PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/binHOME=/home/node_exporterLOGNAME=node_exporterUSER=node_exporterINVOCATION_ID=02c2cde1c9c64a22a8dbacc4dbeff36bJOURNAL_STREAM=9:34838Description=Node ExporterAfter=network.targetUser=node_exporterGroup=node_exporterType=simpleEnvironmentFile=/opt/node_exporter-1.3.1.linux-amd64/node_exporter_envExecStart=/opt/node_exporter-1.3.1.linux-amd64/node_exporter $OPTIONSWantedBy=default.targetv

---

- Поместите его в автозагрузку

---

root@vagrant:~# systemctl enable node_exporter
Created symlink /etc/systemd/system/default.target.wants/node_exporter.service → /etc/systemd/system/node_exporter.service.

---

- Предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron)

---

root@vagrant:/opt# systemctl cat cron


# /lib/systemd/system/cron.service
[Unit]
Description=Regular background program processing daemon
Documentation=man:cron(8)
After=remote-fs.target nss-user-lookup.target

[Service]
EnvironmentFile=-/etc/default/cron
ExecStart=/usr/sbin/cron -f $EXTRA_OPTS
IgnoreSIGPIPE=false
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target

---


-  Удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

STOP node_exporter

---

root@vagrant:~# systemctl stop node_exporter
root@vagrant:~# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: inactive (dead) since Thu 2022-04-07 17:01:00 UTC; 8s ago
    Process: 714 ExecStart=/opt/node_exporter-1.3.1.linux-amd64/node_exporter $OPTIONS (code=killed, signal=TERM)
   Main PID: 714 (code=killed, signal=TERM)

Apr 07 07:34:40 vagrant node_exporter[714]: ts=2022-04-07T07:34:39.341Z caller=node_exporter.go:115 level=info collector=udp_queues
Apr 07 07:34:40 vagrant node_exporter[714]: ts=2022-04-07T07:34:39.341Z caller=node_exporter.go:115 level=info collector=uname
Apr 07 07:34:40 vagrant node_exporter[714]: ts=2022-04-07T07:34:39.341Z caller=node_exporter.go:115 level=info collector=vmstat
Apr 07 07:34:40 vagrant node_exporter[714]: ts=2022-04-07T07:34:39.341Z caller=node_exporter.go:115 level=info collector=xfs
Apr 07 07:34:40 vagrant node_exporter[714]: ts=2022-04-07T07:34:39.341Z caller=node_exporter.go:115 level=info collector=zfs
Apr 07 07:34:40 vagrant node_exporter[714]: ts=2022-04-07T07:34:39.341Z caller=node_exporter.go:199 level=info msg="Listening on" add>
Apr 07 07:34:40 vagrant node_exporter[714]: ts=2022-04-07T07:34:39.349Z caller=tls_config.go:195 level=info msg="TLS is disabled." ht>
Apr 07 17:01:00 vagrant systemd[1]: Stopping Node Exporter...
Apr 07 17:01:00 vagrant systemd[1]: node_exporter.service: Succeeded.
Apr 07 17:01:00 vagrant systemd[1]: Stopped Node Exporter.


---

START node_exporter

---

root@vagrant:~# systemctl start node_exporter
root@vagrant:~# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-04-07 17:02:37 UTC; 3s ago
   Main PID: 2335 (node_exporter)
      Tasks: 6 (limit: 7029)
     Memory: 2.5M
     CGroup: /system.slice/node_exporter.service
             └─2335 /opt/node_exporter-1.3.1.linux-amd64/node_exporter

Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=thermal_zone
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=time
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=timex
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=udp_queues
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=uname
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=vmstat
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=xfs
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.471Z caller=node_exporter.go:115 level=info collector=zfs
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.472Z caller=node_exporter.go:199 level=info msg="Listening on" ad>
Apr 07 17:02:37 vagrant node_exporter[2335]: ts=2022-04-07T17:02:37.474Z caller=tls_config.go:195 level=info msg="TLS is disabled." h>


---

Перезагрузка 


PID до перезагрузки

---
root@vagrant:~# ps -e | grep node_exporter
   2335 ?        00:00:00 node_exporter
---

PID после перезагрузки


root@vagrant:~# init 6
Connection to 127.0.0.1 closed by remote host.
Connection to 127.0.0.1 closed.
PS C:\Users\Anton.Shakhov\vagrant_vm> vagrant ssh
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu 07 Apr 2022 05:21:42 PM UTC

  System load:  1.48               Processes:             144
  Usage of /:   13.3% of 30.88GB   Users logged in:       0
  Memory usage: 3%                 IPv4 address for eth0: 10.0.2.15
  Swap usage:   0%


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Thu Apr  7 15:00:12 2022
vagrant@vagrant:~$ sudo su
root@vagrant:/home/vagrant# ps -e | grep node_exporter
    716 ?        00:00:00 node_exporter
root@vagrant:/home/vagrant# systemctl status node_exporter
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-04-07 16:34:11 UTC; 48min ago
   Main PID: 716 (node_exporter)
      Tasks: 4 (limit: 7029)
     Memory: 14.1M
     CGroup: /system.slice/node_exporter.service
             └─716 /opt/node_exporter-1.3.1.linux-amd64/node_exporter

Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=thermal_zone
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=time
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=timex
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=udp_queues
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=uname
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=vmstat
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=xfs
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.630Z caller=node_exporter.go:115 level=info collector=zfs
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.631Z caller=node_exporter.go:199 level=info msg="Listening on" add>
Apr 07 16:34:12 vagrant node_exporter[716]: ts=2022-04-07T16:34:12.631Z caller=tls_config.go:195 level=info msg="TLS is disabled." ht>
root@vagrant:/home/vagrant#

2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

CPU

---
root@vagrant:/home/vagrant# curl -s http://localhost:9100/metrics | grep node_cpu
# HELP node_cpu_guest_seconds_total Seconds the CPUs spent in guests (VMs) for each mode.
# TYPE node_cpu_guest_seconds_total counter
node_cpu_guest_seconds_total{cpu="0",mode="nice"} 0
node_cpu_guest_seconds_total{cpu="0",mode="user"} 0
node_cpu_guest_seconds_total{cpu="1",mode="nice"} 0
node_cpu_guest_seconds_total{cpu="1",mode="user"} 0
node_cpu_guest_seconds_total{cpu="2",mode="nice"} 0
node_cpu_guest_seconds_total{cpu="2",mode="user"} 0
# HELP node_cpu_seconds_total Seconds the CPUs spent in each mode.
# TYPE node_cpu_seconds_total counter
node_cpu_seconds_total{cpu="0",mode="idle"} 1276.99
node_cpu_seconds_total{cpu="0",mode="iowait"} 1.06
node_cpu_seconds_total{cpu="0",mode="irq"} 0
node_cpu_seconds_total{cpu="0",mode="nice"} 0
node_cpu_seconds_total{cpu="0",mode="softirq"} 0
node_cpu_seconds_total{cpu="0",mode="steal"} 0
node_cpu_seconds_total{cpu="0",mode="system"} 3.19
node_cpu_seconds_total{cpu="0",mode="user"} 1.05
node_cpu_seconds_total{cpu="1",mode="idle"} 1274.93
node_cpu_seconds_total{cpu="1",mode="iowait"} 2.28
node_cpu_seconds_total{cpu="1",mode="irq"} 0
node_cpu_seconds_total{cpu="1",mode="nice"} 0
node_cpu_seconds_total{cpu="1",mode="softirq"} 0.06
node_cpu_seconds_total{cpu="1",mode="steal"} 0
node_cpu_seconds_total{cpu="1",mode="system"} 2.32
node_cpu_seconds_total{cpu="1",mode="user"} 1.04
node_cpu_seconds_total{cpu="2",mode="idle"} 1274.41
node_cpu_seconds_total{cpu="2",mode="iowait"} 0.69
node_cpu_seconds_total{cpu="2",mode="irq"} 0
node_cpu_seconds_total{cpu="2",mode="nice"} 0
node_cpu_seconds_total{cpu="2",mode="softirq"} 0.04
node_cpu_seconds_total{cpu="2",mode="steal"} 0
node_cpu_seconds_total{cpu="2",mode="system"} 4.03
node_cpu_seconds_total{cpu="2",mode="user"} 1.09

---

Память 

---

root@vagrant:/home/vagrant# curl -s http://localhost:9100/metrics | grep "node_memory" | grep -v "HELP" | grep -v "TYPE"
node_memory_Active_anon_bytes 6.1681664e+07
node_memory_Active_bytes 1.81694464e+08
node_memory_Active_file_bytes 1.200128e+08
node_memory_AnonHugePages_bytes 0
node_memory_AnonPages_bytes 7.4743808e+07
node_memory_Bounce_bytes 0
node_memory_Buffers_bytes 4.2082304e+07
node_memory_Cached_bytes 2.89644544e+08
node_memory_CmaFree_bytes 0
node_memory_CmaTotal_bytes 0
node_memory_CommitLimit_bytes 5.174677504e+09
node_memory_Committed_AS_bytes 5.45599488e+08
node_memory_DirectMap2M_bytes 6.276775936e+09
node_memory_DirectMap4k_bytes 1.65609472e+08
node_memory_Dirty_bytes 0
node_memory_FileHugePages_bytes 0
node_memory_FilePmdMapped_bytes 0
node_memory_HardwareCorrupted_bytes 0
node_memory_HugePages_Free 0
node_memory_HugePages_Rsvd 0
node_memory_HugePages_Surp 0
node_memory_HugePages_Total 0
node_memory_Hugepagesize_bytes 2.097152e+06
node_memory_Hugetlb_bytes 0
node_memory_Inactive_anon_bytes 135168
node_memory_Inactive_bytes 2.05529088e+08
node_memory_Inactive_file_bytes 2.0539392e+08
node_memory_KReclaimable_bytes 3.7793792e+07
node_memory_KernelStack_bytes 2.711552e+06
node_memory_Mapped_bytes 8.484864e+07
node_memory_MemAvailable_bytes 5.82094848e+09
node_memory_MemFree_bytes 5.692985344e+09
node_memory_MemTotal_bytes 6.234755072e+09
node_memory_Mlocked_bytes 1.9103744e+07
node_memory_NFS_Unstable_bytes 0
node_memory_PageTables_bytes 1.880064e+06
node_memory_Percpu_bytes 2.37568e+06
node_memory_SReclaimable_bytes 3.7793792e+07
node_memory_SUnreclaim_bytes 5.2150272e+07
node_memory_ShmemHugePages_bytes 0
node_memory_ShmemPmdMapped_bytes 0
node_memory_Shmem_bytes 1.028096e+06
node_memory_Slab_bytes 8.9944064e+07
node_memory_SwapCached_bytes 0
node_memory_SwapFree_bytes 2.057302016e+09
node_memory_SwapTotal_bytes 2.057302016e+09
node_memory_Unevictable_bytes 1.9103744e+07
node_memory_VmallocChunk_bytes 0
node_memory_VmallocTotal_bytes 3.5184372087808e+13
node_memory_VmallocUsed_bytes 2.7938816e+07
node_memory_WritebackTmp_bytes 0
node_memory_Writeback_bytes 0

---

Диск

---

root@vagrant:/home/vagrant# curl -s http://localhost:9100/metrics | grep "node_disk" | grep -v "HELP" | grep -v "TYPE"
node_disk_discard_time_seconds_total{device="dm-0"} 0
node_disk_discard_time_seconds_total{device="sda"} 0
node_disk_discard_time_seconds_total{device="sdb"} 0
node_disk_discard_time_seconds_total{device="sdc"} 0
node_disk_discarded_sectors_total{device="dm-0"} 0
node_disk_discarded_sectors_total{device="sda"} 0
node_disk_discarded_sectors_total{device="sdb"} 0
node_disk_discarded_sectors_total{device="sdc"} 0
node_disk_discards_completed_total{device="dm-0"} 0
node_disk_discards_completed_total{device="sda"} 0
node_disk_discards_completed_total{device="sdb"} 0
node_disk_discards_completed_total{device="sdc"} 0
node_disk_discards_merged_total{device="dm-0"} 0
node_disk_discards_merged_total{device="sda"} 0
node_disk_discards_merged_total{device="sdb"} 0
node_disk_discards_merged_total{device="sdc"} 0
node_disk_info{device="dm-0",major="253",minor="0"} 1
node_disk_info{device="sda",major="8",minor="0"} 1
node_disk_info{device="sdb",major="8",minor="16"} 1
node_disk_info{device="sdc",major="8",minor="32"} 1
node_disk_io_now{device="dm-0"} 0
node_disk_io_now{device="sda"} 0
node_disk_io_now{device="sdb"} 0
node_disk_io_now{device="sdc"} 0
node_disk_io_time_seconds_total{device="dm-0"} 12.868
node_disk_io_time_seconds_total{device="sda"} 13.044
node_disk_io_time_seconds_total{device="sdb"} 0.184
node_disk_io_time_seconds_total{device="sdc"} 0.14
node_disk_io_time_weighted_seconds_total{device="dm-0"} 57.660000000000004
node_disk_io_time_weighted_seconds_total{device="sda"} 39.792
node_disk_io_time_weighted_seconds_total{device="sdb"} 0.044
node_disk_io_time_weighted_seconds_total{device="sdc"} 0.024
node_disk_read_bytes_total{device="dm-0"} 2.28176896e+08
node_disk_read_bytes_total{device="sda"} 2.37556736e+08
node_disk_read_bytes_total{device="sdb"} 4.419584e+06
node_disk_read_bytes_total{device="sdc"} 4.419584e+06
node_disk_read_time_seconds_total{device="dm-0"} 40.276
node_disk_read_time_seconds_total{device="sda"} 35.855000000000004
node_disk_read_time_seconds_total{device="sdb"} 0.198
node_disk_read_time_seconds_total{device="sdc"} 0.16
node_disk_reads_completed_total{device="dm-0"} 8252
node_disk_reads_completed_total{device="sda"} 6063
node_disk_reads_completed_total{device="sdb"} 196
node_disk_reads_completed_total{device="sdc"} 196
node_disk_reads_merged_total{device="dm-0"} 0
node_disk_reads_merged_total{device="sda"} 2476
node_disk_reads_merged_total{device="sdb"} 0
node_disk_reads_merged_total{device="sdc"} 0
node_disk_write_time_seconds_total{device="dm-0"} 17.384
node_disk_write_time_seconds_total{device="sda"} 11.856
node_disk_write_time_seconds_total{device="sdb"} 0
node_disk_write_time_seconds_total{device="sdc"} 0
node_disk_writes_completed_total{device="dm-0"} 1921
node_disk_writes_completed_total{device="sda"} 946
node_disk_writes_completed_total{device="sdb"} 0
node_disk_writes_completed_total{device="sdc"} 0
node_disk_writes_merged_total{device="dm-0"} 0
node_disk_writes_merged_total{device="sda"} 1015
node_disk_writes_merged_total{device="sdb"} 0
node_disk_writes_merged_total{device="sdc"} 0
node_disk_written_bytes_total{device="dm-0"} 1.9439616e+07
node_disk_written_bytes_total{device="sda"} 1.9390464e+07
node_disk_written_bytes_total{device="sdb"} 0
node_disk_written_bytes_total{device="sdc"} 0

---

Сеть 

---

root@vagrant:/home/vagrant# curl -s http://localhost:9100/metrics | grep "node_network" | grep -v "HELP" | grep -v "TYPE"
node_network_address_assign_type{device="eth0"} 0
node_network_address_assign_type{device="lo"} 0
node_network_carrier{device="eth0"} 1
node_network_carrier{device="lo"} 1
node_network_carrier_changes_total{device="eth0"} 2
node_network_carrier_changes_total{device="lo"} 0
node_network_carrier_down_changes_total{device="eth0"} 1
node_network_carrier_down_changes_total{device="lo"} 0
node_network_carrier_up_changes_total{device="eth0"} 1
node_network_carrier_up_changes_total{device="lo"} 0
node_network_device_id{device="eth0"} 0
node_network_device_id{device="lo"} 0
node_network_dormant{device="eth0"} 0
node_network_dormant{device="lo"} 0
node_network_flags{device="eth0"} 4099
node_network_flags{device="lo"} 9
node_network_iface_id{device="eth0"} 2
node_network_iface_id{device="lo"} 1
node_network_iface_link{device="eth0"} 2
node_network_iface_link{device="lo"} 1
node_network_iface_link_mode{device="eth0"} 0
node_network_iface_link_mode{device="lo"} 0
node_network_info{address="00:00:00:00:00:00",broadcast="00:00:00:00:00:00",device="lo",duplex="",ifalias="",operstate="unknown"} 1
node_network_info{address="08:00:27:b1:28:5d",broadcast="ff:ff:ff:ff:ff:ff",device="eth0",duplex="full",ifalias="",operstate="up"} 1
node_network_mtu_bytes{device="eth0"} 1500
node_network_mtu_bytes{device="lo"} 65536
node_network_net_dev_group{device="eth0"} 0
node_network_net_dev_group{device="lo"} 0
node_network_protocol_type{device="eth0"} 1
node_network_protocol_type{device="lo"} 772
node_network_receive_bytes_total{device="eth0"} 25493
node_network_receive_bytes_total{device="lo"} 196622
node_network_receive_compressed_total{device="eth0"} 0
node_network_receive_compressed_total{device="lo"} 0
node_network_receive_drop_total{device="eth0"} 0
node_network_receive_drop_total{device="lo"} 0
node_network_receive_errs_total{device="eth0"} 0
node_network_receive_errs_total{device="lo"} 0
node_network_receive_fifo_total{device="eth0"} 0
node_network_receive_fifo_total{device="lo"} 0
node_network_receive_frame_total{device="eth0"} 0
node_network_receive_frame_total{device="lo"} 0
node_network_receive_multicast_total{device="eth0"} 0
node_network_receive_multicast_total{device="lo"} 0
node_network_receive_packets_total{device="eth0"} 179
node_network_receive_packets_total{device="lo"} 119
node_network_speed_bytes{device="eth0"} 1.25e+08
node_network_transmit_bytes_total{device="eth0"} 16636
node_network_transmit_bytes_total{device="lo"} 196622
node_network_transmit_carrier_total{device="eth0"} 0
node_network_transmit_carrier_total{device="lo"} 0
node_network_transmit_colls_total{device="eth0"} 0
node_network_transmit_colls_total{device="lo"} 0
node_network_transmit_compressed_total{device="eth0"} 0
node_network_transmit_compressed_total{device="lo"} 0
node_network_transmit_drop_total{device="eth0"} 0
node_network_transmit_drop_total{device="lo"} 0
node_network_transmit_errs_total{device="eth0"} 0
node_network_transmit_errs_total{device="lo"} 0
node_network_transmit_fifo_total{device="eth0"} 0
node_network_transmit_fifo_total{device="lo"} 0
node_network_transmit_packets_total{device="eth0"} 129
node_network_transmit_packets_total{device="lo"} 119
node_network_transmit_queue_length{device="eth0"} 1000
node_network_transmit_queue_length{device="lo"} 1000
node_network_up{device="eth0"} 1
node_network_up{device="lo"} 0

---

3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:

---

root@vagrant:/home/vagrant# apt install -y netdata
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  fonts-font-awesome fonts-glyphicons-halflings freeipmi-common libc-ares2 libfreeipmi17 libipmimonitoring6 libjs-bootstrap
  libjudydebian1 libnetfilter-acct1 libnode64 netdata-core netdata-plugins-bash netdata-plugins-nodejs netdata-plugins-python
  netdata-web nodejs nodejs-doc
Suggested packages:
  freeipmi-tools apcupsd hddtemp lm-sensors nc fping python3-psycopg2 python3-pymysql npm
The following NEW packages will be installed:
  fonts-font-awesome fonts-glyphicons-halflings freeipmi-common libc-ares2 libfreeipmi17 libipmimonitoring6 libjs-bootstrap
  libjudydebian1 libnetfilter-acct1 libnode64 netdata netdata-core netdata-plugins-bash netdata-plugins-nodejs
  netdata-plugins-python netdata-web nodejs nodejs-doc
0 upgraded, 18 newly installed, 0 to remove and 0 not upgraded.
Need to get 10.5 MB of archives.

---

- в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0

---

vagrant@vagrant:~$ systemctl status netdata
● netdata.service - netdata - Real-time performance monitoring
     Loaded: loaded (/lib/systemd/system/netdata.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-04-07 19:00:07 UTC; 1min 48s ago
       Docs: man:netdata
             file:///usr/share/doc/netdata/html/index.html
             https://github.com/netdata/netdata
   Main PID: 713 (netdata)
      Tasks: 23 (limit: 7029)
     Memory: 63.1M
     CGroup: /system.slice/netdata.service
             ├─713 /usr/sbin/netdata -D
             ├─932 bash /usr/lib/netdata/plugins.d/tc-qos-helper.sh 1
             ├─936 /usr/lib/netdata/plugins.d/nfacct.plugin 1
             └─939 /usr/lib/netdata/plugins.d/apps.plugin 1

Apr 07 19:00:07 vagrant systemd[1]: Started netdata - Real-time performance monitoring.
Apr 07 19:00:09 vagrant netdata[713]: SIGNAL: Not enabling reaper
Apr 07 19:00:09 vagrant netdata[713]: 2022-04-07 19:00:09: netdata INFO  : MAIN : SIGNAL: Not enabling reaper

---

---
![](https://github.com/sergeev-anton/devops-netology/blob/fbe39e44dc9385a7f5a4e93ee8448b00cad805d7/Anton_HW/HW_3.4/pic.JPG)
---


4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?


---
vagrant@vagrant:~$ sudo dmesg | grep "Hypervisor detected"
[    0.000000] Hypervisor detected: KVM
---
---
Ядро выводит сообщение о KVM, значит ответ: да осознает.

---


5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

---
fs.nr_open - сообщает какое максимальное количество файловых дискриптеров возможно открыть

    The default value fs.nr_open is 1024*1024 = 1048576.
    The maximum value of fs.nr_open is limited to sysctl_nr_open_max in kernel, which is 2147483584 on x86_64.
---
---
vagrant@vagrant:~$ sysctl fs.nr_open
fs.nr_open = 1048576

---

6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

![](https://github.com/sergeev-anton/devops-netology/blob/fbe39e44dc9385a7f5a4e93ee8448b00cad805d7/Anton_HW/HW_3.4/pic2.JPG)

---
ТЕРМИНАЛ 1 

vagrant@vagrant:~$ sudo unshare -f --pid --mount-proc sleep 1h

---
ТЕРМИНАЛ 2 

vagrant@vagrant:~$ ps -e | grep sleep
   1991 pts/4    00:00:00 sleep

vagrant@vagrant:~$ sudo nsenter --target 1991 --mount --uts --ipc --net --pid ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   5476   524 pts/4    S+   15:35   0:00 sleep 1h
root           2  0.0  0.0   8892  3472 pts/3    R+   15:36   0:00 ps aux

---

7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

---

:() создается функция с названием ":"
{ } описано ее поведение (тело)
:|:& вызов себя и вызов себя повторно через логическое ИЛИ; 
& запуск в фоновом режиме
; конец описания функции
: вызов функции ":"

Получается ункция, которая вызывает себя дважды при каждом вызове и не имеет возможности завершить себя. Он будет удваиваться, пока у вас не закончатся системные ресурсы.

---
vagrant@vagrant:~$ dmesg
...
[13964.753718] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-7.scope

в журнале dmesg видим запись о том, что помог механизм cgroup

---