Описание playbook
- 1
---
1.1
- установка clickhouse
- уствновка необходимых пакетов
 - clickhouse-common-static-{{ clickhouse_version }}.rpm 
 - clickhouse-client-{{ clickhouse_version }}.rpm
 - clickhouse-server-{{ clickhouse_version }}.rpm
- создание базы данных

1.2
- установка vector
- настройка 
1. **name: "Start vector service"** - старт сервиса (выполниться в конце)
2. **name: Create directrory for vector** - создание директории установки ПО Vector (путь определен в vector/vars.yaml)
3. **name: Get distrib** - получение архива с ПО путем скачивания с официального ресурса
4. **name: Extract vector in the installation directory** - распоковка по указанному пути
5. **name: Copy vector servise file и name: Copy vector .servise files** - копирование файлов сервиса, согласно 
    инструкции с официального [сайта](https://vector.dev/docs/setup/installation/manual/from-archives/#windows-x86_64)
6. **name: Deploy config Vector** - деплой конфигурационного файла
---
- 2

В group_vars задаем следующие параметры

1. clickhouse_version, vector_version - версии устанавливаемых приложений



templates/vector.j2 - добавлен файл концигурации сервиса для последующего его деплоя в conf файл Vector-а
