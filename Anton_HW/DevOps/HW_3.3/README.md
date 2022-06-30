1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd. Обратите внимание, что strace выдаёт результат своей работы в поток stderr, а не в stdout.

---
vagrant@vagrant:~$ strace /bin/bash -c 'cd /tmp'
execve("/bin/bash", ["/bin/bash", "-c", "cd /tmp"], 0x7ffe4631b590 /* 23 vars */) = 0
brk(NULL)                               = 0x561066bf0000
arch_prctl(0x3001 /* ARCH_??? */, 0x7fffa83e2500) = -1 EINVAL (Invalid argument)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=26207, ...}) = 0
mmap(NULL, 26207, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fd00a403000
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libtinfo.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\240\346\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=192032, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fd00a401000
mmap(NULL, 194944, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fd00a3d1000
mmap(0x7fd00a3df000, 61440, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x7fd00a3df000
mmap(0x7fd00a3ee000, 57344, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d000) = 0x7fd00a3ee000
mmap(0x7fd00a3fc000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2a000) = 0x7fd00a3fc000
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0 \22\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=18816, ...}) = 0
mmap(NULL, 20752, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fd00a3cb000
mmap(0x7fd00a3cc000, 8192, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x7fd00a3cc000
mmap(0x7fd00a3ce000, 4096, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7fd00a3ce000
mmap(0x7fd00a3cf000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3000) = 0x7fd00a3cf000
close(3)                                = 0
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360q\2\0\0\0\0\0"..., 832) = 832
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
pread64(3, "\4\0\0\0\20\0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0", 32, 848) = 32
pread64(3, "\4\0\0\0\24\0\0\0\3\0\0\0GNU\0\t\233\222%\274\260\320\31\331\326\10\204\276X>\263"..., 68, 880) = 68
fstat(3, {st_mode=S_IFREG|0755, st_size=2029224, ...}) = 0
pread64(3, "\6\0\0\0\4\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0"..., 784, 64) = 784
pread64(3, "\4\0\0\0\20\0\0\0\5\0\0\0GNU\0\2\0\0\300\4\0\0\0\3\0\0\0\0\0\0\0", 32, 848) = 32
pread64(3, "\4\0\0\0\24\0\0\0\3\0\0\0GNU\0\t\233\222%\274\260\320\31\331\326\10\204\276X>\263"..., 68, 880) = 68
mmap(NULL, 2036952, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7fd00a1d9000
mprotect(0x7fd00a1fe000, 1847296, PROT_NONE) = 0
mmap(0x7fd00a1fe000, 1540096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x25000) = 0x7fd00a1fe000
mmap(0x7fd00a376000, 303104, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19d000) = 0x7fd00a376000
mmap(0x7fd00a3c1000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e7000) = 0x7fd00a3c1000
mmap(0x7fd00a3c7000, 13528, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7fd00a3c7000
close(3)                                = 0
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7fd00a1d6000
arch_prctl(ARCH_SET_FS, 0x7fd00a1d6740) = 0
mprotect(0x7fd00a3c1000, 12288, PROT_READ) = 0
mprotect(0x7fd00a3cf000, 4096, PROT_READ) = 0
mprotect(0x7fd00a3fc000, 16384, PROT_READ) = 0
mprotect(0x561065488000, 16384, PROT_READ) = 0
mprotect(0x7fd00a437000, 4096, PROT_READ) = 0
munmap(0x7fd00a403000, 26207)           = 0
openat(AT_FDCWD, "/dev/tty", O_RDWR|O_NONBLOCK) = 3
close(3)                                = 0
brk(NULL)                               = 0x561066bf0000
brk(0x561066c11000)                     = 0x561066c11000
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=3035952, ...}) = 0
mmap(NULL, 3035952, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7fd009ef0000
close(3)                                = 0
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=27002, ...}) = 0
mmap(NULL, 27002, PROT_READ, MAP_SHARED, 3, 0) = 0x7fd00a403000
close(3)                                = 0
getuid()                                = 1000
getgid()                                = 1000
geteuid()                               = 1000
getegid()                               = 1000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
ioctl(-1, TIOCGPGRP, 0x7fffa83e2354)    = -1 EBADF (Bad file descriptor)
sysinfo({uptime=311, loads=[2176, 18944, 11072], totalram=4127117312, freeram=3621859328, sharedram=1007616, bufferram=41787392, totalswap=2057302016, freeswap=2057302016, procs=166, totalhigh=0, freehigh=0, mem_unit=1}) = 0
rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGCHLD, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fd00a21f210}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGINT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, 8) = 0
rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTSTP, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, 8) = 0
rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTIN, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, 8) = 0
rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTTOU, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {sa_handler=SIG_IGN, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER, sa_restorer=0x7fd00a21f210}, 8) = 0
uname({sysname="Linux", nodename="vagrant", ...}) = 0
stat("/home/vagrant", {st_mode=S_IFDIR|0755, st_size=2883584, ...}) = 0
stat(".", {st_mode=S_IFDIR|0755, st_size=2883584, ...}) = 0
stat("/home", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat("/home/vagrant", {st_mode=S_IFDIR|0755, st_size=2883584, ...}) = 0
getpid()                                = 1139
getppid()                               = 1136
getpid()                                = 1139
getpgrp()                               = 1136
ioctl(2, TIOCGPGRP, [1136])             = 0
rt_sigaction(SIGCHLD, {sa_handler=0x5610653ceaa0, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fd00a21f210}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7fd00a21f210}, 8) = 0
prlimit64(0, RLIMIT_NPROC, NULL, {rlim_cur=15390, rlim_max=15390}) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
chdir("/tmp")                           = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
exit_group(0)                           = ?
+++ exited with 0 +++

