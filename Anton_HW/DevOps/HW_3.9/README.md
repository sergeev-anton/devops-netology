1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.



![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/HW_3.9/1.JPG)


2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через 
Google authenticator OTP.



![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/HW_3.9/2.JPG)


После включения двухфакторной авторизвции при заедении новоого элемента в Bitwarden появляется поля для ввода 
ОТР кода



3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

---
```bash
vagrant@ASSET-10510:~$ sudo apt install apache2
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following package was automatically installed and is no longer required:
  libfwupdplugin1
Use 'sudo apt autoremove' to remove it.
The following additional packages will be installed:
  apache2-bin apache2-data apache2-utils libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap libjansson4 liblua5.2-0
  ssl-cert
Suggested packages:
  apache2-doc apache2-suexec-pristine | apache2-suexec-custom www-browser openssl-blacklist
The following NEW packages will be installed:
  apache2 apache2-bin apache2-data apache2-utils libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap libjansson4
  liblua5.2-0 ssl-cert
0 upgraded, 11 newly installed, 0 to remove and 4 not upgraded.
Need to get 1,866 kB of archives.
After this operation, 8,091 kB of additional disk space will be used.
Do you want to continue? [Y/n] y
Abort.
vagrant@ASSET-10510:~$


-----
root@ASSET-10510:/home/vagrant# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
Generating a RSA private key
............+++++
....................................................................+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:RU
State or Province Name (full name) [Some-State]:Moscow
Locality Name (eg, city) []:Netology
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Dev_Sys_Anton_Sergeev
Organizational Unit Name (eg, section) []:Hello_World
Common Name (e.g. server FQDN or YOUR name) []:10.0.2.15
Email Address []:0Parazit0@gmail.com
root@ASSET-10510:/home/vagrant#
-----

```
---

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос,
РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

---
```bash
root@ASSET-10510:/home/vagrant# ./testssl.sh -U --sneaky  https://mail.ru

ATTENTION: No cipher mapping file found!
Please note from 2.9 on testssl.sh needs files in "$TESTSSL_INSTALL_DIR/etc/" to function correctly.

Type "yes" to ignore this warning and proceed at your own risk --> yes

ATTENTION: No TLS data file found -- needed for socket-based handshakes
Please note from 2.9 on testssl.sh needs files in "$TESTSSL_INSTALL_DIR/etc/" to function correctly.

Type "yes" to ignore this warning and proceed at your own risk --> yes


###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.1.1f  31 Mar 2020" [~0 ciphers]
 on ASSET-10510:/usr/bin/openssl
 (built: "Nov 24 13:20:48 2021", platform: "debian-amd64")


 Start 2022-04-30 20:04:27        -->> 94.100.180.200:443 (mail.ru) <<--

 rDNS (94.100.180.200):  --
 Testing with mail.ru:443 only worked using /usr/bin/openssl.
 Test results may be somewhat better if the --ssl-native option is used.
 Type "yes" to proceed and accept false negatives or positives --> yes
 Service detected:       HTTP


 Testing vulnerabilities

 Heartbleed (CVE-2014-0160)                Error setting TLSv1.3 ciphersuites
139919253108032:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     Error setting TLSv1.3 ciphersuites
140287192425792:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139887423579456:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139693529691456:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
140264475387200:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139666185643328:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139736533333312:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139644052264256:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139844549707072:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139858692592960:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139809226220864:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
Error setting TLSv1.3 ciphersuites
139662253241664:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                test failed (couldn't connect)
 BREACH (CVE-2013-3587)                    no gzip/deflate/compress/br HTTP compression (OK)  - only supplied "/" tested
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK), no SSLv3 support
 TLS_FALLBACK_SCSV (RFC 7507)              test failed (couldn't connect)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services
                                           https://censys.io/ipv4?q=C58194212B8EAB437678D9D8871E13B1584F9E96BCC0EB230100AE1513EA0A12 could help you to find out
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
 LUCKY13 (CVE-2013-0169), experimental     Error setting TLSv1.3 ciphersuites
140520092562752:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    Error setting TLSv1.3 ciphersuites
140309926282560:error:1426E0B9:SSL routines:ciphersuite_cb:no cipher match:../ssl/ssl_ciph.c:1294:
not vulnerable (OK) - ARIA, CHACHA or CCM ciphers found
 RC4 (CVE-2013-2566, CVE-2015-2808)        Local problem: No RC4 Ciphers configured in /usr/bin/openssl


 Done 2022-04-30 20:06:23 [ 121s] -->> 94.100.180.200:443 (mail.ru) <<--
```
---


5.Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер.
Подключитесь к серверу по SSH-ключу.

