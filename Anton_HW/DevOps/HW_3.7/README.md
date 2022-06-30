1. Проверьте список доступных сетевых интерфейсов на вашем компьютере. 
Какие команды есть для этого в Linux и в Windows?

---
```bash
для windows: ipconfig 

---
C:\Users\Anton.Shakhov>ipconfig

Настройка протокола IP для Windows


Адаптер Ethernet Ethernet 5:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . : spk-mag.ru

Адаптер Ethernet Ethernet 3:

   DNS-суффикс подключения . . . . . : spk-mag.ru
   Локальный IPv6-адрес канала . . . : fe80::dc04:65d1:c5aa:f927%7
   IPv4-адрес. . . . . . . . . . . . : 192.168.15.80
   Маска подсети . . . . . . . . . . : 255.255.254.0
   Основной шлюз. . . . . . . . . : 192.168.15.1

Адаптер Ethernet VirtualBox Host-Only Network:

   DNS-суффикс подключения . . . . . :
   Локальный IPv6-адрес канала . . . : fe80::345e:961:2346:96ab%9
   Автонастройка IPv4-адреса . . . . : 169.254.150.171
   Маска подсети . . . . . . . . . . : 255.255.0.0
   Основной шлюз. . . . . . . . . :

Адаптер беспроводной локальной сети Подключение по локальной сети* 1:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :

Адаптер беспроводной локальной сети Подключение по локальной сети* 2:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :

Адаптер беспроводной локальной сети Беспроводная сеть:

   DNS-суффикс подключения . . . . . : spk-mag.ru
   Локальный IPv6-адрес канала . . . : fe80::d438:1abf:1027:bd61%8
   IPv4-адрес. . . . . . . . . . . . : 192.168.15.70
   Маска подсети . . . . . . . . . . : 255.255.254.0
   Основной шлюз. . . . . . . . . : 192.168.15.1

Адаптер Ethernet Сетевое подключение Bluetooth:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :
---


для linux: ifconfig ; ip a 
---
vagrant@ASSET-10510:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 85827sec preferred_lft 85827sec
    inet6 fe80::a00:27ff:feb1:285d/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:45:ce:a3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.14.32/24 brd 192.168.14.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe45:cea3/64 scope link
       valid_lft forever preferred_lft forever
---       
```
---

2. Какой протокол используется для распознавания соседа по сетевому интерфейсу? 
Какой пакет и команды есть в Linux для этого?

---
```bash
LLDP – протокол канального уровня для обмена информацией между соседними устройствами, позволяет определить к какому 
порту коммутатора подключен сервер.

NDP (англ. Neighbor Discovery Protocol, ) - Протокол обнаружения соседей Любой компьютер, на котором установлен сетевой 
стек IPv6, должен выполнять NDP. Этот протокол обнаружения используется не только для обнаружения соседних устройств, 
но и сетей, в которых они находятся, выбора пути, адресов DNS-серверов, шлюзов и предотвращения дублирования IP-адресов. 
Это довольно надежный протокол, который объединяет ARP и ICMP запросы IPv4.

CDP (Cisco Discovery Protocol) - является собственным протоколом компании Cisco Systems, позволяющий обнаруживать 
подключённое (напрямую или через устройства первого уровня) сетевое оборудование Cisco, его название, версию IOS и 
IP-адреса
```
---

3. Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды 
есть в Linux для этого? Приведите пример конфига.

