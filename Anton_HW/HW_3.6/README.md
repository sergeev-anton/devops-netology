1. Работа c HTTP через телнет.

- Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
---
vagrant@vagrant:~$ telnet stackoverflow.com 80 

Trying 151.101.65.69...

Connected to stackoverflow.com.

Escape character is '^]'.

GET /questions HTTP/1.0

HTTP/1.1 500 Domain Not Found

Server: Varnish

Retry-After: 0

content-type: text/html

Cache-Control: private, no-cache

X-Served-By: cache-hel1410028-HEL

Content-Length: 223

Accept-Ranges: bytes

Date: Thu, 14 Apr 2022 15:09:06 GMT

Via: 1.1 varnish
Connection: close


<html>
<head>
<title>Fastly error: unknown domain </title>
</head>
<body>
<p>Fastly error: unknown domain: . Please check that this domain has been added to a service.</p>
<p>Details: cache-hel1410028-HEL</p></body></html>Connection closed by foreign host.



HTTP/1.1 500 Domain Not Found   - Домен не найден . 

---
-
---

vagrant@vagrant:~$ sudo su

root@vagrant:/home/vagrant# telnet stackoverflow.com 80

Trying 151.101.65.69...

Connected to stackoverflow.com.

Escape character is '^]'.

GET /questions HTTP/1.0

HOST: stackoverflow.com

HTTP/1.1 301 Moved Permanently

cache-control: no-cache, no-store, must-revalidate

location: https://stackoverflow.com/questions

x-request-guid: a7584af4-d3d2-4fe9-a87e-4d262da52f6b

feature-policy: microphone 'none'; speaker 'none'

content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com

Accept-Ranges: bytes

Date: Thu, 14 Apr 2022 15:16:56 GMT

Via: 1.1 varnish

Connection: close

X-Served-By: cache-hel1410030-HEL

X-Cache: MISS

X-Cache-Hits: 0

X-Timer: S1649949416.411598,VS0,VE112

Vary: Fastly-SSL

X-DNS-Prefetch-Control: off

Set-Cookie: prov=b904ba57-0866-df25-f690-eb5616aadf3c; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly

Connection closed by foreign host.

root@vagrant:/home/vagrant#


HTTP/1.1 301 Moved Permanently - HTTP/1.1 301 Moved Permanently - означает что эта страница перемещена и переброс будет произведен 
по https://stackoverflow.com/questions. Данная страница не кэшируется, кэш расчитывается заново при каждом соединении.

---


2. Повторите задание 1 в браузере, используя консоль разработчика F12.

---
ссылки на картинки 3 шт 

---

---

- Дольше всего обробатывается GET запрос 200  (document)

---

3. Какой IP адрес у вас в интернете?

---
speedtest.net 

мой ip 46.22.49.20

ссылка 

---

4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой

---
root@vagrant:/home/vagrant# whois 46.22.49.20

bash: whois: command not found

root@vagrant:/home/vagrant# apt install whois

Reading package lists... Done

Building dependency tree


Reading state information... Done

The following NEW packages will be installed:

  whois

0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.

Need to get 44.7 kB of archives.

After this operation, 279 kB of additional disk space will be used.

Get:1 http://us.archive.ubuntu.com/ubuntu focal/main amd64 whois amd64 5.5.6 [44.7 kB]

Fetched 44.7 kB in 1s (78.6 kB/s)

Selecting previously unselected package whois.

(Reading database ... 43055 files and directories currently installed.)

Preparing to unpack .../archives/whois_5.5.6_amd64.deb ...

Unpacking whois (5.5.6) ...

Setting up whois (5.5.6) ...

Processing triggers for man-db (2.9.1-1) ...

---

---
root@vagrant:/home/vagrant# whois 46.22.49.20

% This is the RIPE Database query service.

% The objects are in RPSL format.

%

% The RIPE Database is subject to Terms and Conditions.

% See http://www.ripe.net/db/support/db-terms-conditions.pdf




% Note: this output has been filtered.

%       To receive output for a database update, use the "-B" flag.



% Information related to '46.22.48.0 - 46.22.63.255'



% Abuse contact for '46.22.48.0 - 46.22.63.255' is 'abuse@reconn.ru'