вывод chdir("/tmp"), который подразумевает переход в каталог /tmp (cd /tmp)


2. Попробуйте использовать команду file на объекты разных типов на файловой системе.

---

openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3

stat("/home/vagrant/.magic.mgc", 0x7fff8c68f820) = -1 ENOENT (No such file or directory)

---


3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

---
TERM 1

vagrant@vagrant:~$ ping ya.ru > ping_log

---
TERM 2

---

root@vagrant:/home/vagrant# ps aux | grep ping

vagrant     2048  0.0  0.0   7208  2840 pts/1    S+   18:37   0:00 ping ya.ru

root        2051  0.0  0.0   6300   736 pts/0    S+   18:37   0:00 grep --color=auto ping

root@vagrant:/home/vagrant# lsof -p 2048

COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME

ping    2048 vagrant  cwd    DIR  253,0  2883584 1051845 /home/vagrant

ping    2048 vagrant  rtd    DIR  253,0     4096       2 /

ping    2048 vagrant  txt    REG  253,0    72776 1835881 /usr/bin/ping

ping    2048 vagrant  mem    REG  253,0    31176 1841606 /usr/lib/x86_64-linux-gnu/libnss_dns-2.31.so

ping    2048 vagrant  mem    REG  253,0    51832 1841607 /usr/lib/x86_64-linux-gnu/libnss_files-2.31.so

ping    2048 vagrant  mem    REG  253,0  3035952 1835290 /usr/lib/locale/locale-archive

ping    2048 vagrant  mem    REG  253,0   137584 1841525 /usr/lib/x86_64-linux-gnu/libgpg-error.so.0.28
.0
ping    2048 vagrant  mem    REG  253,0  2029224 1841468 /usr/lib/x86_64-linux-gnu/libc-2.31.so

ping    2048 vagrant  mem    REG  253,0   101320 1841650 /usr/lib/x86_64-linux-gnu/libresolv-2.31.so

ping    2048 vagrant  mem    REG  253,0  1168056 1835853 /usr/lib/x86_64-linux-gnu/libgcrypt.so.20.2.5

ping    2048 vagrant  mem    REG  253,0    31120 1841471 /usr/lib/x86_64-linux-gnu/libcap.so.2.32

ping    2048 vagrant  mem    REG  253,0   191472 1841428 /usr/lib/x86_64-linux-gnu/ld-2.31.so

ping    2048 vagrant    0u   CHR  136,1      0t0       4 /dev/pts/1

ping    2048 vagrant    1w   REG  253,0     2211 1048685 /home/vagrant/ping_log

ping    2048 vagrant    2u   CHR  136,1      0t0       4 /dev/pts/1

ping    2048 vagrant    3u  icmp             0t0   35662 00000000:0004->00000000:0000

ping    2048 vagrant    4u  sock    0,9      0t0   35663 protocol: PINGv6


root@vagrant:/home/vagrant# df -k

Filesystem                        1K-blocks      Used Available Use% Mounted on

