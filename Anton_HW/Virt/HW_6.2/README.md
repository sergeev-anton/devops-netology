# Задача 1
- Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

---
````bash
root@NETOLOGY:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
root@NETOLOGY:/home/vagrant#



CONTAINER ID   IMAGE         COMMAND    CREATED       STATUS                   PORTS     NAMES
68b9702c0b0e   hello-world   "/hello"   7 weeks ago   Exited (0) 7 weeks ago             zen_blackburn
root@NETOLOGY:/home/vagrant# docker pull postgres:12
12: Pulling from library/postgres
31b3f1ad4ce1: Pull complete
dc97844d0cd5: Pull complete
9ad9b1166fde: Pull complete
286c4682b24d: Pull complete
1d3679a4a1a1: Pull complete
5f2e6cdc8503: Pull complete
0f7dc70f54e8: Pull complete
a090c7442692: Pull complete
473f99b80402: Pull complete
8ca3fc2acaeb: Pull complete
f795e99c865c: Pull complete
071d381c05b0: Pull complete
04e6b9b9f224: Pull complete
Digest: sha256:523c1d06070af8bfc06d293d6d6a63837c463ab9e4a62478cc6fb6a37f4afb87
Status: Downloaded newer image for postgres:12
root@NETOLOGY:/home/vagrant# docker run --rm --name postgres -e POSTGRES_PASSWORD=111 -e POSTGRES_USER=test-admin-user -e POSTGRES_DB=test_db -d -p 5432:5432 -v /opt/docker/volumes/backup:/var/lib/postgresql/backup -v /opt/docker/volumes/data:/var/lib/postgresql/data postgres:12
2aaef4c4a1181a653a3336e7fb54da817426f527f850640807fa75abfec45a91
root@NETOLOGY:/home/vagrant# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                       NAMES
2aaef4c4a118   postgres:12   "docker-entrypoint.s…"   25 seconds ago   Up 24 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgres
root@NETOLOGY:/home/vagrant# docker exec -it postgres ls -l /var/lib/postgresql
total 8
drwxr-xr-x  2 root     root 4096 Sep 13 15:52 backup
drwx------ 19 postgres root 4096 Sep 13 16:37 data

root@NETOLOGY:/home/vagrant# psql --version
psql (PostgreSQL) 12.12 (Ubuntu 12.12-0ubuntu0.20.04.1)

````
---


# Задача 2
# В БД из задачи 1:

- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

---
````bash
 # подключаемся к БД

root@NETOLOGY:/home/vagrant# psql -h 127.0.0.1 -U test-admin-user -d postgres
Password for user test-admin-user:
psql (12.12 (Ubuntu 12.12-0ubuntu0.20.04.1))
Type "help" for help.

postgres=#

 # Список БД и пользователей в postgre


postgres=# \l+
                                                                               List of databases
   Name    |      Owner      | Encoding |  Collate   |   Ctype    |            Access privileges            |  Size   | Tablespace |                Description
-----------+-----------------+----------+------------+------------+-----------------------------------------+---------+------------+--------------------------------------------
 postgres  | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 |                                         | 7969 kB | pg_default | default administrative connection database
 template0 | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =c/"test-admin-user"                   +| 7825 kB | pg_default | unmodifiable empty database
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user" |         |            |
 template1 | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 | =c/"test-admin-user"                   +| 7825 kB | pg_default | default template for new databases
           |                 |          |            |            | "test-admin-user"=CTc/"test-admin-user" |         |            |
 test_db   | test-admin-user | UTF8     | en_US.utf8 | en_US.utf8 |                                         | 7825 kB | pg_default |
(4 rows)

postgres=# \connect test_db
You are now connected to database "test_db" as user "test-admin-user".

 # в БД test_db создаем таблицу orders и clients

test_db=# create table orders (id serial primary key, Наименование text, Цена integer);
CREATE TABLE
test_db=# create table clients (id serial primary key, ФИО text, "Страна проживания" text, Заказ integer, foreign key (Заказ) references orders (id));
CREATE TABLE
test_db=# \dt
             List of relations
 Schema |  Name   | Type  |      Owner
--------+---------+-------+-----------------
 public | clients | table | test-admin-user
 public | orders  | table | test-admin-user
(2 rows)

test_db=# \d+ orders
                                                   Table "public.orders"
    Column    |  Type   | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------------+---------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer |           | not null | nextval('orders_id_seq'::regclass) | plain    |              |
 Наименование | text    |           |          |                                    | extended |              |
 Цена         | integer |           |          |                                    | plain    |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "clients_Заказ_fkey" FOREIGN KEY ("Заказ") REFERENCES orders(id)
Access method: heap

test_db=# \d+ clients
                                                      Table "public.clients"
      Column       |  Type   | Collation | Nullable |               Default               | Storage  | Stats target | Description
-------------------+---------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer |           | not null | nextval('clients_id_seq'::regclass) | plain    |              |
 ФИО               | text    |           |          |                                     | extended |              |
 Страна проживания | text    |           |          |                                     | extended |              |
 Заказ             | integer |           |          |                                     | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "clients_Заказ_fkey" FOREIGN KEY ("Заказ") REFERENCES orders(id)
Access method: heap

test_db=#

 # Предоставляем все привелегии на все операции пользователю test-admin-user на таблицы БД test_db

test_db=# \dgS+ test-admin-user
                                             List of roles
    Role name    |                         Attributes                         | Member of | Description
-----------------+------------------------------------------------------------+-----------+-------------
 test-admin-user | Superuser, Create role, Create DB, Replication, Bypass RLS | {}        |

test_db=#

 # Создаем пользователя test-simple-user и предоставляем ему права на таблицу SELECT/INSERT/UPDATE/DELETE

