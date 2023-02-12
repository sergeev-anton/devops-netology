- Домашнее задание к занятию "2. Работа с Playbook"

- Подготовка к выполнению
1. (Необязательно) Изучите, что такое clickhouse и vector
2. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
3. Скачайте playbook из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

- Основная часть 

1. Приготовьте свой собственный inventory файл prod.yml.

---
````bash

root@NETOLOGY:/opt/hw_8.2/playbook# cat inventory/prod.yml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: docker

vector-01:
  hosts:
    vector-01:
     ansible_host: docker
root@NETOLOGY:/opt/HW_8.2/playbook#
root@NETOLOGY:/opt/hw_8.2/playbook# docker ps -a
CONTAINER ID   IMAGE                 COMMAND            CREATED         STATUS                  PORTS     NAMES
d9721b614f1e   pycontribs/centos:7   "sleep infinity"   2 minutes ago   Up 2 minutes                      clickhouse-01
a84f63233c66   pycontribs/ubuntu     "sleep infinity"   2 minutes ago   Up 2 minutes                      vector-01
root@NETOLOGY:/opt/hw_8.2/playbook#

````
---
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает vector.
3. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает vector.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите ansible-lint site.yml и исправьте ошибки, если они есть.

---
````bash 
root@NETOLOGY:/opt/hw_8.2/playbook# ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
WARNING  Listing 6 violation(s) that are fatal
yaml: wrong indentation: expected 8 but found 7 (indentation)
site.yml:41

risky-file-permissions: File permissions unset or incorrect
site.yml:53 Task/Handler: Create directrory for vector

yaml: truthy value should be one of [false, true] (truthy)
site.yml:58

yaml: wrong indentation: expected 12 but found 14 (indentation)
site.yml:60

yaml: too many spaces after colon (colons)
site.yml:62

yaml: wrong indentation: expected 12 but found 14 (indentation)
site.yml:67

You can skip specific rules or tags by adding them to your configuration file:
# .ansible-lint
warn_list:  # or 'skip_list' to silence them completely
  - experimental  # all rules tagged as experimental
  - yaml  # Violations reported by yamllint

Finished with 5 failure(s), 1 warning(s) on 1 files.
````
---

- после исправления ошибок 

---
````bash
root@NETOLOGY:/opt/hw_8.2/playbook# ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
root@NETOLOGY:/opt/hw_8.2/playbook#
````
---

6. Попробуйте запустить playbook на этом окружении с флагом --check.

---
````bash
root@NETOLOGY:/opt/hw_8.2/playbook# ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details
[WARNING]: Found both group and host with same name: vector-01

PLAY [Install Clickhouse] ***********************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *******************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] **************************************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP **************************************************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0

root@NETOLOGY:/opt/hw_8.2/playbook#

````
---

7. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.
---
````bash

root@NETOLOGY:/opt/hw_8.2/playbook# ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details
[WARNING]: Found both group and host with same name: vector-01

PLAY [Install Clickhouse] ***********************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *******************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] **************************************************************************************************************************
changed: [clickhouse-01]

TASK [Start clickhuose-server] ******************************************************************************************************************************
changed: [clickhouse-01]

TASK [Pause 10 sec] *****************************************************************************************************************************************
Pausing for 10 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
ok: [clickhouse-01]

TASK [Create database] **************************************************************************************************************************************
changed: [clickhouse-01]

RUNNING HANDLER [Start clickhouse service] ******************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] ***************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************
ok: [vector-01]

TASK [Create directrory for vector] *************************************************************************************************************************
--- before
+++ after
@@ -1,4 +1,4 @@
 {
     "path": "/opt/vector/0.23.3",
-    "state": "absent"
+    "state": "directory"
 }

changed: [vector-01]

TASK [Get distrib] ******************************************************************************************************************************************
changed: [vector-01]

TASK [Extract vector in the installation directory] *********************************************************************************************************
changed: [vector-01]

TASK [Copy vector servise file] *****************************************************************************************************************************
changed: [vector-01]