udev                                2999144         0   2999144   0% /dev

tmpfs                                608864      1028    607836   1% /run

/dev/mapper/ubuntu--vg-ubuntu--lv  32380720   4439740  26273092  15% /

tmpfs                               3044312         0   3044312   0% /dev/shm

tmpfs                                  5120         0      5120   0% /run/lock

tmpfs                               3044312         0   3044312   0% /sys/fs/cgroup

/dev/loop2                            63488     63488         0 100% /snap/core20/1376

/dev/loop0                            56960     56960         0 100% /snap/core18/2344

/dev/loop3                            63488     63488         0 100% /snap/core20/1405

/dev/sda2                            999320    108612    821896  12% /boot

/dev/loop1                            56832     56832         0 100% /snap/core18/2128

/dev/loop4                            69632     69632         0 100% /snap/lxd/22526

/dev/loop5                            69504     69504         0 100% /snap/lxd/22753

/dev/loop6                            44800     44800         0 100% /snap/snapd/15177

/dev/loop7                            45824     45824         0 100% /snap/snapd/15314

vagrant                           497275900 197887776 299388124  40% /vagrant

tmpfs                                608860         0    608860   0% /run/user/1000

root@vagrant:/home/vagrant# rm ping_log

root@vagrant:/home/vagrant# lsof -p 2048

COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME

ping    2048 vagrant  cwd    DIR  253,0  2883584 1051845 /home/vagrant

ping    2048 vagrant  rtd    DIR  253,0     4096       2 /

ping    2048 vagrant  txt    REG  253,0    72776 1835881 /usr/bin/ping

ping    2048 vagrant  mem    REG  253,0    31176 1841606 /usr/lib/x86_64-linux-gnu/libnss_dns-2.31.so

ping    2048 vagrant  mem    REG  253,0    51832 1841607 /usr/lib/x86_64-linux-gnu/libnss_files-2.31.so

ping    2048 vagrant  mem    REG  253,0  3035952 1835290 /usr/lib/locale/locale-archive

ping    2048 vagrant  mem    REG  253,0   137584 1841525 /usr/lib/x86_64-linux-gnu/libgpg-error.so.0.28.0

ping    2048 vagrant  mem    REG  253,0  2029224 1841468 /usr/lib/x86_64-linux-gnu/libc-2.31.so

ping    2048 vagrant  mem    REG  253,0   101320 1841650 /usr/lib/x86_64-linux-gnu/libresolv-2.31.so

ping    2048 vagrant  mem    REG  253,0  1168056 1835853 /usr/lib/x86_64-linux-gnu/libgcrypt.so.20.2.5

ping    2048 vagrant  mem    REG  253,0    31120 1841471 /usr/lib/x86_64-linux-gnu/libcap.so.2.32

ping    2048 vagrant  mem    REG  253,0   191472 1841428 /usr/lib/x86_64-linux-gnu/ld-2.31.so

ping    2048 vagrant    0u   CHR  136,1      0t0       4 /dev/pts/1

ping    2048 vagrant    1w   REG  253,0   172607 1048685 /home/vagrant/ping_log (deleted)

ping    2048 vagrant    2u   CHR  136,1      0t0       4 /dev/pts/1

ping    2048 vagrant    3u  icmp             0t0   35662 00000000:0004->00000000:0000

ping    2048 vagrant    4u  sock    0,9      0t0   35663 protocol: PINGv6

root@vagrant:/home/vagrant# df -k

Filesystem                        1K-blocks      Used Available Use% Mounted on

udev                                2999144         0   2999144   0% /dev

tmpfs                                608864      1028    607836   1% /run

/dev/mapper/ubuntu--vg-ubuntu--lv  32380720   4440560  26272272  15% /

tmpfs                               3044312         0   3044312   0% /dev/shm

tmpfs                                  5120         0      5120   0% /run/lock

tmpfs                               3044312         0   3044312   0% /sys/fs/cgroup

/dev/loop2                            63488     63488         0 100% /snap/core20/1376

/dev/loop0                            56960     56960         0 100% /snap/core18/2344

/dev/loop3                            63488     63488         0 100% /snap/core20/1405

/dev/sda2                            999320    108612    821896  12% /boot

/dev/loop1                            56832     56832         0 100% /snap/core18/2128

/dev/loop4                            69632     69632         0 100% /snap/lxd/22526

