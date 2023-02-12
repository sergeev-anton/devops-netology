- Описание playbook

vector/vars.yaml - параметры для установки сервиса Vector

inventory/prod.yaml - добавлено описание хоста для деплоя Vector

templates/vector.j2 - добавлен файл концигурации сервиса для последующего его деплоя в conf файл Vector-а

В site.yml внесены изменения:

Добавлена task для деплоя vector, ее состав:
1. **handlers "Start vector service"** - старт сервиса (выполниться в конце)
2. **name: Create directrory for vector** - создание директории установки ПО Vector (путь определен в vector/vars.yaml)
3. **name: Get distrib** - получение архива с ПО путем скачивания с официального ресурса
4. **name: Extract vector in the installation directory** - распоковка по указанному пути
5. **name: Copy vector servise file и name: Copy vector *.servise files** - копирование файлов сервиса, согласно инструкции
с официального [сайта](https://vector.dev/docs/setup/installation/manual/from-archives/#windows-x86_64)
6. **name**: Deploy config Vector - деплой конфигурационного файла