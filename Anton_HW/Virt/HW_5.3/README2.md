*********Доработанное задание 
--- 
````bash
vagrant@NETOLOGY:~$ docker images
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/images/json": dial unix /var/run/docker.sock: connect: permission denied
vagrant@NETOLOGY:~$ sudo !!
sudo docker images
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
vagrant@NETOLOGY:~$ docker run -d hello-world
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/create": dial unix /var/run/docker.sock: connect: permission denied.
See 'docker run --help'.
vagrant@NETOLOGY:~$ sudo !!
sudo docker run -d hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
2db29710123e: Pull complete
Digest: sha256:53f1bbee2f52c39e41682ee1d388285290c5c8a76cc92b42687eecf38e0af3f0
Status: Downloaded newer image for hello-world:latest
496d7c2837258833bdf76ffc9c9920e5fea69f33844b4bdb3e5b459bd5eff33a
vagrant@NETOLOGY:~$ sudo docker run -d nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
461246efe0a7: Pull complete
060bfa6be22e: Pull complete
b34d5ba6fa9e: Pull complete
8128ac56c745: Pull complete
44d36245a8c9: Pull complete
ebcc2cc821e6: Pull complete
Digest: sha256:1761fb5661e4d77e107427d8012ad3a5955007d997e0f4a3d41acc9ff20467c7
Status: Downloaded newer image for nginx:latest
643ee63ab74c1d6dd83adef0db31c9aa01b732ff386ce79006c8ce71f509fca6
vagrant@NETOLOGY:~$ sudo docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
nginx         latest    670dcc86b69d   6 days ago      142MB
hello-world   latest    feb5d9fea6a5   10 months ago   13.3kB
vagrant@NETOLOGY:~$ sudo docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                      PORTS     NAMES
643ee63ab74c   nginx         "/docker-entrypoint.…"   16 seconds ago   Up 15 seconds               80/tcp    inspiring_euclid
496d7c283725   hello-world   "/hello"                 38 seconds ago   Exited (0) 37 seconds ago             zealous_merkle
vagrant@NETOLOGY:~$ docker stop inspiring_euclid
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/inspiring_euclid/stop": dial unix /var/run/docker.sock: connect: permission denied
vagrant@NETOLOGY:~$ sudo !!
sudo docker stop inspiring_euclid
inspiring_euclid
vagrant@NETOLOGY:~$ sudo su
root@NETOLOGY:/home/vagrant# docker rm inspiring_euclid
inspiring_euclid
root@NETOLOGY:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
496d7c283725   hello-world   "/hello"   5 minutes ago   Exited (0) 5 minutes ago             zealous_merkle
root@NETOLOGY:/home/vagrant# docker run -d --name nginx-test_srv -p 8080:80  nginx
847024c07d368cf0aa78c996aa0753d54d7799c3f18c9c2360a54a6e5f9161dd
root@NETOLOGY:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS                     PORTS                                   NAMES
847024c07d36   nginx         "/docker-entrypoint.…"   5 seconds ago   Up 4 seconds               0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-test_srv
496d7c283725   hello-world   "/hello"                 6 minutes ago   Exited (0) 6 minutes ago                                           zealous_merkle
root@NETOLOGY:/home/vagrant# docker exec -ti nginx-test_srv nginx -v
nginx version: nginx/1.23.1
root@NETOLOGY:/home/vagrant#

vagrant@NETOLOGY:~$ mkdir dockerfiles
vagrant@NETOLOGY:~$ cd dockerfiles
vagrant@NETOLOGY:~/dockerfiles$ nano Dockerfile
---
Dockerfile

FROM nginx:1.21.3
COPY index.html /usr/share/nginx/html/index.html
---
root@NETOLOGY:/home/vagrant# docker exec -it nginx-test_srv  bash
root@847024c07d36:/# cat /usr/share/nginx/html/index.html
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>


````
---