/dev/loop5                            69504     69504         0 100% /snap/lxd/22753

/dev/loop6                            44800     44800         0 100% /snap/snapd/15177

/dev/loop7                            45824     45824         0 100% /snap/snapd/15314

vagrant                           497275900 197895500 299380400  40% /vagrant

tmpfs                                608860         0    608860   0% /run/user/1000


файл ping_log уладен, место на диске высвобождено. 

---
---
root@vagrant:/home/vagrant# lsof -p 2048

COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME

ping    2048 vagrant  cwd    DIR  253,0  2883584 1051845 /home/vagrant

ping    2048 vagrant  rtd    DIR  253,0     4096       2 /

ping    2048 vagrant  txt    REG  253,0    72776 1835881 /usr/bin/ping

ping    2048 vagrant  mem    REG  253,0    31176 1841606 /usr/lib/x86_64-linux-gnu/libnss_dns-2.31.so

ping    2048 vagrant  mem    REG  253,0    51832 1841607 /usr/lib/x86_64-linux-gnu/libnss_files-2.31.so

ping    2048 vagrant  mem    REG  253,0  3035952 1835290 /usr/lib/locale/locale-archive

ping    2048 vagrant  mem    REG  253,0   137584 1841525 /usr/lib/x86_64-linux-gnu/libgpg-error.so.0.28.0

ping    2048 vagrant  mem    REG  253,0  2029224 1841468 /usr/lib/x86_64-linux-gnu/libc-2.31.so

ping    2048 vagrant  mem    REG  253,0   101320 1841650 /usr/lib/x86_64-linux-gnu/libresolv-2.31.so

ping    2048 vagrant  mem    REG  253,0  1168056 1835853 /usr/lib/x86_64-linux-gnu/libgcrypt.so.20.2.5

ping    2048 vagrant  mem    REG  253,0    31120 1841471 /usr/lib/x86_64-linux-gnu/libcap.so.2.32

ping    2048 vagrant  mem    REG  253,0   191472 1841428 /usr/lib/x86_64-linux-gnu/ld-2.31.so

ping    2048 vagrant    0u   CHR  136,1      0t0       4 /dev/pts/1

ping    2048 vagrant    1w   REG  253,0   200543 1048685 /home/vagrant/ping_log (deleted)

ping    2048 vagrant    2u   CHR  136,1      0t0       4 /dev/pts/1

ping    2048 vagrant    3u  icmp             0t0   35662 00000000:0004->00000000:0000

ping    2048 vagrant    4u  sock    0,9      0t0   35663 protocol: PINGv6

root@vagrant:/home/vagrant# echo '' > /proc/2048/fd/1

root@vagrant:/home/vagrant# cat /dev/null > /proc/2048/fd/1

root@vagrant:/home/vagrant# > /proc/2048/fd/1

root@vagrant:/home/vagrant# truncate -s 0 /proc/2048/fd/1

перенаправил поток данных 

---
---
root@vagrant:/home/vagrant# ls -l

total 12

-rw-rw-r-- 1 vagrant vagrant    0 Mar 28 18:38 test

-rw-rw-r-- 1 vagrant vagrant    9 Mar 28 18:36 test0

-rw-rw-r-- 1 vagrant vagrant    9 Mar 28 18:38 test1

-rw-r--r-- 1 root    root    1744 Apr  6 17:52 test.txt

файл ping_log не обнаружен

---
---

root@vagrant:/home/vagrant# cat /proc/2048/fd/1

64 bytes from ya.ru (87.250.250.242): icmp_seq=2874 ttl=54 time=7.69 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2875 ttl=54 time=7.45 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2876 ttl=54 time=7.60 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2877 ttl=54 time=7.66 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2878 ttl=54 time=7.75 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2879 ttl=54 time=8.51 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2880 ttl=54 time=7.46 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2881 ttl=54 time=8.16 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2882 ttl=54 time=7.96 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2883 ttl=54 time=8.08 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2884 ttl=54 time=8.08 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2885 ttl=54 time=7.58 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2886 ttl=54 time=7.11 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2887 ttl=54 time=7.99 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2888 ttl=54 time=8.17 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2889 ttl=54 time=8.80 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2890 ttl=54 time=8.47 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2891 ttl=54 time=7.88 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2892 ttl=54 time=8.19 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2893 ttl=54 time=7.97 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2894 ttl=54 time=7.91 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2895 ttl=54 time=8.22 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2896 ttl=54 time=8.18 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2897 ttl=54 time=7.23 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2898 ttl=54 time=7.80 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2899 ttl=54 time=8.61 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2900 ttl=54 time=8.47 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2901 ttl=54 time=8.24 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2902 ttl=54 time=8.06 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2903 ttl=54 time=8.19 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2904 ttl=54 time=8.29 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2905 ttl=54 time=7.90 ms

