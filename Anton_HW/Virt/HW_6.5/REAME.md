# Задача 1
- Используя докер образ centos:7 как базовый и документацию по установке и запуску Elasticsearch

В связи с ограничениями, файлы elasticsearch были скачаны с помощью VPN. 


---
````bash
root@NETOLOGY:/opt/hw_6.5/elasticsearch# ls -l
total 513796
-rw-r--r-- 1 root root         862 Dec  1 17:09 dockerfile
-rwxrwx--- 1 root vboxsf 526111529 Nov 21 07:58 elasticsearch-8.2.3-linux-x86_64.tar.gz
-rwxrwx--- 1 root vboxsf       170 Nov 21 07:56 elasticsearch-8.2.3-linux-x86_64.tar.gz.sha512
````
---

- dockerfile

---
````bash
root@NETOLOGY:/opt/hw_6.5/elasticsearch# cat dockerfile
FROM centos:7

EXPOSE 9200

USER 0

COPY elasticsearch-8.2.3-linux-x86_64.tar.gz /opt
COPY elasticsearch-8.2.3-linux-x86_64.tar.gz.sha512 /opt

RUN cd  /opt && \
mkdir elasticsearch-8.2.3 && \
sha512sum -c elasticsearch-8.2.3-linux-x86_64.tar.gz.sha512 && \
tar -xzf elasticsearch-8.2.3-linux-x86_64.tar.gz -C elasticsearch-8.2.3  && \
rm -f elasticsearch-8.2.3-linux-x86_64.tar.gz* && \
mv elasticsearch-8.2.3 /var/lib/elasticsearch && \
adduser -m -u 1000 elastic && \
chown elastic:elastic -R /var/lib/elasticsearch && \
cd /var/lib/elasticsearch && \
cd elasticsearch-8.2.3/ && \
echo "node.name: netology_test" >> config/elasticsearch.yml && \
echo "network.host: 127.0.0.1" >> config/elasticsearch.yml && \
echo "path.data: /var/lib/elasticsearch" >> config/elasticsearch.yml

USER elastic

CMD /var/lib/elasticsearch/elasticsearch-8.2.3/bin/elasticsearch
root@NETOLOGY:/opt/hw_6.5/elasticsearch#

````
---

- Создание docker контейнера

---
````bash
root@NETOLOGY:/opt/hw_6.5/elasticsearch# docker build  -t antonsergeev/devops-elasticsearch:8.2.3
Sending build context to Docker daemon  526.1MB
Step 1/8 : FROM centos:7
7: Pulling from library/centos
2d473b07cdd5: Pull complete
Digest: sha256:c73f515d06b0fa07bb18d8202035e739a494ce760aa73129f60f4bf2bd22b407
Status: Downloaded newer image for centos:7
 ---> eeb6ee3f44bd
Step 2/8 : EXPOSE 9200
 ---> Running in 19458e2c3c31
Removing intermediate container 19458e2c3c31
 ---> 7c3c46c50704
Step 3/8 : USER 0
 ---> Running in 16d8da7d98f7
Removing intermediate container 16d8da7d98f7
 ---> 9a65ff1c890d
Step 4/8 : COPY elasticsearch-8.2.3-linux-x86_64.tar.gz /opt
 ---> 2f32d5ebd7a7
Step 5/8 : COPY elasticsearch-8.2.3-linux-x86_64.tar.gz.sha512 /opt
 ---> 45083dc1387f
Step 6/8 : RUN cd  /opt && mkdir elasticsearch-8.2.3 && sha512sum -c elasticsearch-8.2.3-linux-x86_64.tar.gz.sha512 && tar -xzf elasticsearch-8.2.3-linux-x86_64.tar.gz -C elasticsearch-8.2.3  && rm -f elasticsearch-8.2.3-linux-x86_64.tar.gz* && mv elasticsearch-8.2.3 /var/lib/elasticsearch && adduser -m -u 1000 elastic && chown elastic:elastic -R /var/lib/elasticsearch && cd /var/lib/elasticsearch && cd elasticsearch-8.2.3/ && echo "node.name: netology_test" >> config/elasticsearch.yml && echo "network.host: 127.0.0.1" >> config/elasticsearch.yml && echo "path.data: /var/lib/elasticsearch" >> config/elasticsearch.yml
 ---> Running in b7b4e4aab4ca
