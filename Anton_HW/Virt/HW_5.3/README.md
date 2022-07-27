Задача 1 

---
````bash
-----
vagrant@ASSET-10510:~$ sudo su
root@ASSET-10510:/home/vagrant# docker images
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
nginx         latest    670dcc86b69d   15 hours ago   142MB
hello-world   latest    feb5d9fea6a5   9 months ago   13.3kB
root@ASSET-10510:/home/vagrant#

-----

-----
root@ASSET-10510:/home/vagrant# docker run -d --name nginx-test_srv -p 8080:80  nginx
d91b6510efbcc803f9bc73a4c3e6261c2a2db3c701d03846a30041d47a2db3b1
root@ASSET-10510:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                     PORTS                                   NAMES
d91b6510efbc   nginx         "/docker-entrypoint.…"   7 seconds ago    Up 5 seconds               0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-test_srv
8c5815dec746   nginx         "/docker-entrypoint.…"   14 minutes ago   Exited (0) 2 minutes ago                                           bold_antonelli
9b200a9ba733   hello-world   "/hello"                 4 hours ago      Exited (0) 4 hours ago
root@ASSET-10510:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS                   PORTS                                   NAMES
d91b6510efbc   nginx         "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes             0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-test_srv
9b200a9ba733   hello-world   "/hello"                 4 hours ago     Exited (0) 4 hours ago                                           ecstatic_banach

-----

-----
root@d91b6510efbc:/# echo '<html><head>Hey, Netology</head><body><h1>I am DevOps Engineer!</h1></body></html>' > /usr/share/nginx/html/default.html
root@d91b6510efbc:/# cd /usr/share/nginx/html/
root@d91b6510efbc:/usr/share/nginx/html# ls
50x.html  default.html  index.html
root@d91b6510efbc:/usr/share/nginx/html# cp default.html index.html
root@d91b6510efbc:/usr/share/nginx/html# rm default.html
root@d91b6510efbc:/usr/share/nginx/html# cat /usr/share/nginx/html/index.html
<html><head>Hey, Netology</head><body><h1>I am DevOps Engineer!</h1></body></html>
root@d91b6510efbc:/usr/share/nginx/html#
-----
-----
root@ASSET-10510:/home/vagrant# docker commit -m "Chahge index.html" -a "Sergeev Anton" d91b6510efbc antonsergeev/nginx-netology
sha256:4ace756d85154950c06ce7efa70518450b5807b7fcfb43b7f2ebd07abad2e08a
root@ASSET-10510:/home/vagrant# docker images
REPOSITORY                    TAG       IMAGE ID       CREATED              SIZE
antonsergeev/nginx-netology   latest    4ace756d8515   About a minute ago   142MB
nginx                         latest    670dcc86b69d   20 hours ago         142MB
hello-world                   latest    feb5d9fea6a5   9 months ago         13.3kB
root@ASSET-10510:/home/vagrant#

-----

-----
root@ASSET-10510:/home/vagrant# docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: antonsergeev
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
root@ASSET-10510:/home/vagrant#
-----

-----
root@ASSET-10510:/home/vagrant# docker push antonsergeev/nginx-netology
Using default tag: latest
The push refers to repository [docker.io/antonsergeev/nginx-netology]
b784f375b2f4: Pushed
abc66ad258e9: Mounted from library/nginx
243243243ee2: Mounted from library/nginx
f931b78377da: Mounted from library/nginx
d7783033d823: Mounted from library/nginx
4553dc754574: Mounted from library/nginx
43b3c4e3001c: Mounted from library/nginx
latest: digest: sha256:179636d0e15d7ab7b858851c6f1823414f6a88953691a75556b3295669f282e1 size: 1778
root@ASSET-10510:/home/vagrant#
-----

-----
https://hub.docker.com/r/antonsergeev/nginx-netology/tags
-----
Доработка задания 


С ресурса https://github.com/dockerfile/nginx/blob/master/Dockerfile  берем конфиг для dockerfile вносим команду COPU 
и описываем откуда взять файл (index.html) и куда его необходимо скопировать .
 
 
 --
 30 lines (24 sloc)  634 Bytes

#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# COPY 
FROM nginx:1.21.3
COPY "путь к необходимому файлу"index.html /usr/share/nginx/html/index.html

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80
EXPOSE 443
 --
 
 
Создаем файл index.html и вписываем в 
него выше упомянутые данные ('<html><head>Hey, Netology</head><body><h1>I am DevOps Engineer!</h1></body></html>'). 
Далее делаем docker build нового контейнера , далее заходим в запущенный контейнер командой exce -ti и проверяем файл 
index.html  командой cat 
  


````
---

Задача 2 

---
````bash