TASK [Copy vector *.servise files] **************************************************************************************************************************
changed: [vector-01]

TASK [Deploy config Vector] *********************************************************************************************************************************
--- before: /opt/vector/0.23.3/config/vector.toml
+++ after: /root/.ansible/tmp/ansible-local-5690mw3epkm4/tmpcdhxs08w/vector.j2
@@ -1,28 +1,8 @@
-#                                    __   __  __
-#                                    \ \ / / / /
-#                                     \ V / / /
-#                                      \_/  \/
-#
-#                                    V E C T O R
-#                                   Configuration
-#
-# ------------------------------------------------------------------------------
-# Website: https://vector.dev
-# Docs: https://vector.dev/docs
-# Chat: https://chat.vector.dev
-# ------------------------------------------------------------------------------
-
-# Change this to use a non-default directory for Vector data storage:
-# data_dir = "/var/lib/vector"
-
-# Random Syslog-formatted logs
 [sources.dummy_logs]
 type = "demo_logs"
 format = "syslog"
 interval = 1

-# Parse Syslog logs
-# See the Vector Remap Language reference for more info: https://vrl.dev
 [transforms.parse_logs]
 type = "remap"
 inputs = ["dummy_logs"]
@@ -30,15 +10,15 @@
 . = parse_syslog!(string!(.message))
 '''

-# Print parsed logs to stdout
 [sinks.print]
 type = "console"
 inputs = ["parse_logs"]
 encoding.codec = "json"

-# Vector's GraphQL API (disabled by default)
-# Uncomment to try it out with the `vector top` command or
-# in your browser at http://localhost:8686
-#[api]
-#enabled = true
-#address = "127.0.0.1:8686"
+[sinks.my_sink_id]
+type = "clickhouse"
+inputs = [ "parse_logs" ]
+database = "logs"
+endpoint = "http://localhost:8123"
+table = "logstable"
+compression = "gzip"

changed: [vector-01]

RUNNING HANDLER [Start vector service] **********************************************************************************************************************
changed: [vector-01]

PLAY RECAP **************************************************************************************************************************************************
clickhouse-01              : ok=7    changed=5    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=8    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@NETOLOGY:/opt/hw_8.2/playbook#


````
---

8. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.
---
````bash

root@NETOLOGY:/opt/hw_8.2/playbook# ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details
[WARNING]: Found both group and host with same name: vector-01

PLAY [Install Clickhouse] ***********************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *******************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] **************************************************************************************************************************
ok: [clickhouse-01]

TASK [Start clickhuose-server] ******************************************************************************************************************************
changed: [clickhouse-01]

TASK [Pause 10 sec] *****************************************************************************************************************************************
Pausing for 10 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
ok: [clickhouse-01]

TASK [Create database] **************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ***************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************
ok: [vector-01]

TASK [Create directrory for vector] *************************************************************************************************************************
ok: [vector-01]

TASK [Get distrib] ******************************************************************************************************************************************
ok: [vector-01]

TASK [Extract vector in the installation directory] *********************************************************************************************************
skipping: [vector-01]

TASK [Copy vector servise file] *****************************************************************************************************************************
ok: [vector-01]

TASK [Copy vector *.servise files] **************************************************************************************************************************
ok: [vector-01]

TASK [Deploy config Vector] *********************************************************************************************************************************
ok: [vector-01]

PLAY RECAP **************************************************************************************************************************************************
clickhouse-01              : ok=6    changed=1    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=6    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

root@NETOLOGY:/opt/hw_8.2/playbook#


````
---

9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook,
какие у него есть параметры и теги.

---

[README_PLAYBOOK.md](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/CI_MNT/HW_8.2/playbook/README_PLAYBOOK.md)

---

10. Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-02-playbook на фиксирующий коммит, в ответ предоставьте ссылку на него.

---
[PLAYBOOK](https://github.com/sergeev-anton/devops-netology/tree/main/Anton_HW/CI_MNT/HW_8.2/playbook)

---