elasticsearch-8.2.3-linux-x86_64.tar.gz: OK
Removing intermediate container b7b4e4aab4ca
 ---> 46894cb2540e
Step 7/8 : USER elastic
 ---> Running in 616e497c41d1
Removing intermediate container 616e497c41d1
 ---> bccfc18f6fff
Step 8/8 : CMD /var/lib/elasticsearch/elasticsearch-8.2.3/bin/elasticsearch
 ---> Running in 650d2aeaf9b0
Removing intermediate container 650d2aeaf9b0
 ---> 264e08bc3173
Successfully built 264e08bc3173
Successfully tagged antonsergeev/devops-elasticsearch:8.2.3

````
---

- Cделайте push в ваш docker.io репозиторий

---
````bash
root@NETOLOGY:/opt/hw_6.5/elasticsearch# docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: antonsergeev
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
root@NETOLOGY:/opt/hw_6.5/elasticsearch# docker push  antonsergeev/devops-elasticsearch:8.2.3
The push refers to repository [docker.io/antonsergeev/devops-elasticsearch]
572da94b1eb3: Pushed
bc3028ccea9a: Pushed
507be81512a6: Pushed
174f56854903: Mounted from library/centos
8.2.3: digest: sha256:c9390d645b821c934313a1a58e2f1e2d69462b2bce694655ad02cf9f6e790856 size: 1162

````
---

- (Ссылка на docker.io)[https://hub.docker.com/repository/docker/antonsergeev/devops-elasticsearch]


---
````bash
root@NETOLOGY:/home/vagrant# docker run --rm -d --name elastic -p 9200:9200 antonsergeev/devops-elasticsearch:8.2.3                                                                                                                          270e17fadc47ec43ab3ab224883b204c3f3d639010ab854a4feef62394a040f8
root@NETOLOGY:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE                                     COMMAND                  CREATED         STATUS         PORTS                                                                                                                                          NAMES
270e17fadc47   antonsergeev/devops-elasticsearch:8.2.3   "/bin/sh -c /var/lib…"   7 seconds ago   Up 5 seconds   0.0.0.0:9200->9200/tcp, :                                                                                                   ::9200->9200/tcp   elastic

````
---

Смена пароля

---
````bash
root@NETOLOGY:/opt/hw_6.5/elasticsearch# docker exec -it elastic /var/lib/elasticsearch/elasticsearch-8.2.3/bin/elasticsearch-reset-password -u elastic
This tool will reset the password of the [elastic] user to an autogenerated value.
The password will be printed in the console.
Please confirm that you would like to continue [y/N]y


Password for the [elastic] user successfully reset.
New value: aEKWfuwYQO4t0V4x+Xcd

````
---

Проверка подключения

---
````bash
root@NETOLOGY:/home/vagrant# docker exec -it elastic  curl -ku elastic http://localhost:9200
Enter host password for user 'elastic':
{
  "name" : "netology_test",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "fXCgyWx6S_u_QRNsNIjuww",
  "version" : {
    "number" : "8.2.3",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "9905bfb62a3f0b044948376b4f607f70a8a151b4",
    "build_date" : "2022-06-08T22:21:36.455508792Z",
    "build_snapshot" : false,
    "lucene_version" : "9.1.0",
    "minimum_wire_compatibility_version" : "7.17.0",
    "minimum_index_compatibility_version" : "7.0.0"
  },
  "tagline" : "You Know, for Search"
}
root@NETOLOGY:/home/vagrant#

````
---

# Задача 2
- Ознакомьтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии с таблицей
````bash
|  Имя  | Количество реплик | Количество шард |
|-------|-------------------|-----------------|
| ind-1 |         0         |        1        |
| ind-2 |         1         |        2        |
| ind-3 |         2         |        4        |
````

- ind-1
---
````bash
root@NETOLOGY:/home/vagrant# docker exec -it elastic /bin/bash
[elastic@270e17fadc47 /]$ curl -ku elastic https://localhost:9200
Enter host password for user 'elastic':
curl: (35) SSL received a record that exceeded the maximum permissible length.
[elastic@270e17fadc47 /]$ curl -ku elastic -X PUT "http://localhost:9200/ind-1" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "index": {
>      "number_of_shards": 1,
>      "number_of_replicas": 0
>      }
>    }
>  }
> '
Enter host password for user 'elastic':