inetnum:        46.22.48.0 - 46.22.63.255

netname:        RU-RCN-20101123

remarks:        RFT acquired net

country:        RU


org:            ORG-RL441-RIPE

admin-c:        RA10008-RIPE

tech-c:         REC-RIPE

status:         ALLOCATED PA

mnt-by:         RECONN-MNT

mnt-by:         RIPE-NCC-HM-MNT

created:        2020-03-11T10:37:09Z

last-modified:  2020-05-04T09:00:26Z

source:         RIPE



organisation:   ORG-RL441-RIPE

org-name:       RECONN LLC

country:        RU

org-type:       LIR

address:        Nauchnyi proezd, 20 stroenie 2

address:        117246

address:        Moscow

address:        RUSSIAN FEDERATION


phone:          +7.495.478-7777

fax-no:         +7.495.478-7778

admin-c:        RA10008-RIPE

tech-c:         REC-RIPE

abuse-c:        AR57542-RIPE

mnt-ref:        RECONN-MNT

mnt-by:         RIPE-NCC-HM-MNT

mnt-by:         RECONN-MNT

created:        2020-01-27T09:02:14Z

last-modified:  2022-03-12T17:54:12Z

source:         RIPE # Filtered



role:           RECONN ADMIN

address:        Nauchnyi proezd, 20 stroenie 2

address:        117246

address:        Moscow

address:        RUSSIAN FEDERATION

phone:          +7.495.478-7777

nic-hdl:        RA10008-RIPE

mnt-by:         RECONN-MNT

created:        2020-01-27T09:02:14Z

last-modified:  2020-05-03T12:08:07Z

source:         RIPE # Filtered



role:           RECONN NOC

address:        Nauchnyi Proezd, 20str.2, Moscow, Russia

address:        Technopark SLAVA

remarks:        DATA-CENTER and NOC (Network Operaional Center), RECONN Group

phone:          +7.495.478-7777

abuse-mailbox:  abuse@reconn.ru

nic-hdl:        REC-RIPE

mnt-by:         RECONN-MNT

created:        2015-04-16T14:56:35Z

last-modified:  2020-05-03T12:05:09Z

source:         RIPE # Filtered



% Information related to '46.22.48.0/20AS12722'


route:          46.22.48.0/20

descr:          RECONN Operator Svyazi LLC

origin:         AS12722

mnt-by:         RECONN-MNT

created:        2015-11-09T09:23:25Z

last-modified:  2015-11-09T09:23:40Z

source:         RIPE

% This query was served by the RIPE Database Query Service version 1.102.3 (BLAARKOP)

root@vagrant:/home/vagrant#

---

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой

---
root@vagrant:/home/vagrant# traceroute 8.8.8.8
bash: traceroute: command not found
root@vagrant:/home/vagrant# apt install traceroute

---

---
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  _gateway (10.0.2.2)  0.575 ms  0.493 ms  0.435 ms
 2  _gateway (10.0.2.2)  3.216 ms  3.140 ms  2.585 ms

---
на виртуальной машине .

---
C:\Users\Anton.Shakhov>tracert 8.8.8.8

Трассировка маршрута к dns.google [8.8.8.8]
с максимальным числом прыжков 30:

  1     1 ms     1 ms     1 ms  192.168.15.1
  2     1 ms     1 ms     1 ms  46.22.49.1
  3     1 ms     1 ms     1 ms  10.33.1.33
  4     8 ms     1 ms     2 ms  195.209.45.236
  5     2 ms     2 ms     2 ms  195.209.63.255
  6     2 ms     2 ms     2 ms  142.250.47.108
  7     3 ms     2 ms     1 ms  209.85.250.231
  8     *        3 ms     3 ms  108.170.250.113
  9     *       17 ms    17 ms  142.251.237.154
 10    23 ms    20 ms    20 ms  142.251.237.142
 11    19 ms    21 ms    20 ms  209.85.251.63
 12     *        *        *     Превышен интервал ожидания для запроса.
 13     *        *        *     Превышен интервал ожидания для запроса.
 14     *        *        *     Превышен интервал ожидания для запроса.
 15     *        *        *     Превышен интервал ожидания для запроса.
 16     *        *        *     Превышен интервал ожидания для запроса.
 17     *        *        *     Превышен интервал ожидания для запроса.
 18     *        *        *     Превышен интервал ожидания для запроса.
 19     *        *        *     Превышен интервал ожидания для запроса.
 20     *        *        *     Превышен интервал ожидания для запроса.
 21     *        *        *     Превышен интервал ожидания для запроса.
 22     *        *        *     Превышен интервал ожидания для запроса.
 23    16 ms    16 ms    16 ms  dns.google [8.8.8.8]