test_db=# \dgS+ test-admin-user
                                             List of roles
    Role name    |                         Attributes                         | Member of | Description
-----------------+------------------------------------------------------------+-----------+-------------
 test-admin-user | Superuser, Create role, Create DB, Replication, Bypass RLS | {}        |

test_db=# CREATE USER "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
CREATE ROLE
test_db=# \dgS+ test*
                                              List of roles
    Role name     |                         Attributes                         | Member of | Description
------------------+------------------------------------------------------------+-----------+-------------
 test-admin-user  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}        |
 test-simple-user | No inheritance                                             | {}        |

test_db=#
test_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
GRANT
test_db=# select * from information_schema.table_privileges where grantee='test-simple-user';
     grantor     |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
-----------------+------------------+---------------+--------------+------------+----------------+--------------+----------------
 test-admin-user | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 test-admin-user | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 test-admin-user | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 test-admin-user | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
(8 rows)

test_db=# select * from information_schema.table_privileges where grantee='test-admin-user' LiMIT 14;
     grantor     |     grantee     | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy
-----------------+-----------------+---------------+--------------+------------+----------------+--------------+----------------
 test-admin-user | test-admin-user | test_db       | public       | orders     | INSERT         | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | orders     | SELECT         | YES          | YES
 test-admin-user | test-admin-user | test_db       | public       | orders     | UPDATE         | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | orders     | DELETE         | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | orders     | TRUNCATE       | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | orders     | REFERENCES     | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | orders     | TRIGGER        | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | clients    | INSERT         | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | clients    | SELECT         | YES          | YES
 test-admin-user | test-admin-user | test_db       | public       | clients    | UPDATE         | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | clients    | DELETE         | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | clients    | TRUNCATE       | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | clients    | REFERENCES     | YES          | NO
 test-admin-user | test-admin-user | test_db       | public       | clients    | TRIGGER        | YES          | NO
(14 rows)

test_db=#

````
---

# Задача 3
- Используя SQL синтаксис - наполните таблицы следующими тестовыми данными

---
````bash
test_db=# insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5
test_db=# select * from orders;
 id | Наименование | Цена
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
(5 rows)

test_db=# insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
test_db=# select * from clients;
 id |         ФИО          | Страна проживания | Заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |
  2 | Петров Петр Петрович | Canada            |
  3 | Иоганн Себастьян Бах | Japan             |
  4 | Ронни Джеймс Дио     | Russia            |
  5 | Ritchie Blackmore    | Russia            |
(5 rows)

````
---

# Задача 4
- Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.
---
````bash

test_db=# update  clients set Заказ = 3 where id = 1;
UPDATE 1
test_db=# update  clients set Заказ = 4 where id = 2;
UPDATE 1
test_db=# update  clients set Заказ = 5 where id = 3;
UPDATE 1
test_db=# select * from clients;
 id |         ФИО          | Страна проживания | Заказ
----+----------------------+-------------------+-------
  4 | Ронни Джеймс Дио     | Russia            |
  5 | Ritchie Blackmore    | Russia            |
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(5 rows)

````
---

# Задача 5

- Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).

- Приведите получившийся результат и объясните что значат полученные значения.

---
````bash
test_db=# explain select * from clients where Заказ is not null;
                        QUERY PLAN
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: ("Заказ" IS NOT NULL)
(2 rows)

 - Seq Scan — последовательное, блок за блоком, чтение данных таблицы clients.
 - cost - Это некое понятие, призванное оценить затратность операции. 
          Первое значение 0.00 — затраты на получение первой строки.
          Второе 18.10 — затраты на получение всех строк.
 - rows — приблизительное количество возвращаемых строк при выполнении операции Seq Scan.
 - width — средний размер одной строки в байтах.

````
---

# Задача 6
- Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

- Остановите контейнер с PostgreSQL (но не удаляйте volumes).

- Поднимите новый пустой контейнер с PostgreSQL.

- Восстановите БД test_db в новом контейнере.

- Приведите список операций, который вы применяли для бэкапа данных и восстановления.

---
````bash 
# Создаём бэкап БД

root@NETOLOGY:~# docker exec -t postgres pg_dump -U test-admin-user test_db -f /var/lib/postgresql/backup/dump_test.sql
root@NETOLOGY:~# docker exec -t postgres ls -l /var/lib/postgresql/backup/
total 8
-rw-r--r-- 1 root root 4330 Sep 13 18:11 dump_test.sql
root@NETOLOGY:~#

# Проверяем, отработала ли синхронизация подмонтированной папки на хостовой машине

root@NETOLOGY:~# ls -l /opt/docker/volumes/backup/
total 8
-rw-r--r-- 1 root root 4330 Sep 13 18:11 dump_test.sql

# Останавливаем первый контейнер

root@NETOLOGY:~# docker stop postgres
postgres

# Запускаем второй контейнер

root@NETOLOGY:~# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                       NAMES
90fc70b453fb   postgres:12   "docker-entrypoint.s…"   28 seconds ago   Up 27 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgres_backup


root@NETOLOGY:~# psql -h 127.0.0.1 -U test-admin-user -d test_db
Password for user test-admin-user:
psql (12.12 (Ubuntu 12.12-0ubuntu0.20.04.1))
Type "help" for help.

test_db=# \dt
Did not find any relations.
test_db=# \d+
Did not find any relations.
test_db=#

# записи отсутствуют



root@NETOLOGY:~# docker exec -i postgres_backup psql -U test-admin-user -d test_db -f /var/lib/postgresql/backup/dump_test.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
ALTER TABLE
COPY 5
COPY 5
 setval
--------
      1
(1 row)

 setval
--------
      1
(1 row)

````
---
