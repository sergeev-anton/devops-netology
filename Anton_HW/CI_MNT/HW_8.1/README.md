1.Попробуйте запустить playbook на окружении из test.yml, зафиксируйте какое значение имеет факт some_fact 
для указанного хоста при выполнении playbook'a.
---
````bash
root@NETOLOGY:/opt/pyton_3.11# ansible --version
ansible [core 2.13.7]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.8.10 (default, Nov 14 2022, 12:59:47) [GCC 9.4.0]
  jinja version = 3.1.2
  libyaml = True



root@NETOLOGY:/opt/HW_8.1/playbook# ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]

TASK [Print OS] ********************************************************************************************************
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@NETOLOGY:/opt/HW_8.1/playbook#

````
---
2.Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте
его на 'all default fact'.

---
````bash
root@NETOLOGY:/opt/HW_8.1/playbook# nano group_vars/all/examp.yml
root@NETOLOGY:/opt/HW_8.1/playbook# cat group_vars/all/examp.yml
---
  some_fact: all default fact
root@NETOLOGY:/opt/HW_8.1/playbook#

````
---
3.Воспользуйтесь подготовленным (используется docker) или создайте собственное окружение для проведения 
дальнейших испытаний.
---
````bash
root@NETOLOGY:/opt/HW_8.1# nano docker-compose.yml
root@NETOLOGY:/opt/HW_8.1# cat docker-compose.yml
version: '3'
services:
  centos7:
    image: pycontribs/centos:7
    container_name: centos7
    restart: unless-stopped
    entrypoint: "sleep infinity"

  ubuntu:
    image: pycontribs/ubuntu
    container_name: ubuntu
    restart: unless-stopped
    entrypoint: "sleep infinity"
root@NETOLOGY:/opt/HW_8.1#




root@NETOLOGY:/opt/HW_8.1# docker-compose --version
docker-compose version 1.26.0, build d4451659
root@NETOLOGY:/opt/HW_8.1# docker-compose up -d
Creating network "hw_81_default" with the default driver
Pulling centos7 (pycontribs/centos:7)...
7: Pulling from pycontribs/centos
2d473b07cdd5: Already exists
43e1b1841fcc: Pull complete
85bf99ab446d: Pull complete
Digest: sha256:b3ce994016fd728998f8ebca21eb89bf4e88dbc01ec2603c04cc9c56ca964c69
Status: Downloaded newer image for pycontribs/centos:7
Pulling ubuntu (pycontribs/ubuntu:)...
latest: Pulling from pycontribs/ubuntu
423ae2b273f4: Pull complete
de83a2304fa1: Pull complete
f9a83bce3af0: Pull complete
b6b53be908de: Pull complete
7378af08dad3: Pull complete
Digest: sha256:dcb590e80d10d1b55bd3d00aadf32de8c413531d5cc4d72d0849d43f45cb7ec4
Status: Downloaded newer image for pycontribs/ubuntu:latest
Creating ubuntu  ... done
Creating centos7 ... done
root@NETOLOGY:/opt/HW_8.1#

root@NETOLOGY:/opt/HW_8.1#  docker-compose ps
 Name        Command       State   Ports
----------------------------------------
centos7   sleep infinity   Up
ubuntu    sleep infinity   Up
root@NETOLOGY:/opt/HW_8.1#

root@NETOLOGY:/opt/HW_8.1# docker ps -a
CONTAINER ID   IMAGE                 COMMAND            CREATED         STATUS         PORTS     NAMES
a9de7b6e3add   pycontribs/centos:7   "sleep infinity"   7 minutes ago   Up 7 minutes             centos7
7318dad1b3f9   pycontribs/ubuntu     "sleep infinity"   7 minutes ago   Up 7 minutes             ubuntu
root@NETOLOGY:/opt/HW_8.1#

````
---

4.Проведите запуск playbook на окружении из prod.yml. Зафиксируйте полученные значения some_fact для 
каждого из managed host.

---
````bash

root@NETOLOGY:/opt/HW_8.1/playbook# ansible-playbook -i inventory/prod.yml -v site.yml
Using /etc/ansible/ansible.cfg as config file