---
```bash
Технология, которая используется для разделения L2 коммутатора на несколько виртуальных сетей это VLAN. Пакет - vlan. 
Команды - apt install vlan

vagrant@ASSET-10510:~$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 86337sec preferred_lft 86337sec
    inet6 fe80::a00:27ff:feb1:285d/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:45:ce:a3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.14.32/24 brd 192.168.14.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe45:cea3/64 scope link
       valid_lft forever preferred_lft forever
vagrant@ASSET-10510:~$ sudo su
root@ASSET-10510:/home/vagrant# vconfig add eth0 200

Warning: vconfig is deprecated and might be removed in the future, please migrate to ip(route2) as soon as possible!

root@ASSET-10510:/home/vagrant# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 86296sec preferred_lft 86296sec
    inet6 fe80::a00:27ff:feb1:285d/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:45:ce:a3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.14.32/24 brd 192.168.14.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe45:cea3/64 scope link
       valid_lft forever preferred_lft forever
4: eth0.200@eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff
root@ASSET-10510:/home/vagrant#

root@ASSET-10510:/home/vagrant# apt install net-tools
root@ASSET-10510:/home/vagrant# ifconfig eth0.200 10.0.2.17 netmask 255.255.255.0 up
root@ASSET-10510:/home/vagrant# ifconfig -a
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.15  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:feb1:285d  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:b1:28:5d  txqueuelen 1000  (Ethernet)
        RX packets 152769  bytes 215435068 (215.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 7994  bytes 594246 (594.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.14.32  netmask 255.255.255.0  broadcast 192.168.14.255
        inet6 fe80::a00:27ff:fe45:cea3  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:45:ce:a3  txqueuelen 1000  (Ethernet)
        RX packets 10730  bytes 686019 (686.0 KB)
        RX errors 0  dropped 60  overruns 0  frame 0
        TX packets 21  bytes 1646 (1.6 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0.200: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.2.17  netmask 255.255.255.0  broadcast 10.0.2.255
        inet6 fe80::a00:27ff:feb1:285d  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:b1:28:5d  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 656 (656.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 66  bytes 6134 (6.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 66  bytes 6134 (6.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@ASSET-10510:/home/vagrant#

```
---

4. Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.
---
```bash
Bonding – это объединение сетевых интерфейсов по определенному типу агрегации, Служит для увеличения пропускной
способности и/или отказоустойчивость сети.

Типы агрегации интерфейсов в Linux:

Mode-0(balance-rr) – Данный режим используется по умолчанию. Balance-rr обеспечивается балансировку нагрузки и
отказоустойчивость. В данном режиме сетевые пакеты отправляются “по кругу”, от первого интерфейса к последнему. 
Если выходят из строя интерфейсы, пакеты отправляются на остальные оставшиеся. Дополнительной настройки коммутатора
не требуется при нахождении портов в одном коммутаторе. При разностных коммутаторах требуется дополнительная настройка.

Mode-1(active-backup) – Один из интерфейсов работает в активном режиме, остальные в ожидающем. При обнаружении проблемы
на активном интерфейсе производится переключение на ожидающий интерфейс. Не требуется поддержки от коммутатора.

Mode-2(balance-xor) – Передача пакетов распределяется по типу входящего и исходящего трафика 
по формуле ((MAC src) XOR (MAC dest)) % число интерфейсов. Режим дает балансировку нагрузки и отказоустойчивость. 
Не требуется дополнительной настройки коммутатора/коммутаторов.

Mode-3(broadcast) – Происходит передача во все объединенные интерфейсы, тем самым обеспечивая отказоустойчивость. 
Рекомендуется только для использования MULTICAST трафика.

Mode-4(802.3ad) – динамическое объединение одинаковых портов. В данном режиме можно значительно увеличить пропускную 
способность входящего так и исходящего трафика. Для данного режима необходима поддержка и 
настройка коммутатора/коммутаторов.

Mode-5(balance-tlb) – Адаптивная балансировки нагрузки трафика. Входящий трафик получается только активным интерфейсом, 
исходящий распределяется в зависимости от текущей загрузки канала каждого интерфейса. Не требуется специальной поддержки 
и настройки коммутатора/коммутаторов.

Mode-6(balance-alb) – Адаптивная балансировка нагрузки. Отличается более совершенным алгоритмом балансировки нагрузки 
чем Mode-5). Обеспечивается балансировку нагрузки как исходящего так и входящего трафика. Не требуется специальной 
поддержки и настройки коммутатора/коммутаторов.

---
active-backup

 network:
   version: 2
   renderer: networkd
   ethernets:
     ens3:
       dhcp4: no 
       optional: true
     ens5: 
       dhcp4: no 
       optional: true
   bonds:
     bond0: 
       dhcp4: yes 
       interfaces:
         - ens3
         - ens5
       parameters:
         mode: active-backup
         primary: ens3
         mii-monitor-interval: 2
---

---
balance-alb

 bonds:
     bond0: 
       dhcp4: yes 
       interfaces:
         - ens3
         - ens5
       parameters:
         mode: balance-alb
         mii-monitor-interval: 2

---
```
---

5. Cколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите 
несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

---
```bash
8 ip адресов находится внутри /29. Из маски /24 можно получить 32 сети с маской /29
```
---

6. Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 
192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета 
максимум 40-50 хостов внутри подсети.

---
```bash
Адресный блок 100.64.0.0/26 - подойдет для организации стыка между двумя организациями из расчета 40-50 хостов,
т.к. содержит в себе максимально возможные 64 ip, из которых два зарезервированы под адрес сети и broadkast.
```
---

7. Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? 
Как из ARP таблицы удалить только один нужный IP?

---
```bash

ПРОВЕРИТЬ

Linux:
root@ASSET-10510:~# arp -e
Address                  HWtype  HWaddress           Flags Mask            Iface
10.0.2.3                 ether   52:54:00:12:35:03   C                     eth0
_gateway                 ether   52:54:00:12:35:02   C                     eth0
root@ASSET-10510:~#




Windows:
C:\Users\Anton.Shakhov>arp -a

Интерфейс: 192.168.15.80 --- 0x7
  адрес в Интернете      Физический адрес      Тип
  192.168.14.32         08-00-27-45-ce-a3     динамический
  192.168.14.64         b4-45-06-4a-28-7d     динамический
  192.168.15.1          18-e8-29-bc-71-15     динамический
  192.168.15.139        6c-2b-59-d8-04-34     динамический
  192.168.15.200        00-11-32-e6-04-61     динамический
  192.168.15.211        52-ff-20-74-e6-62     динамический
  192.168.15.230        00-17-c8-66-0b-44     динамический
  192.168.15.233        00-17-c8-9e-80-5f     динамический
  192.168.15.240        00-17-c8-b0-cf-f5     динамический
  192.168.15.250        3c-ec-ef-01-95-aa     динамический
  192.168.15.255        ff-ff-ff-ff-ff-ff     статический
  224.0.0.22            01-00-5e-00-00-16     статический
  224.0.0.251           01-00-5e-00-00-fb     статический
  224.0.0.252           01-00-5e-00-00-fc     статический
  239.254.127.63        01-00-5e-7e-7f-3f     статический
  239.255.255.250       01-00-5e-7f-ff-fa     статический
  255.255.255.255       ff-ff-ff-ff-ff-ff     статический

Интерфейс: 192.168.15.70 --- 0x8
  адрес в Интернете      Физический адрес      Тип
  192.168.15.1          18-e8-29-bc-71-15     динамический
  192.168.15.139        6c-2b-59-d8-04-34     динамический
  192.168.15.200        00-11-32-e6-04-61     динамический
  192.168.15.211        52-ff-20-74-e6-62     динамический
  192.168.15.250        3c-ec-ef-01-95-aa     динамический
  192.168.15.255        ff-ff-ff-ff-ff-ff     статический
  224.0.0.22            01-00-5e-00-00-16     статический
  224.0.0.251           01-00-5e-00-00-fb     статический
  224.0.0.252           01-00-5e-00-00-fc     статический
  239.254.127.63        01-00-5e-7e-7f-3f     статический
  239.255.255.250       01-00-5e-7f-ff-fa     статический
  255.255.255.255       ff-ff-ff-ff-ff-ff     статический

Интерфейс: 169.254.150.171 --- 0x9
  адрес в Интернете      Физический адрес      Тип
  169.254.255.255       ff-ff-ff-ff-ff-ff     статический
  224.0.0.22            01-00-5e-00-00-16     статический
  224.0.0.251           01-00-5e-00-00-fb     статический
  224.0.0.252           01-00-5e-00-00-fc     статический
  239.254.127.63        01-00-5e-7e-7f-3f     статический
  239.255.255.250       01-00-5e-7f-ff-fa     статический
  255.255.255.255       ff-ff-ff-ff-ff-ff     статический

ОЧИСТИТЬ

Linux: ip neigh flush
Windows: arp -d *

УДАЛИТЬ один IP

Linux: ip neigh delete <IP> dev <INTERFACE>, arp -d <IP>
Windows: arp -d <IP>


```
---