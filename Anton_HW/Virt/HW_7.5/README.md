# Задача 1. Установите golang.

---
````bash
root@NETOLOGY:/opt# wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
--2022-10-19 17:34:21--  https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
Resolving go.dev (go.dev)... 216.239.38.21, 216.239.34.21, 216.239.32.21, ...
Connecting to go.dev (go.dev)|216.239.38.21|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://dl.google.com/go/go1.19.2.linux-amd64.tar.gz [following]
--2022-10-19 17:34:22--  https://dl.google.com/go/go1.19.2.linux-amd64.tar.gz
Resolving dl.google.com (dl.google.com)... 74.125.205.93, 74.125.205.190, 74.125.205.136, ...
Connecting to dl.google.com (dl.google.com)|74.125.205.93|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 148883574 (142M) [application/x-gzip]
Saving to: ‘go1.19.2.linux-amd64.tar.gz’

go1.19.2.linux-amd64.tar.gz                                 100%[========================================================================================================================================>] 141.99M  22.0MB/s    in 6.4s

2022-10-19 17:34:28 (22.3 MB/s) - ‘go1.19.2.linux-amd64.tar.gz’ saved [148883574/148883574]

root@NETOLOGY:/opt# rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz
root@NETOLOGY:/opt# export PATH=$PATH:/usr/local/go/bin
root@NETOLOGY:/opt# go version
go version go1.19.2 linux/amd64
root@NETOLOGY:/opt#

````
---

# Задача 3. Написание кода.

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные у пользователя,
а можно статически задать в коде. Для взаимодействия с пользователем можно использовать функцию Scanf:

---
````bash
package main

import "fmt"

func main() {
    fmt.Print("Enter a number: ")
    var input float64
    fmt.Scanf("%f", &input)

    output := input * 2

    fmt.Println(output)    
}


````
---

2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}

---
````bash
package main

import "fmt"
import "sort"

func GetMin (toSort []int)(minNum int) {
	sort.Ints(toSort)
	minNum = toSort[0]
	return
}

func main() {
	x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
	y := GetMin(x)
	fmt.Printf("Самое маленькое число из списка: %v\n", y)
}
````
---  

3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).

---
````bash
package main

import "fmt"

func FilterList ()(devidedWithNoReminder []int) {
	for i := 1;  i <= 100; i ++ {
		if	i % 3 == 0 { 
			devidedWithNoReminder = append(devidedWithNoReminder, i)
		}
	}	
	return
}

func main() {
	toPrint := FilterList()
	fmt.Printf("Числа от 1 до 100, которые делятся на 3: %v\n", toPrint)
}
````
---  