64 bytes from ya.ru (87.250.250.242): icmp_seq=2906 ttl=54 time=7.42 ms

процесс продолжает работать 

---
---
root@vagrant:/home/vagrant# df -k

Filesystem                        1K-blocks      Used Available Use% Mounted on

udev                                2999144         0   2999144   0% /dev

tmpfs                                608864      1028    607836   1% /run

/dev/mapper/ubuntu--vg-ubuntu--lv  32380720   4440392  26272440  15% /

tmpfs                               3044312         0   3044312   0% /dev/shm

tmpfs                                  5120         0      5120   0% /run/lock

tmpfs                               3044312         0   3044312   0% /sys/fs/cgroup

/dev/loop2                            63488     63488         0 100% /snap/core20/1376

/dev/loop0                            56960     56960         0 100% /snap/core18/2344

/dev/loop3                            63488     63488         0 100% /snap/core20/1405

/dev/sda2                            999320    108612    821896  12% /boot

/dev/loop1                            56832     56832         0 100% /snap/core18/2128

/dev/loop4                            69632     69632         0 100% /snap/lxd/22526

/dev/loop5                            69504     69504         0 100% /snap/lxd/22753

/dev/loop6                            44800     44800         0 100% /snap/snapd/15177

/dev/loop7                            45824     45824         0 100% /snap/snapd/15314


vagrant                           497275900 197904064 299371836  40% /vagrant

tmpfs                                608860         0    608860   0% /run/user/1000


При проверке df -k место изменилось, но не значительно (высвобождено было гораздо больше). Системные логи продолжает работать, по-этому место на диске изменяется.   

---


4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

---
"Зомби" процессы, в отличии от "сирот" освобождают свои ресурсы, но не освобождают запись в таблице процессов.


--- 

5. В iovisor BCC есть утилита opensnoop. На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты?

---
root@vagrant:/home/vagrant# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
root@vagrant:/home/vagrant# /usr/sbin/opensnoop-bpfcc
PID    COMM               FD ERR PATH
2726   systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
2726   systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
925    vminfo              4   0 /var/run/utmp
706    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
706    dbus-daemon        20   0 /usr/share/dbus-1/system-services
706    dbus-daemon        -1   2 /lib/dbus-1/system-services
706    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
925    vminfo              4   0 /var/run/utmp
706    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
706    dbus-daemon        20   0 /usr/share/dbus-1/system-services
706    dbus-daemon        -1   2 /lib/dbus-1/system-services
706    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
711    irqbalance          6   0 /proc/interrupts
711    irqbalance          6   0 /proc/stat
711    irqbalance          6   0 /proc/irq/20/smp_affinity
711    irqbalance          6   0 /proc/irq/0/smp_affinity
711    irqbalance          6   0 /proc/irq/1/smp_affinity
711    irqbalance          6   0 /proc/irq/8/smp_affinity
711    irqbalance          6   0 /proc/irq/12/smp_affinity
711    irqbalance          6   0 /proc/irq/14/smp_affinity
711    irqbalance          6   0 /proc/irq/15/smp_affinity
925    vminfo              4   0 /var/run/utmp
706    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
706    dbus-daemon        20   0 /usr/share/dbus-1/system-services
706    dbus-daemon        -1   2 /lib/dbus-1/system-services
706    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
1440   upowerd             9   0 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/present
1440   upowerd             9   0 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/energy_now
1440   upowerd            -1   2 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/voltage_max_design
1440   upowerd             9   0 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/voltage_min_design
1440   upowerd             9   0 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/status
1440   upowerd             9   0 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/power_now
1440   upowerd            -1   2 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/charge_full
1440   upowerd            -1   2 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/charge_full_design
1440   upowerd            -1   2 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/current_now
1440   upowerd             9   0 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/voltage_now
1440   upowerd             9   0 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/capacity
1440   upowerd            -1   2 /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/PNP0C0A:00/power_supply/BAT0/temp
925    vminfo              4   0 /var/run/utmp
706    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
706    dbus-daemon        20   0 /usr/share/dbus-1/system-services
706    dbus-daemon        -1   2 /lib/dbus-1/system-services
706    dbus-daemon        20   0 /var/lib/snapd/dbus-1/system-services/
711    irqbalance          6   0 /proc/interrupts
711    irqbalance          6   0 /proc/stat
711    irqbalance          6   0 /proc/irq/20/smp_affinity
711    irqbalance          6   0 /proc/irq/0/smp_affinity
711    irqbalance          6   0 /proc/irq/1/smp_affinity
711    irqbalance          6   0 /proc/irq/8/smp_affinity
711    irqbalance          6   0 /proc/irq/12/smp_affinity
711    irqbalance          6   0 /proc/irq/14/smp_affinity
711    irqbalance          6   0 /proc/irq/15/smp_affinity