Трассировка завершена.


cmd.exe -  Windows

---

---
vagrant@vagrant:~$ traceroute 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  _gateway (192.168.15.1)  3.509 ms  3.054 ms  3.049 ms
 2  46.22.49.1 (46.22.49.1)  3.499 ms  3.496 ms  4.595 ms
 3  10.33.1.33 (10.33.1.33)  6.150 ms  6.147 ms  6.144 ms
 4  195.209.45.236 (195.209.45.236)  6.140 ms  6.137 ms  6.166 ms
 5  195.209.63.255 (195.209.63.255)  6.128 ms  6.124 ms  6.121 ms
 6  142.250.47.108 (142.250.47.108)  6.574 ms  3.263 ms  3.403 ms
 7  * * *
 8  72.14.235.226 (72.14.235.226)  3.960 ms 108.170.226.90 (108.170.226.90)  3.563 ms  3.114 ms
 9  108.170.250.66 (108.170.250.66)  3.574 ms 108.170.250.51 (108.170.250.51)  19.753 ms 108.170.250.66 (108.170.250.66)  4.195 ms
10  142.250.238.138 (142.250.238.138)  18.786 ms * 72.14.234.54 (72.14.234.54)  18.081 ms
11  142.251.238.72 (142.251.238.72)  22.873 ms  22.648 ms 142.251.237.142 (142.251.237.142)  26.287 ms
12  172.253.79.237 (172.253.79.237)  18.968 ms 142.250.57.7 (142.250.57.7)  18.543 ms 216.239.40.61 (216.239.40.61)  21.696 ms
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  dns.google (8.8.8.8)  17.076 ms  15.071 ms *
vagrant@vagrant:


подключился к виртуальной машине через putty (настроена через сетевой мост)

---

---
vagrant@vagrant:~$ whois -h whois.radb.net 8.8.8.8
route:      8.8.8.0/24
descr:      Google
origin:     AS15169
notify:     radb-contact@google.com
mnt-by:     MAINT-AS15169
changed:    radb-contact@google.com 20150728
source:     RADB

route:         8.0.0.0/9
descr:         Proxy-registered route object
origin:        AS3356
remarks:       auto-generated route object
remarks:       this next line gives the robot something to recognize
remarks:       L'enfer, c'est les autres
remarks:
remarks:       This route object is for a Level 3 customer route
remarks:       which is being exported under this origin AS.
remarks:
remarks:       This route object was created because no existing
remarks:       route object with the same origin was found, and
remarks:       since some Level 3 peers filter based on these objects
remarks:       this route may be rejected if this object is not created.
remarks:
remarks:       Please contact routing@Level3.net if you have any
remarks:       questions regarding this object.
mnt-by:        LEVEL3-MNT
changed:       roy@Level3.net 20060203
source:        LEVEL3


AS- AS15169

---


6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?

---

vagrant (10.0.2.15)                                                                            2022-04-14T17:11:25+0000
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                                               Packets               Pings
 Host                                                                        Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. _gateway                                                                  0.0%    22    0.7   0.9   0.3   1.7   0.3
 2. 192.168.15.1                                                              0.0%    22    2.0   2.1   1.2   3.6   0.5
 3. 46.22.49.1                                                                0.0%    21    1.9   2.1   1.0   2.6   0.3
 4. 10.33.1.33                                                                0.0%    21    2.0   2.4   1.3   5.0   0.8
 5. 195.209.45.236                                                            0.0%    21    2.6   2.8   2.0   3.4   0.3
 6. 195.209.63.255                                                            0.0%    21    2.7   2.8   1.9   3.5   0.4
 7. 142.250.47.108                                                            0.0%    21    3.1   3.2   2.1   4.0   0.5
 8. 209.85.250.231                                                            0.0%    21   21.1   3.9   2.2  21.1   3.9
 9. 108.170.250.113                                                           4.8%    21   15.1   7.4   3.1  62.2  13.3
