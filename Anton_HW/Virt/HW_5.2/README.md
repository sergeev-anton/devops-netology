1. Опишите своими словами основные преимущества применения на практике IaaC паттернов.
Какой из принципов IaaC является основополагающим?

---
```bash

 Основое преимущество IaaC паттернов заключается в автоматизации интеграции, доставки,непрерывном 
 развертывании ПО, снижаются трудозатраты на выполнение рутинных задач.
 
 Идемпотеентность или идентчность результата. При выполнении какой-либо операции получается один и тот же 
 результат. Ускорение рутинных действий и фокусировка на основных задачах.

```
---


2. Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
---
```bash
 Можно использовать в существующем ssh соединении, не требует дополнительного соединения и дополнительных действий 
 для настройки. 
 
 Я считаю, что оба метода имеют право на жизнь. Все будет зависить от конкретной конфигурации.  

```
---

3. Установить на личный компьютер:

-VirtualBox
-Vagrant
-Ansible

---
```bash
---
C:\Users\Anton.Shakhov>"C:\Program Files\Oracle\VirtualBox\vboxmanage.exe" --version
6.1.34r150636
---

---
PS C:\Users\Anton.Shakhov\vagrant_vm> vagrant --version
Vagrant 2.2.19
---

---
vagrant@ASSET-10510:~$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Nov 26 2021, 20:14:08) [GCC 9.3.0]
  
---

```
---