{"acknowledged":true,"shards_acknowledged":true,"index":"ind-1"}


````
---

- ind-2
---
````bash

[elastic@270e17fadc47 /]$  curl -ku elastic -X PUT "http://localhost:9200/ind-2" -H 'Content-Type: application/json' -d'
{
  "settings": {
   "index": {
     "number_of_shards": 2,
      "number_of_replicas": 1
    }
   }
}
'
Enter host password for user 'elastic':
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-2"}
````
---

- ind-3

---
````bash
[elastic@270e17fadc47 /]$ curl -ku elastic -X PUT "http://localhost:9200/ind-3" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>    "index": {
>      "number_of_shards": 4,
>       "number_of_replicas": 2
>      }
>   }
> }
> '
Enter host password for user 'elastic':
{"acknowledged":true,"shards_acknowledged":true,"index":"ind-3"}
````
---

- Получите список индексов и их статусов, используя API и приведите в ответе на задание.
---
````bash
[elastic@270e17fadc47 /]$ curl -ku elastic http://localhost:9200/_cat/indices
Enter host password for user 'elastic':
yellow open ind-3 t-8k4LE6Q-CHCWdNY9okCw 4 2 0 0 900b 900b
green  open ind-1 mV71d8yVQVK2hBuPnACTSg 1 0 0 0 225b 225b
yellow open ind-2 n02pG2Q8TfqsGYQbD9bBLw 2 1 0 0 450b 450b

````
---

- Получите состояние кластера elasticsearch, используя API

---
````bash
[elastic@270e17fadc47 /]$ curl -ku elastic http://localhost:9200/_cluster/health?pretty
Enter host password for user 'elastic':
{
  "cluster_name" : "elasticsearch",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 9,
  "active_shards" : 9,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 47.368421052631575
}
[elastic@270e17fadc47 /]$
````
---


- Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

---
````bash
"Yellow" индексы созданы с количеством реплик и шард больше имеющихся. Кластер в состоянии "yellow" потому, 
что количество unassigned_shards > 0.

````
---

- Удалите все индексы

---
````bash

[elastic@270e17fadc47 /]$ curl -ku elastic -X DELETE http://localhost:9200/ind-1
Enter host password for user 'elastic':
{"acknowledged":true}[elastic@270e17fadc47 /]$ curl -ku elastic -X DELETE http://localhost:9200/ind-2
Enter host password for user 'elastic':
{"acknowledged":true}[elastic@270e17fadc47 /]$
[elastic@270e17fadc47 /]$ curl -ku elastic -X DELETE http://localhost:9200/ind-3
Enter host password for user 'elastic':
{"acknowledged":true}[elastic@270e17fadc47 /]$

````
---

# Задача 3

- Создайте директорию {путь до корневой директории с elasticsearch в образе}/snapshots.

root@NETOLOGY:/opt/hw_6.5/elasticsearch# docker exec -it elastic mkdir /var/lib/elasticsearch/elasticsearch-8.2.3/snapshots
root@NETOLOGY:/home/vagrant# docker exec -it elastic bash

- Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.
Приведите в ответе запрос API и результат вызова API для создания репозитория.

---
````bash
[elastic@8be9e5a695b9 /]$ mkdir /var/lib/elasticsearch/elasticsearch-8.2.3/snapshots
root@vb-micrapc:/opt/elasticsearch# docker restart elastic
````
---

- Приведите в ответе запрос API и результат вызова API для создания репозитория.

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X PUT "http://localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
> {
>    "type": "fs",
>    "settings": {
>    "location": "/var/lib/elasticsearch/snapshots",
>    "compress": true
>    }
> }
> '
Enter host password for user 'elastic':
{
  "acknowledged" : true
}
[elastic@8be9e5a695b9 /]$

````
---

- Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.

Создание индекса test

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X PUT http://localhost:9200/test -H 'Content-Type: application/json' -d'
> {
>  "settings": {
>  "number_of_replicas": 0,
>  "number_of_shards": 1
>  }
> }
> '
Enter host password for user 'elastic':
{"acknowledged":true,"shards_acknowledged":true,"index":"test"}
````
---

