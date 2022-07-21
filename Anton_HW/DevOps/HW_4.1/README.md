Задача 1.
Есть скрипт:

a=1
b=2
c=a+b
d=$a+$b
e=$(($a+$b))
Какие значения переменным c,d,e будут присвоены? Почему?
---

| Переменная | Значение |                                                             Обоснование                                                              |
|:----------:|:--------:|:------------------------------------------------------------------------------------------------------------------------------------:|
|     c      |  a + b   |                                              bash воспринимает это присвоение как текст                                              |
|     d      |  1 + 2   |                       bash воспринимает это присвоение как текст, подставив туда числовые значения переменнных                       | 
|     e      | 	3       | bash производит вычисления, подставляя значения в переменную. $(($a+$b)) стандартный конструктив для обертки математических операций |

---

Задача 2 

---
`````bash
-не написана строка ввода #!/bin/bash
-нет закрывающей скобки в конструктиве условия while, должно быть ((1==1))

-----

#!/bin/bash
while ((1==1))
do
        curl http://localhost:4346
        if (($? != 0))
        then
                date >> curl.log
        else
                break
        fi

done

`````
---

Задача 3 

---
````bash
echo "" > host.log
a=("192.168.0.1" "173.194.222.113" "87.250.250.242")
for i in ${a[@]}; do
  for j in {1..5}; do
    curl http://$i:80 -m 1
    if (($? != 0)); then
      echo "error " $i >>host.log
    else
      echo "OK " $i >>host.log
    fi
  done
done

-----
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
root@ASSET-10510:/home/vagrant# cat host.log

error  192.168.0.1
OK  192.168.0.1
OK  192.168.0.1
OK  192.168.0.1
OK  192.168.0.1
OK  173.194.222.113
OK  173.194.222.113
OK  173.194.222.113
OK  173.194.222.113
OK  173.194.222.113
OK  87.250.250.242
OK  87.250.250.242
OK  87.250.250.242
OK  87.250.250.242
OK  87.250.250.242
root@ASSET-10510:/home/vagrant#

````
---

Задача 4 

---
````bas

#!/bin/bash
echo "" > error.log
echo "" > up.log
a=("173.194.222.113" "87.250.250.242" "192.168.0.1")
while ((1 == 1)); do
 for i in ${a[@]}; do
    curl http://$i:80 -m 1
    if (($? != 0)); then
      echo "error " $i >>error.log
      break 2
    else
      echo "OK " $i >>up.log
    fi
 done
done

-------

var LanguageNow = "\x43\x68\x69\x6e\x65\x73\x65";
LanguageSwitch(LanguageNow);
});
});
});
window.onresize = function()
{
if ($("#tipLayer").css("display") != "none")
{
reposition_box("tipLayer");
consoleLog("window reseze!");
}
}
</script>
</body>
</html>
curl: (28) Operation timed out after 1002 milliseconds with 0 bytes received
root@ASSET-10510:/home/vagrant# cat up.log

OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
OK  173.194.222.113
OK  87.250.250.242
OK  192.168.0.1
root@ASSET-10510:/home/vagrant#

root@ASSET-10510:/home/vagrant# cat error.log

error  173.194.222.113
root@ASSET-10510:/home/vagrant#




````
---