10. 142.251.237.154                                                          30.0%    21   17.9  18.4  17.3  26.4   2.3
11. 142.251.237.142                                                           0.0%    21   18.1  21.0  17.7  36.8   4.9
12. 209.85.251.63                                                             0.0%    21   17.8  17.5  16.8  18.0   0.4
13. (waiting for reply)
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. (waiting for reply)
18. (waiting for reply)
19. (waiting for reply)
20. (waiting for reply)
21. (waiting for reply)
22. (waiting for reply)
23. (waiting for reply)
24. dns.google                                                                0.0%    21   17.5  17.5  16.4  18.6   0.5



наибольшая задержка на 11 хопе

---

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой

---

NS записи

vagrant@vagrant:~$ dig +short NS dns.google

ns2.zdns.google.

ns3.zdns.google.

ns1.zdns.google.

ns4.zdns.google.


A записи

vagrant@vagrant:~$ dig +short A dns.google

8.8.8.8

8.8.4.4



vagrant@vagrant:~$ dig dns.google A NS
;; Warning, extra type option

; <<>> DiG 9.16.1-Ubuntu <<>> dns.google A NS

;; global options: +cmd

;; Got answer:

;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 47161
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1


;; OPT PSEUDOSECTION:

; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:

;dns.google.                    IN      NS



;; ANSWER SECTION:

dns.google.             7030    IN      NS      ns4.zdns.google.

dns.google.             7030    IN      NS      ns1.zdns.google.

dns.google.             7030    IN      NS      ns3.zdns.google.

dns.google.             7030    IN      NS      ns2.zdns.google.

;; Query time: 0 msec

;; SERVER: 127.0.0.53#53(127.0.0.53)

;; WHEN: Thu Apr 14 17:21:21 UTC 2022

;; MSG SIZE  rcvd: 116


---

8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой
---
dns.google.             7030    IN      NS      ns4.zdns.google.
dns.google.             7030    IN      NS      ns1.zdns.google.
dns.google.             7030    IN      NS      ns3.zdns.google.
dns.google.             7030    IN      NS      ns2.zdns.google.




vagrant@vagrant:~$ dig  ns1.zdns.google.

; <<>> DiG 9.16.1-Ubuntu <<>> ns1.zdns.google.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 59732
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;ns1.zdns.google.               IN      A

;; ANSWER SECTION:
ns1.zdns.google.        21599   IN      A       216.239.32.114

;; Query time: 56 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Apr 14 17:30:27 UTC 2022
;; MSG SIZE  rcvd: 60

vagrant@vagrant:~$ dig  ns2.zdns.google.

; <<>> DiG 9.16.1-Ubuntu <<>> ns2.zdns.google.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 10729
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;ns2.zdns.google.               IN      A

;; ANSWER SECTION:
ns2.zdns.google.        20535   IN      A       216.239.34.114

;; Query time: 20 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Apr 14 17:30:55 UTC 2022
;; MSG SIZE  rcvd: 60

vagrant@vagrant:~$ dig  ns3.zdns.google.

; <<>> DiG 9.16.1-Ubuntu <<>> ns3.zdns.google.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 32140
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;ns3.zdns.google.               IN      A

;; ANSWER SECTION:
ns3.zdns.google.        20761   IN      A       216.239.36.114

;; Query time: 20 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Apr 14 17:31:01 UTC 2022
;; MSG SIZE  rcvd: 60

vagrant@vagrant:~$ dig  ns4.zdns.google.

; <<>> DiG 9.16.1-Ubuntu <<>> ns4.zdns.google.
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 29574
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;ns4.zdns.google.               IN      A

;; ANSWER SECTION:
ns4.zdns.google.        41977   IN      A       216.239.38.114

;; Query time: 4 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Thu Apr 14 17:31:06 UTC 2022
;; MSG SIZE  rcvd: 60

vagrant@vagrant:~$

---