---
```bash
vagrant@vagrant:~$ sudo su
root@vagrant:/home/vagrant# apt install openssh-server
Reading package lists... Done
Building dependency tree
Reading state information... Done
openssh-server is already the newest version (1:8.2p1-4ubuntu0.3).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.


root@vagrant:/home/vagrant# cat /etc/ssh/ssh_config

# This is the ssh client system-wide configuration file.  See
# ssh_config(5) for more information.  This file provides defaults for
# users, and the values can be changed in per-user configuration files
# or on the command line.

# Configuration data is parsed as follows:
#  1. command line options
#  2. user-specific file
#  3. system-wide file
# Any configuration value is only changed the first time it is set.
# Thus, host-specific definitions should be at the beginning of the
# configuration file, and defaults at the end.

# Site-wide defaults for some commonly used options.  For a comprehensive
# list of available options, their meanings and defaults, please see the
# ssh_config(5) man page.

Include /etc/ssh/ssh_config.d/*.conf

Host *
#   ForwardAgent no
#   ForwardX11 no
#   ForwardX11Trusted yes
#   PasswordAuthentication yes
#   HostbasedAuthentication no
#   GSSAPIAuthentication no
#   GSSAPIDelegateCredentials no
#   GSSAPIKeyExchange no
#   GSSAPITrustDNS no
#   BatchMode no
#   CheckHostIP yes
#   AddressFamily any
#   ConnectTimeout 0
#   StrictHostKeyChecking ask
#   IdentityFile ~/.ssh/id_rsa
#   IdentityFile ~/.ssh/id_dsa
#   IdentityFile ~/.ssh/id_ecdsa
#   IdentityFile ~/.ssh/id_ed25519
#   Port 22
#   Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc
#   MACs hmac-md5,hmac-sha1,umac-64@openssh.com
#   EscapeChar ~
#   Tunnel no
#   TunnelDevice any:any
#   PermitLocalCommand no
#   VisualHostKey no
#   ProxyCommand ssh -q -W %h:%p gateway.example.com
#   RekeyLimit 1G 1h
    PubkeyAuthentication yes
    SendEnv LANG LC_*
    HashKnownHosts yes
    GSSAPIAuthentication yes
    
    
    
    
    
    
    
root@vagrant:/home/vagrant# ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
/root/.ssh/id_rsa already exists.
Overwrite (y/n)? y
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa
Your public key has been saved in /root/.ssh/id_rsa.pub
The key fingerprint is:
SHA256:seQg9LARcxriuuldLBabr+WBzU8RU3+vlfjxdJF/0bQ root@vagrant
The key's randomart image is:
+---[RSA 3072]----+
|  . B..  .      .|
| . o X  . .    .+|
|  . + ooo  . . E.|
| .   . +oo  . o =|
|.  .   .S    . ==|
| o  O   .     +.=|
|o  * B .     . ..|
|. o * +          |
| . o.o .         |
+----[SHA256]-----+
root@vagrant:/home/vagrant# cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7MT5PZNvqkNpupQ3TjTchtUd+ERqEaCXxpmeaulRIPtR/LSQEmfrfIizj1UUOo3iQpbzMX4bvdyw+J+UgvIO2zQkVBuzXi27OsD/LPHhP3aZAUYaLOn3yzbGdySfWsU+FUd6dZypqbA1ueVuUbBrGz9mHQe8OebT6YVqPqD7/juXbJN1Rvdtf2tbzVb66RUDIOrVDgUvuoEA2s+3y/zYzwYubiDK+aZIi+WTesjSXJbC2ICetmoNtPaCFilhfpLD+pSq/F2YgBYRL75ltlON8Op77bafSht3k6Xa5w997UzmeUd7ba9Eryh/wSoTeuPDp3p6pilXy5xgXNB6N0EdknCoOjsRqx8zkkziaZe/UVbryK9PSUomBWL0k52zogRowzWlvhsCrTb//00o6hfX7DNvEeTu/Nc6w6r2kUT7Cdt+pT+Z1iU/BjBzlh4mzUXbHkx7i6gR7747yD67JlAckXu/fa797WQfOO4VFanK4eGVaWijpEtjzCB5OdBfPXBs= root@vagrant
root@vagrant:/home/vagrant#



root@vagrant:/home/vagrant# ssh-copy-id root@vagrant
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@vagrant's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@vagrant'"
and check to make sure that only the key(s) you wanted were added.


Входа на сервера с Windows
C:\Users\Anton.Shakhov>ssh root@vagrant
The authenticity of host 'vagrant (fe80::c06a:a5f1:660:d341%6)' can't be established.
ECDSA key fingerprint is SHA256:8J30d+xUyPtN9+nqL/paZwyT+5mY+/Zst4okzsRAIbg.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'vagrant,fe80::c06a:a5f1:660:d341%6' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-35-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

9 updates can be applied immediately.
Чтобы просмотреть дополнительные обновления выполните: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.










```
---