Вывод списка индексов

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X GET 'http://localhost:9200/_cat/indices?v'
Enter host password for user 'elastic':
health status index uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test  I-CYkbeSQceCR7eb5Difxg   1   0          0            0       225b           225b
[elastic@8be9e5a695b9 /]$

````
---

Создайте snapshot состояния кластера elasticsearch

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X PUT http://localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true
Enter host password for user 'elastic':
{"snapshot":{"snapshot":"elasticsearch","uuid":"jgnNHlGvSZqr9vt8BKZBzQ","repository":"netology_backup","version_id":8020399,"version":"8.2.3","indices":[".security-7",".geoip_databases","test"],"data_streams":[],"include_global_state":true,"state":"SUCCESS","start_time":"2022-12-09T12:29:22.936Z","start_time_in_millis":1670588962936,"end_time":"2022-12-09T12:29:24.159Z","end_time_in_millis":1670588964159,"duration_in_millis":1223,"failures":[],"shards":{"total":3,"failed":0,"successful":3},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]},{"feature_name":"security","indices":[".security-7"]}]}}

````
---

Приведите в ответе список файлов в директории со snapshot-ами.

---
````bash
[elastic@8be9e5a695b9 /]$ ls -la /var/lib/elasticsearch/snapshots/
total 48
drwxr-xr-x 3 elastic elastic  4096 Dec  9 12:29 .
drwxr-xr-x 1 elastic elastic  4096 Dec  9 12:30 ..
-rw-r--r-- 1 elastic elastic  1098 Dec  9 12:29 index-0
-rw-r--r-- 1 elastic elastic     8 Dec  9 12:29 index.latest
drwxr-xr-x 5 elastic elastic  4096 Dec  9 12:29 indices
-rw-r--r-- 1 elastic elastic 18443 Dec  9 12:29 meta-jgnNHlGvSZqr9vt8BKZBzQ.dat
-rw-r--r-- 1 elastic elastic   391 Dec  9 12:29 snap-jgnNHlGvSZqr9vt8BKZBzQ.dat
[elastic@8be9e5a695b9 /]$

````
---

- Удалите индекс test и создайте индекс test-2. Приведите в ответе список индексов.

Удаление индекса test

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X DELETE 'http://localhost:9200/test?pretty'
Enter host password for user 'elastic':
{
  "acknowledged" : true
}
[elastic@8be9e5a695b9 /]$

````
---

Создание индекса test-2

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X PUT http://localhost:9200/test-2 -H 'Content-Type: application/json' -d' { "settings": { "number_of_replicas": 0, "number_of_shards": 1 } } '
Enter host password for user 'elastic':
{"acknowledged":true,"shards_acknowledged":true,"index":"test-2"}
[elastic@8be9e5a695b9 /]$

````
---

Вывод списка индексов

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X GET 'http://localhost:9200/_cat/indices?v'
Enter host password for user 'elastic':
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test-2 uv0dcCPjT16PxqpwmRjHUw   1   0          0            0       225b           225b
[elastic@8be9e5a695b9 /]$


````
---

Восстановите состояние кластера elasticsearch из snapshot, созданного ранее.

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X POST 'http://localhost:9200/test-2/_close?pretty'
Enter host password for user 'elastic':
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "indices" : {
    "test-2" : {
      "closed" : true
    }
  }
}
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X POST 'http://localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?wait_for_completion=true'
Enter host password for user 'elastic':
{"snapshot":{"snapshot":"elasticsearch","indices":["test"],"shards":{"total":1,"failed":0,"successful":1}}}
[elastic@8be9e5a695b9 /]$

````
---

Приведите в ответе запрос к API восстановления и итоговый список индексов

---
````bash
[elastic@8be9e5a695b9 /]$ curl -ku elastic -X GET 'http://localhost:9200/_cat/indices?v'
Enter host password for user 'elastic':
health status index  uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   test   lFUBcAIVQMOQbJBeLVMswQ   1   0          0            0       225b           225b
green  close  test-2 uv0dcCPjT16PxqpwmRjHUw   1   0
[elastic@8be9e5a695b9 /]$


````
---

