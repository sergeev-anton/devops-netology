1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP.

---
```bash
-----
vagrant@ASSET-10510:~$ telnet route-views.routeviews.org
Trying 128.223.51.103...
Connected to route-views.routeviews.org.
Escape character is '^]'.
C
**********************************************************************

                    RouteViews BGP Route Viewer
                    route-views.routeviews.org

 route views data is archived on http://archive.routeviews.org

 This hardware is part of a grant by the NSF.
 Please contact help@routeviews.org if you have questions, or
 if you wish to contribute your view.

 This router has views of full routing tables from several ASes.
 The list of peers is located at http://www.routeviews.org/peers
 in route-views.oregon-ix.net.txt

 NOTE: The hardware was upgraded in August 2014.  If you are seeing
 the error message, "no default Kerberos realm", you may want to
 in Mac OS X add "default unset autologin" to your ~/.telnetrc

 To login, use the username "rviews".

 **********************************************************************

User Access Verification

Username: rviews

-----

route-views>show ip route 46.22.49.20
Routing entry for 46.22.48.0/20
  Known via "bgp 6447", distance 20, metric 10
  Tag 3257, type external
  Last update from 89.149.178.10 2d11h ago
  Routing Descriptor Blocks:
  * 89.149.178.10, from 89.149.178.10, 2d11h ago
      Route metric is 10, traffic share count is 1
      AS Hops 4
      Route tag 3257
      MPLS label: none
route-views>

route-views>show bgp 46.22.49.20
BGP routing table entry for 46.22.48.0/20, version 2005920138
Paths: (23 available, best #23, table default)
  Not advertised to any peer
  Refresh Epoch 1
  49788 6939 35598 29226 12722 12722 12722
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 49788:1000
      path 7FE16C265F28 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 31500 12722 12722
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      path 7FE16D693C28 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3303 1273 31500 12722 12722
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external
      Community: 1273:12752 3303:1004 3303:1007 3303:1030 3303:3067
      path 7FE135160E10 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 1299 12722 12722
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 1299:30000 8283:1 8283:101
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001
      path 7FE01ACE19F8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
```
---

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

---
```bash
vagrant@ASSET-10510:~$ sudo su
root@ASSET-10510:/home/vagrant# ip link add dev dum0 type dummy
root@ASSET-10510:/home/vagrant# ip address add 10.0.2.17/24 dev dum0
root@ASSET-10510:/home/vagrant# ip address show dum0
4: dum0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 32:dc:e3:e9:19:15 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.17/24 scope global dum0
       valid_lft forever preferred_lft forever
root@ASSET-10510:/home/vagrant#
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
       valid_lft 79419sec preferred_lft 79419sec
    inet6 fe80::a00:27ff:feb1:285d/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:45:ce:a3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.14.32/24 brd 192.168.14.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe45:cea3/64 scope link
       valid_lft forever preferred_lft forever
4: dum0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 32:dc:e3:e9:19:15 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.17/24 scope global dum0
       valid_lft forever preferred_lft forever
root@ASSET-10510:/home/vagrant#




root@ASSET-10510:/home/vagrant# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    100    0        0 eth0
10.0.2.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
_gateway        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
192.168.14.0    0.0.0.0         255.255.255.0   U     0      0        0 eth1
root@ASSET-10510:/home/vagrant#
```
---

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты?

---
```bash
root@ASSET-10510:/home/vagrant# netstat -pntul
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      641/systemd-resolve
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      729/sshd: /usr/sbin
tcp6       0      0 :::22                   :::*                    LISTEN      729/sshd: /usr/sbin
udp        0      0 127.0.0.53:53           0.0.0.0:*                           641/systemd-resolve
udp        0      0 10.0.2.15:68            0.0.0.0:*                           639/systemd-network
root@ASSET-10510:/home/vagrant#
```
---

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?
---
```bash

udp-53  641/systemd-resolve - служба systemd, выполняющая разрешение сетевых имён для локальных приложений 
```
---

4. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/HW_3.8/Work_net.JPG)
