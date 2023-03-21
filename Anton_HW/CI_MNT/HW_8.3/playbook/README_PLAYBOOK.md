- ### В playbook было дописано  

group_vars/vector/vars.yaml - параметры для установки сервиса Vector 
group_vars/lighthouse/vars.yaml - параметры для установки сервиса Lighthouse 
group_vars/clickhouse/vars.yaml - параметры для установки сервиса Clickhouse

inventory/prod.yaml - описание хостов для развертывания сервисов (получен автоматически при создании ВМ terraform)

- файлы конфигурации сервисов для последующего его развертывания
templates/vector.j2 
templates/clickhouse.config.j2 
templates/clickhouse.users.j2 
templates/lighthouse.j2 
templates/nginx.j2 
templates/vector.service.j2  файлы конфигурации сервисов для последующего его развертывания

В site.yml внесены следующие изменения:

- Добавлена task для развертывания vector, ее состав:

handlers "Start vector service" - старт сервиса 
name: Create directory for vector - создание директории установки ПО Vector (путь определен в vector/vars.yaml)
name: Get distrib - получение .rpm пакета ПО путем скачивания с официального ресурса
name: Install Vector packages - установка .rpm пакета
name: Deploy config Vector - копирование конфигурационного файла Vector

- Добавлена task установки деплоя Lighthouse, ее состав:

name: Start nginx service - старт сервиса (выполниться в конце)
name: Install Nginx - установка сервиса (необходим для работы lighthouse)
name: Create Nginx config - копирование конфигурационного файла
name: Create lighthouse directory - создание директории для lighthouse
name: Install lighthouse - установка сервиса
pre_tasks name: Install git - необходим для получения дистрибутива lighthouse
name: Copy lighthouse from git - получение дистрибутива lighthouse и копирование его в рабочую директорию
name: Create lighthouse config - копирование конфигурационного файла nginx необходимого для работы lighthouse
name: Show connect URL lighthouse - получение адреса подключения к lighthouse