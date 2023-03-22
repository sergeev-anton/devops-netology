- ### В playbook было дописано :  
---
- group_vars/vector/vars.yaml - параметры для установки сервиса Vector 
- group_vars/lighthouse/vars.yaml - параметры для установки сервиса Lighthouse 
- group_vars/clickhouse/vars.yaml - параметры для установки сервиса Clickhouse
---

---
- inventory/prod.yaml - описание хостов для развертывания сервисов (получен автоматически при создании ВМ terraform)
---

- файлы конфигурации сервисов для последующего его развертывания:

---
- templates/vector.j2 
- templates/clickhouse.config.j2 
- templates/clickhouse.users.j2 
- templates/lighthouse.j2 
- templates/nginx.j2 
- templates/vector.service.j2  файлы конфигурации сервисов для последующего его развертывания
---

В site.yml внесены следующие изменения:

---
- Добавлена task для развертывания vector, ее состав:

1. handlers "Start vector service" - старт сервиса 
2. name: Create directory for vector - создание директории установки ПО Vector (путь определен в vector/vars.yaml)
3. name: Get distrib - получение .rpm пакета ПО путем скачивания с официального ресурса
4. name: Install Vector packages - установка .rpm пакета
5. name: Deploy config Vector - копирование конфигурационного файла Vector
---

---
- Добавлена task установки деплоя Lighthouse, ее состав:

1. name: Start nginx service - старт сервиса (выполниться в конце)
2. name: Install Nginx - установка сервиса (необходим для работы lighthouse)
3. name: Create Nginx config - копирование конфигурационного файла
4. name: Create lighthouse directory - создание директории для lighthouse
5. name: Install lighthouse - установка сервиса
6. pre_tasks name: Install git - необходим для получения дистрибутива lighthouse
7. name: Copy lighthouse from git - получение дистрибутива lighthouse и копирование его в рабочую директорию
8. name: Create lighthouse config - копирование конфигурационного файла nginx необходимого для работы lighthouse
9. name: Show connect URL lighthouse - получение адреса подключения к lighthouse
---