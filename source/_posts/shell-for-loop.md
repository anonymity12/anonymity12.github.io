---
title: shell_for_loop
date: 2020-04-17 21:03:19
tags: shell
categories: tech
---

如何使用 shell 里面的 `for` 循环，代码示范

<!--more-->

# ref

https://www.cnblogs.com/EasonJim/p/8315939.html

# code

## 第一类：数字性循环

for1-1.sh

```sh
#!/bin/bash  
  
for((i=1;i<=10;i++));  
do   
echo $(expr $i \* 3 + 1);  
done  
```

for1-2.sh

```sh
#!/bin/bash  
  
for i in $(seq 1 10)  
do   
echo $(expr $i \* 3 + 1);  
done   
```

for1-3.sh

```sh
#!/bin/bash  
  
for i in {1..10}  
do  
echo $(expr $i \* 3 + 1);  
done  
```

## 第二类：字符性循环

for2-1.sh

```sh
#!/bin/bash  
  
for i in `ls`;  
do   
echo $i is file name\! ;  
done   
```

for2-2.sh

```sh
#!/bin/bash  
  
for i in $* ;  
do  
echo $i is input chart\! ;  
done  
```

for2-3.sh

```sh
#!/bin/bash  
  
for i in f1 f2 f3 ;  
do  
echo $i is appoint ;  
done  
```

for2-4.sh

```sh
#!/bin/bash  
  
list="rootfs usr data data2"  
for i in $list;  
do  
echo $i is appoint ;  
done  
```

## 第三类：路径查找

for3-1.sh

```sh
#!/bin/bash  
  
for file in /proc/*;  
do  
echo $file is file path \! ;  
done  
```

for3-2.sh

```sh
#!/bin/bash  
  
for file in $(ls *.sh)  
do  
echo $file is file path \! ;  
done  
```

总结：

现在一般都使用for in结构，for in结构后面可以使用函数来构造范围，比如$()、``这些，里面写一些查找的语法，比如ls test*，那么遍历之后就是输出文件名了。