6.Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер
осуществлялся по имени сервера.

---
```bash
Для входа на удаленный сервер по имени сервера ( ubuntu), создаем файл config на Windows машине в директории
 C:\Users[user].ssh\ c содержимым:

Host ubuntu
  HostName 10.0.2.15
  IdentityFile ~/.ssh/key_rsa
  User root
  Port 22



C:\Users\Anton.Shakhov>ssh ubuntu
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-35-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

9 updates can be applied immediately.
Чтобы просмотреть дополнительные обновления выполните: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
```
---

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

---
```bash

vagrant@ASSET-10510:~$ tcpdump -c 100 -i eth0
tcpdump: eth0: You don't have permission to capture on that device
(socket: Operation not permitted)
vagrant@ASSET-10510:~$ sudo !!
sudo tcpdump -c 100 -i eth0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
12:07:02.451703 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1226503774:1226503930, ack 13700355, win 64032, 
length 156
12:07:02.452038 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 156, win 65535, length 0
12:07:02.452709 IP 10.0.2.15.54393 > 10.0.2.3.domain: 410+ [1au] PTR? 2.2.0.10.in-addr.arpa. (50)
12:07:02.461653 IP 10.0.2.3.domain > 10.0.2.15.54393: 410 NXDomain* 0/1/1 (109)
12:07:02.461965 IP 10.0.2.15.54393 > 10.0.2.3.domain: 410+ PTR? 2.2.0.10.in-addr.arpa. (39)
12:07:02.498046 IP 10.0.2.3.domain > 10.0.2.15.54393: 410 NXDomain* 0/1/0 (98)
12:07:07.634729 ARP, Request who-has 10.0.2.3 tell 10.0.2.15, length 28
12:07:07.635486 ARP, Reply 10.0.2.3 is-at 52:54:00:12:35:03 (oui Unknown), length 46
12:07:07.651626 IP 10.0.2.15.41453 > 10.0.2.3.domain: 26657+ [1au] PTR? 15.2.0.10.in-addr.arpa. (51)
12:07:07.655343 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 156:328, ack 1, win 64032, length 172
12:07:07.655554 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 328, win 65535, length 0
12:07:07.655748 IP 10.0.2.15.38920 > 10.0.2.3.domain: 57472+ [1au] PTR? 3.2.0.10.in-addr.arpa. (50)
12:07:07.656775 IP 10.0.2.3.domain > 10.0.2.15.41453: 26657 NXDomain* 0/1/1 (110)
12:07:07.656831 IP 10.0.2.15 > 10.0.2.3: ICMP 10.0.2.15 udp port 41453 unreachable, length 146
12:07:07.661549 IP 10.0.2.3.domain > 10.0.2.15.38920: 57472 NXDomain* 0/1/1 (109)
12:07:07.662360 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 328:532, ack 1, win 64032, length 204
12:07:07.662578 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 532:776, ack 1, win 64032, length 244
12:07:07.662931 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 776:836, ack 1, win 64032, length 60
12:07:07.663048 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 532, win 65535, length 0
12:07:07.663048 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 776, win 65535, length 0
12:07:07.663281 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 836:964, ack 1, win 64032, length 128
12:07:07.663490 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 836, win 65535, length 0
12:07:07.663540 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 964:1016, ack 1, win 64032, length 52
12:07:07.663784 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1016:1084, ack 1, win 64032, length 68
12:07:07.663886 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 964, win 65535, length 0
12:07:07.663886 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1016, win 65535, length 0
12:07:07.664319 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1084, win 65535, length 0
12:07:07.664319 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1084:1160, ack 1, win 64032, length 76
12:07:07.664614 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1160, win 65535, length 0
12:07:07.664681 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1160:1228, ack 1, win 64032, length 68
12:07:07.665103 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1228:1288, ack 1, win 64032, length 60
12:07:07.667761 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1228, win 65535, length 0
12:07:07.667761 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1288, win 65535, length 0
12:07:07.667843 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1288:1340, ack 1, win 64032, length 52
12:07:07.668024 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1340:1408, ack 1, win 64032, length 68
12:07:07.668064 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1340, win 65535, length 0
12:07:07.668271 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1408, win 65535, length 0
12:07:07.668315 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1408:1468, ack 1, win 64032, length 60
12:07:07.668564 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1468, win 65535, length 0
12:07:07.668614 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1468:1528, ack 1, win 64032, length 60
12:07:07.668846 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1528:1588, ack 1, win 64032, length 60
12:07:07.668967 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1528, win 65535, length 0
12:07:07.669102 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1588:1648, ack 1, win 64032, length 60
12:07:07.669201 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1588, win 65535, length 0
12:07:07.669389 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1648:1708, ack 1, win 64032, length 60
12:07:07.669528 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1648, win 65535, length 0
12:07:07.669747 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1708:1768, ack 1, win 64032, length 60
12:07:07.669845 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1708, win 65535, length 0
12:07:07.670042 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1768, win 65535, length 0
12:07:07.670083 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1768:1828, ack 1, win 64032, length 60
12:07:07.670411 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1828, win 65535, length 0
12:07:07.670488 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1828:1888, ack 1, win 64032, length 60
12:07:07.670964 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1888:1940, ack 1, win 64032, length 52
12:07:07.671186 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1888, win 65535, length 0
12:07:07.671329 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1940:2000, ack 1, win 64032, length 60
12:07:07.671486 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 1940, win 65535, length 0
12:07:07.671738 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2000, win 65535, length 0
12:07:07.671816 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2000:2060, ack 1, win 64032, length 60
12:07:07.672072 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2060, win 65535, length 0
12:07:07.672115 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2060:2120, ack 1, win 64032, length 60
12:07:07.672388 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2120, win 65535, length 0
12:07:07.672430 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2120:2180, ack 1, win 64032, length 60
12:07:07.672684 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2180:2232, ack 1, win 64032, length 52
12:07:07.672801 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2180, win 65535, length 0
12:07:07.672991 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2232, win 65535, length 0
12:07:07.672996 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2232:2292, ack 1, win 64032, length 60
12:07:07.673220 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2292, win 65535, length 0
12:07:07.673290 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2292:2352, ack 1, win 64032, length 60
12:07:07.673499 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2352, win 65535, length 0
12:07:07.673578 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2352:2412, ack 1, win 64032, length 60
12:07:07.674085 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2412, win 65535, length 0
12:07:07.674145 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2412:2464, ack 1, win 64032, length 52
12:07:07.674378 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2464:2524, ack 1, win 64032, length 60
12:07:07.674466 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2464, win 65535, length 0
12:07:07.674815 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2524, win 65535, length 0
12:07:07.674851 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2524:2584, ack 1, win 64032, length 60
12:07:07.675119 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2584, win 65535, length 0
12:07:07.675153 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2584:2644, ack 1, win 64032, length 60
12:07:07.675422 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2644, win 65535, length 0
12:07:07.675493 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2644:2704, ack 1, win 64032, length 60
12:07:07.675718 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2704, win 65535, length 0
12:07:07.676233 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2704:2764, ack 1, win 64032, length 60
12:07:07.676531 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2764, win 65535, length 0
12:07:07.676537 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2764:2808, ack 1, win 64032, length 44
12:07:07.676642 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2808:2884, ack 1, win 64032, length 76
12:07:07.676784 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2808, win 65535, length 0
12:07:07.676953 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2884, win 65535, length 0
12:07:07.676984 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2884:2944, ack 1, win 64032, length 60
12:07:07.677179 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 2944, win 65535, length 0
12:07:07.677288 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 2944:3012, ack 1, win 64032, length 68
12:07:07.677504 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 3012:3064, ack 1, win 64032, length 52
12:07:07.677513 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 3012, win 65535, length 0
12:07:07.677711 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 3064, win 65535, length 0
12:07:07.677779 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 3064:3124, ack 1, win 64032, length 60
12:07:07.677959 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 3124, win 65535, length 0
12:07:07.677992 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 3124:3176, ack 1, win 64032, length 52
12:07:07.678168 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 3176:3236, ack 1, win 64032, length 60
12:07:07.678215 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 3176, win 65535, length 0
12:07:07.678429 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 3236, win 65535, length 0
12:07:07.678475 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 3236:3296, ack 1, win 64032, length 60
100 packets captured
100 packets received by filter
0 packets dropped by kernel
vagrant@ASSET-10510:~$


vagrant@ASSET-10510:~$ tcpdump -w 0001.pcap -i eth0
tcpdump: eth0: You don't have permission to capture on that device
(socket: Operation not permitted)
vagrant@ASSET-10510:~$ sudo !!
sudo tcpdump -w 0001.pcap -i eth0
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
^C49 packets captured
52 packets received by filter
0 packets dropped by kernel
vagrant@ASSET-10510:~$ sudo tcpdump -r 0001.pcap
reading from file 0001.pcap, link-type EN10MB (Ethernet)
12:12:45.521571 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 1226508066:1226508102, ack 13701199, win 64032,
 length 36
12:12:45.522149 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 36, win 65535, length 0
12:12:45.522165 IP 10.0.2.15.ssh > 10.0.2.2.54305: Flags [P.], seq 36:72, ack 1, win 64032, length 36
12:12:45.522460 IP 10.0.2.2.54305 > 10.0.2.15.ssh: Flags [.], ack 72, win 65535, length 0
12:13:13.343990 IP 10.0.2.15.42796 > 10.0.2.3.domain: 43013+ [1au] A? api.snapcraft.io. (45)
12:13:13.344808 IP 10.0.2.15.39680 > 10.0.2.3.domain: 46062+ [1au] AAAA? api.snapcraft.io. (45)
12:13:13.352029 IP 10.0.2.3.domain > 10.0.2.15.39680: 46062 0/1/1 (109)
12:13:13.352029 IP 10.0.2.3.domain > 10.0.2.15.42796: 43013 4/0/1 A 185.125.188.60, A 185.125.188.54, A 185.125.188.57,
 A 185.125.188.58 (109)
12:13:13.352682 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [S], seq 3801484978, win 64240, options [mss 1460,
sackOK,TS val 680641794 ecr 0,nop,wscale 7], length 0
12:13:13.414643 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [S.], seq 193408001, ack 3801484979, win 65535,
 options [mss 1460], length 0
12:13:13.414723 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 1, win 64240, length 0
12:13:13.415050 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [P.], seq 1:265, ack 1, win 64240, length 264
12:13:13.415310 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 265, win 65535, length 0
12:13:13.476846 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], seq 1:2921, ack 265, win 65535, length 2920
12:13:13.476878 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 2921, win 62780, length 0
12:13:13.477861 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 2921:3538, ack 265, win 65535, length 617
12:13:13.477940 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 3538, win 62163, length 0
12:13:13.479984 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [P.], seq 265:329, ack 3538, win 62780, length 64
12:13:13.480477 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [P.], seq 329:1537, ack 3538, win 62780, length 1208
12:13:13.481281 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 329, win 65535, length 0
12:13:13.481281 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 1537, win 65535, length 0
12:13:13.481290 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [P.], seq 1537:2607, ack 3538, win 62780, length 1070
12:13:13.481669 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 2607, win 65535, length 0
12:13:13.542445 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 3538:3617, ack 2607, win 65535, length 79
12:13:13.542445 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 3617:3696, ack 2607, win 65535, length 79
12:13:13.542482 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 3617, win 62780, length 0
12:13:13.542533 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 3696, win 62780, length 0
12:13:13.563946 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 3696:4395, ack 2607, win 65535, length 699
12:13:13.563979 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 4395, win 62780, length 0
12:13:13.568208 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [P.], seq 2607:5373, ack 4395, win 62780, length 2766
12:13:13.568558 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 4067, win 65535, length 0
12:13:13.568558 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 5373, win 65535, length 0
12:13:13.783738 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 4395:7275, ack 5373, win 65535, length 2880
12:13:13.783739 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 7275:8883, ack 5373, win 65535, length 1608
12:13:13.783739 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], seq 8883:13263, ack 5373, win 65535, length 4380
12:13:13.783766 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 7275, win 62780, length 0
12:13:13.783832 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 8883, win 61320, length 0
12:13:13.783891 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 13263, win 58400, length 0
12:13:13.784459 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 13263:18579, ack 5373, win 65535, length 5316
12:13:13.784468 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 18579, win 61320, length 0
12:13:18.578321 ARP, Request who-has 10.0.2.3 tell 10.0.2.15, length 28
12:13:18.579061 ARP, Reply 10.0.2.3 is-at 52:54:00:12:35:03 (oui Unknown), length 46
12:13:18.788282 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [P.], seq 18579:18603, ack 5373, win 65535, length 24
12:13:18.788282 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [F.], seq 18603, ack 5373, win 65535, length 0
12:13:18.788343 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [.], ack 18603, win 62780, length 0
12:13:18.788959 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [P.], seq 5373:5397, ack 18604, win 62780, length 24
12:13:18.789252 IP 10.0.2.15.42262 > 185.125.188.60.https: Flags [F.], seq 5397, ack 18604, win 62780, length 0
12:13:18.789674 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 5397, win 65535, length 0
12:13:18.790058 IP 185.125.188.60.https > 10.0.2.15.42262: Flags [.], ack 5398, win 65535, length 0
vagrant@ASSET-10510:~$
```
---