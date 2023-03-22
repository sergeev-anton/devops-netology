
## Домашнее задание к занятию 3 "Работа с Yandex Cloud".

### - Подготовка к выполнению

Подготовьте в Yandex Cloud три хоста: для clickhouse, для vector и для lighthouse.

---
````bash
root@NETOLOGY:/opt/hw_8.3/playbook/terraform# terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.ip will be created
  + resource "local_file" "ip" {
      + content              = (known after apply)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "../group_vars/all/ip.yml"
      + id                   = (known after apply)
    }


Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node02_yandex_cloud = "158.160.62.128"
external_ip_address_node03_yandex_cloud = "158.160.32.198"
internal_ip_address_node01_yandex_cloud = "158.160.41.72"

````
---

Созданны виртуальные машины

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/CI_MNT/HW_8.3/img/8-3_1.jpg)

### - Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает lighthouse.
2. При создании tasks рекомендую использовать модули: get_url, template, yum, apt.
3. Tasks должны: скачать статику lighthouse, установить nginx или любой другой webserver, настроить его конфиг для 
открытия lighthouse, запустить webserver.

[site.yml](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/CI_MNT/HW_8.3/playbook/site.yml)

4. Приготовьте свой собственный inventory файл prod.yml.
````bash
root@NETOLOGY:/opt/hw_8.3/playbook# cat inventory/prod.yml
---
    clickhouse:
      hosts:
        clickhouse-01:
          ansible_host: 158.160.41.72
          ansible_user: centos
    vector:
      hosts:
        vector-01:
          ansible_host: 158.160.62.128
          ansible_user: centos
    lighthouse:
      hosts:
        lighthouse-01:
          ansible_host: 158.160.32.198
          ansible_user: centos
root@NETOLOGY:/opt/hw_8.3/playbook#


````
5. Запустите ansible-lint site.yml и исправьте ошибки, если они есть.
````bash
root@NETOLOGY:/opt/hw_8.3/playbook# ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
root@NETOLOGY:/opt/hw_8.3/playbook#

````
6. Попробуйте запустить playbook на этом окружении с флагом --check.
````bash
root@NETOLOGY:/opt/hw_8.3/playbook# ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] *******************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] ***************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)

TASK [Get clickhouse common-static distrib] *************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] **********************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-client-22.3.3.44.rpm'                                                                                                                                                                                                         found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-client-22.3.3.44.rpm' found on system"]}

PLAY RECAP **********************************************************************************************************
clickhouse-01              : ok=3    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0


````
7. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.
````bash
root@NETOLOGY:/opt/hw_8.3/playbook# ansible-playbook -i inventory/prod.yml site.yml --diff


PLAY RECAP **********************************************************************************************************
clickhouse-01              : ok=9    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lighthouse-01              : ok=12   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
vector-01                  : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0




root@NETOLOGY:/opt/hw_8.3/playbook# ansible-playbook -i inventory/prod.yml site.yml

TASK [Show connect URL lighthouse] **********************************************************************************
ok: [lighthouse-01] => {
    "msg": "http://158.160.32.198/#http://158.160.41.72:8123/?user=netology"
}

PLAY RECAP **********************************************************************************************************
clickhouse-01              : ok=8    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
lighthouse-01              : ok=10   changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
vector-01                  : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


````
Страница lighthouse

![](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/CI_MNT/HW_8.3/img/8-3_2.jpg)
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть 
параметры и теги.

[README_PLAYBOOK.md](https://github.com/sergeev-anton/devops-netology/blob/main/Anton_HW/CI_MNT/HW_8.3/playbook/README_PLAYBOOK.md)

10. Готовый playbook выложите в свой репозиторий, поставьте тег 08-ansible-03-yandex на фиксирующий коммит, в ответ 
предоставьте ссылку на него.

[PLAYBOOK](https://github.com/sergeev-anton/devops-netology/tree/main/Anton_HW/CI_MNT/HW_8.3/playbook)

