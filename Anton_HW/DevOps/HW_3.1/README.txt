1.Ресурсы по-умолчанию

CPU 2 ядра
RAM 1025 Mb
HDD 65 Gb
GPU 4 Mb VboxVGA
LAN

2.Как добавить оперативной памяти или ресурсов процессора виртуальной машине?

Для добавления ресурсов виртуальной машины необходимо перейти в настройки данной виртуальной машины (значок шестеренки). Например, в разделе "Система", во вкладке "Материнская плата", в пункте "Основная память" перетянуть
ползунок на необходимое значение, либо задать его вручную (цифрами) в специальном поле для ввода информации. Аналогично во вкладке "Процессор" можно добавить ЦП .

Средствами Vargant в конфигурационный файл Vagranfile добавить строчку

config.vm.provider "virtualbox" do |vb| vb.memory = "1024" vb.cpu = "2" end

, указав тем самым количество ресурсов, которое вы хотите выделить для виртуальной машины.


3.Какой переменной можно задать длину журнала history, и на какой строчке manual это описывается?

HISTFILESIZE - максимальное число строк в файле истории для сохранения, строка 1155
HISTSIZE - число команд для сохранения, строка 1178.

4.Что делает директива ignoreboth в bash?

ignoreboth это сокращение для 2х директив ignorespace and ignoredups, ignorespace - не сохранять команды начинающиеся с пробела, ignoredups - не сохранять команду, если такая уже имеется в истории.

5.В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?

{} - зарезервированные слова, список, в т. ч. список команд, используется в различных условных циклах, операторах или ограничивает тело функции. В командах выполняет подстановку элементов из списка. строка 343.

6.С учётом ответа на предыдущий вопрос, как создать однократным вызовом touch 100000 файлов? Получится ли аналогичным образом создать 300000? Если нет, то почему?

vagrant@vagrant:~$ touch {000001..100000}.txt

vagrant@vagrant:~$ touch {000001..300000}.txt
-bash: /usr/bin/touch: Argument list too long

Создание 30000 файлов не получиться так как слишком большой диапазон

7.В man bash поищите по /[[. Что делает конструкция [[ -d /tmp ]]

проверяет условие -d /tmp и возвращает ее статус (0 или 1), наличие катаолга /tmp в директории. Если каталог присутствует будут возвращена 1, если отсутствует 0
проверяет условие наличия каталога (true или false)

8.Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке

vagrant@vagrant:~$ mkdir /tmp/test
vagrant@vagrant:~$ cd /tmp/test
vagrant@vagrant:/tmp/test$ cp /bin/bash /tmp/test
vagrant@vagrant:/tmp/test$ ls bash
bash
vagrant@vagrant:/tmp/test$ type -a bash bash is /usr/bin/bash bash is /bin/bash
bash is /usr/bin/bash
bash is /bin/bash
bash is /usr/bin/bash
bash is /bin/bash
-bash: type: is: not found
/usr/bin/bash is /usr/bin/bash
bash is /usr/bin/bash
bash is /bin/bash
-bash: type: is: not found
/bin/bash is /bin/bash
vagrant@vagrant:/tmp/test$ PATH=/tmp/test/:$PATH
vagrant@vagrant:/tmp/test$ type -a bash bash is /tmp/test/bash bash is /usr/bin/bash bash is /bin/bash
bash is /tmp/test/bash
bash is /usr/bin/bash
bash is /bin/bash
bash is /tmp/test/bash
bash is /usr/bin/bash
bash is /bin/bash
-bash: type: is: not found
/tmp/test/bash is /tmp/test/bash
bash is /tmp/test/bash
bash is /usr/bin/bash
bash is /bin/bash
-bash: type: is: not found
/usr/bin/bash is /usr/bin/bash
bash is /tmp/test/bash
bash is /usr/bin/bash
bash is /bin/bash
-bash: type: is: not found
/bin/bash is /bin/bash

9. Чем отличается планирование команд с помощью batch и at?

at - запуск команды в указанное время
batch или его псевдоним at -b планирует задания и выполняет их в пакетной очереди, если позволяет уровень загрузки системы.