* Высоконагруженное монолитное java веб-приложение;
-----
 Физический сервер, т.к. монолитное (доставляемое через единую систему развертывания с одной точкой входа), потому в 
микросерверах не реализуемо без изменения кода, и так как высоконагруженное (необходим физический доступ к ресурсам, 
виртуалка не подходит).
-----
* Nodejs веб-приложение;
-----
 Docker, и в рамках микропроцессрной архитектуры может быть хорошим решением.
-----
* Мобильное приложение c версиями для Android и iOS;
-----
 Виртуальная машина - приложение в докере не имеет графической оболочки
-----
* Шина данных на базе Apache Kafka;
-----
 Можно использовать Docker, но и физический сервер вполне подойдет . 
-----
* Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, 
два logstash и две ноды kibana;
-----
 Docker подойдёт лучше, так как он будет удобней для кластеризации.
-----
* Мониторинг-стек на базе Prometheus и Grafana;
-----
 Можно развернуть на Docker, скорость развертывания, возможность масштабирования для различных задач.
-----
* MongoDB, как основное хранилище данных для java-приложения;
-----
 Docker для mongodb существует, но для продакшн систем, если данных много, скорее всего лучше виртуальная машина.
-----
* Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
-----
 Docker не подходит в данном случае, т.к. при потере контейнера будет сложно восстановить частоизменяемые данные.
Здесь больше подходят виртуальные сервера.
-----

````
---

Задача 3

---
````bash
-----
root@ASSET-10510:/home/vagrant# docker pull centos
Using default tag: latest
latest: Pulling from library/centos
a1d0c7532777: Pull complete
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
docker.io/library/centos:latest
root@ASSET-10510:/home/vagrant# docker pull debian
Using default tag: latest
latest: Pulling from library/debian
d836772a1c1f: Pull complete
Digest: sha256:2ce44bbc00a79113c296d9d25524e15d423b23303fdbbe20190d2f96e0aeb251
Status: Downloaded newer image for debian:latest
docker.io/library/debian:latest
root@ASSET-10510:/home/vagrant# docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
antonsergeev/nginx-netology   latest    4ace756d8515   19 hours ago    142MB
nginx                         latest    670dcc86b69d   40 hours ago    142MB
debian                        latest    123c2f3835fd   9 days ago      124MB
hello-world                   latest    feb5d9fea6a5   10 months ago   13.3kB
centos                        latest    5d0da3dc9764   10 months ago   231MB
root@ASSET-10510:/home/vagrant#
-----

root@ASSET-10510:/home/vagrant#  mkdir /opt/data
root@ASSET-10510:/home/vagrant#

-----

root@ASSET-10510:/home/vagrant# docker run -t -d --name Debian -v /opt/data:/opt/data:rw debian
428bbf313cada50b7468ed15061b1af295800cadabcdbe9d9f7c581068f95c5b
root@ASSET-10510:/home/vagrant# docker run -t -d --name Centos -v /opt/data:/opt/data:rw centos
9c01f335ae8d6df2e89f1494db39cf63f03b1504ebc9f43d6437114d5bcb935b
root@ASSET-10510:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                    PORTS                                   NAMES
9c01f335ae8d   centos        "/bin/bash"              11 seconds ago   Up 10 seconds                                                     Centos
428bbf313cad   debian        "bash"                   22 seconds ago   Up 20 seconds                                                     Debian
d91b6510efbc   nginx         "/docker-entrypoint.…"   21 hours ago     Up 20 hours               0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-test_srv
9b200a9ba733   hello-world   "/hello"                 25 hours ago     Exited (0) 25 hours ago                                           ecstatic_banach
root@ASSET-10510:/home/vagrant#

-----
root@ASSET-10510:/home/vagrant# docker exec -it Debian bash
root@428bbf313cad:/# ls -l /opt/data
total 0
-rw-r--r-- 1 root root 0 Jul 21 10:57 test_file_debian
root@428bbf313cad:/#


root@ASSET-10510:/home/vagrant# touch /opt/data/test_file_2
root@ASSET-10510:/home/vagrant# ls -l /opt/data/
total 0
-rw-r--r-- 1 root root 0 Jul 21 11:05 test_file_2
-rw-r--r-- 1 root root 0 Jul 21 10:57 test_file_debian
root@ASSET-10510:/home/vagrant#


-----

root@ASSET-10510:/home/vagrant# docker exec -it Centos bash
[root@9c01f335ae8d /]# ls -l /opt/data
total 0
-rw-r--r-- 1 root root 0 Jul 21 11:05 test_file_2
-rw-r--r-- 1 root root 0 Jul 21 10:57 test_file_debian
[root@9c01f335ae8d /]#

````
---