---


6. Какой системный вызов использует uname -a?

---
Инструмент uname обычно используется для определения архитектуры процессора, имени хоста системы и версии ядра, работающего в системе, -a , ( --all ) — При использовании параметра -a uname ведет себя так же, как если бы были заданы параметры -snrvmo . Альтернативное местоположение системого вызова находится: / proc / sys / ядро/ {osrelease, version}.

---


7. Чем отличается последовательность команд через ; и через && в bash? Есть ли смысл использовать в bash &&, если применить set -e?

---
Разница в том, что при исполнении команд через ";" они исполняются последовательно и следующая команда исполнится в любом
 случае в не зависимости от успешного /неуспешного завершения предыдущей.
При исполнении команд через "&&" каждая последующая команда будет исполняться только в случае успешного завершения предыдущей.
 Kоманда set -e прерывает процесс исполнения программы, даже если оболочка возвращает ненулевой статус, имеет смысл, если исполнится вместе через ";"

---


8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

---
-e скрипт немедленно завершит работу, если любая команда выйдет с ошибкой. По-умолчанию, игнорируются любые неудачи и сценарий продолжет выполнятся. Если предполагается, что команда может завершиться с ошибкой, но это не критично, можно использовать пайплайн || true.
 Bash возвращает только код ошибки последней команды в пайпе (конвейере). И параметр -e проверяет только его. Если нужно убедиться, что все команды в пайпах завершились успешно, нужно использовать -o pipefail.
-u. Благодаря ему оболочка проверяет инициализацию переменных в скрипте. Если переменной не будет, скрипт немедленно завершиться. Данный параметр достаточно умен, чтобы нормально работать с переменной по-умолчанию ${MY_VAR:-$DEFAULT} и условными операторами (if, while, и др).
Параметр -x очень полезен при отладке. С помощью него bash печатает в стандартный вывод все команды перед их исполнением. Стоит учитывать, что все переменные будут уже доставлены, и с этим нужно быть аккуратнее, к примеру если используете пароли.
Не стоит забывать, что все эти параметры можно объединять и комбинировать между собой! set -euxo pipefail.
Для сценария хорошо тем, что отслеживает ошибки и прерывает исполнение сценария при ошибке любой команды кроме последней.

---


9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

---
root@vagrant:/home/vagrant# ps -o stat
STAT
S
S
S
R+
root@vagrant:/home/vagrant# man ps

Ss - спящий процесс в лидирующей сессии
R+ -  выполняемый процесс, который находится в основной группе процессов

root@vagrant:~# man ps
PROCESS STATE CODES

Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process:

 D    uninterruptible sleep (usually IO) 

 I    Idle kernel thread 

 R    running or runnable (on ru queue)

 S    interruptible sleep (waiting for an event to complete)

 T    stopped by job control signal 

 t    stopped by debugger during the tracin 

 W    paging (not valid since the 2.6.xx kernel) 

 X    dead (should never be seen) 

 Z    defunct ("zombie") process, terminated but not reaped by its parent
 
For BSD formats and when the stat keyword is used, additional characters may be displayed:

 <    high-priority (not nice to other users)

 N    low-priority (nice to other users)

 L    has pages locked into memory (for real-time and custom IO)

 s    is a session leader

 l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)

 '+'  is in the foreground process group


Дополнительные символы к основной букве выводят расширенную информацию о процессе (например приоритет процесса)

---