PLAY [Print os facts] ***********************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *****************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": 12
}

PLAY RECAP **********************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@NETOLOGY:/opt/HW_8.1/playbook#
````
---

5.Добавьте факты в group_vars каждой из групп хостов так, чтобы для some_fact получились следующие 
значения: для deb - 'deb default fact', для el - 'el default fact'.
---
````bash

root@NETOLOGY:/opt/HW_8.1/playbook# cat group_vars/deb/examp.yml
---
  some_fact: "deb default fact"
root@NETOLOGY:/opt/HW_8.1/playbook#

root@NETOLOGY:/opt/HW_8.1/playbook# cat group_vars/el/examp.yml
---
  some_fact: "el default fact"
````
---

6.Повторите запуск playbook на окружении prod.yml. Убедитесь, что выдаются корректные значения для всех хостов.

---
````bash
root@NETOLOGY:/opt/HW_8.1/playbook# ansible-playbook -i inventory/prod.yml -v site.yml
Using /etc/ansible/ansible.cfg as config file

PLAY [Print os facts] ***********************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *****************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP **********************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@NETOLOGY:/opt/HW_8.1/playbook#
````
---

7.При помощи ansible-vault зашифруйте факты в group_vars/deb и group_vars/el с паролем netology.

---
````bash

root@NETOLOGY:/opt/HW_8.1/playbook# ansible-vault encrypt group_vars/deb/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
root@NETOLOGY:/opt/HW_8.1/playbook# ansible-vault encrypt group_vars/el/examp.yml
New Vault password:
Confirm New Vault password:
Encryption successful
root@NETOLOGY:/opt/HW_8.1/playbook#

````
---

8.Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль.
Убедитесь в работоспособности.

---
````bash
root@NETOLOGY:/opt/HW_8.1/playbook# ansible-playbook -i inventory/prod.yml site.yml

PLAY [Print os facts] ***********************************************************************************************
ERROR! Attempting to decrypt but no vault secrets found
root@NETOLOGY:/opt/HW_8.1/playbook# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] ***********************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *****************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP **********************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@NETOLOGY:/opt/HW_8.1/playbook#

````
---

9.Посмотрите при помощи ansible-doc список плагинов для подключения. Выберите подходящий для работы на control node.


---
````bash

нужен "local"

````
---

10.В prod.yml добавьте новую группу хостов с именем local, в ней разместите localhost с необходимым типом подключения.

---
````bash
root@NETOLOGY:/opt/HW_8.1/playbook# nano inventory/prod.yml
root@NETOLOGY:/opt/HW_8.1/playbook# cat inventory/prod.yml
---
  el:
    hosts:
      centos7:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
root@NETOLOGY:/opt/HW_8.1/playbook#

````
---

11.Запустите playbook на окружении prod.yml. При запуске ansible должен запросить у вас пароль. Убедитесь что
факты some_fact для каждого из хостов определены из верных group_vars.

- Без создания отдельного group_vars для localhost some_fact получаем из all

---
````bash
root@NETOLOGY:/opt/HW_8.1/playbook# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] ********************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@NETOLOGY:/opt/HW_8.1/playbook#
````
---

- Создал отдельный group_vars для localhost

---
````bash
root@NETOLOGY:/opt/HW_8.1/playbook# mkdir group_vars/local
root@NETOLOGY:/opt/HW_8.1/playbook# nano group_vars/local/examp.yml
root@NETOLOGY:/opt/HW_8.1/playbook# cat group_vars/local/examp.yml
---
  some_fact: "local default fact"
root@NETOLOGY:/opt/HW_8.1/playbook# ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
Vault password:

PLAY [Print os facts] **************************************************************************************************

TASK [Gathering Facts] *************************************************************************************************
ok: [localhost]
ok: [centos7]
ok: [ubuntu]

TASK [Print OS] ********************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ******************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "local default fact"
}

PLAY RECAP *************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

root@NETOLOGY:/opt/HW_8.1/playbook#

````
---