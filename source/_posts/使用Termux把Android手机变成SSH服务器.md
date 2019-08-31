---
title: 使用Termux把Android手机变成SSH服务器
date: 2019-08-25 17:22:02
tags: ssh
categories: tech
---

<img src="/img/sshToPhone.jpg">

使用Termux把Android手机变成SSH服务器

<!--more-->


## ref

http://blog.lujun9972.win/blog/2018/01/24/%E4%BD%BF%E7%94%A8termux%E6%8A%8Aandroid%E6%89%8B%E6%9C%BA%E5%8F%98%E6%88%90ssh%E6%9C%8D%E5%8A%A1%E5%99%A8/

## 安装sshd

打开 Termux 会出现一个类似Linux终端的界面。

由于sshd是包含在openssh包中的，因此我们首先需要在Termux中安装openssh

pkg install openssh
安装好之后，我们需要手工启动 sshd

    sshd

需要指出的是, sshd 监听的是8022端口而不是22号端口，因此可以使用下面命令来验证ssh服务是否开启

ssh localhost -p 8022

若要查看sshd的日志，则可以在Termux上执行

logcat -s 'syslog:*' 

## 添加Public key


Termux的sshd只能通过密钥登陆，因此你需要在linux客户机上生成密钥对

ssh-keygen
把linux客户机上的公钥加到Termux中的 .ssh/authorized_keys,这一步比较麻烦

因为你无法使用 ssh-copy-id,只能先把 id_rsa.pub 拷贝到手机上，再在手机上打开该文件，拷贝文件内容后在Termux中用 vi 打开 authorized_keys,并复制内容进去.

不过如果linux客户机上本身也开启了ssh服务的话，则会简单很多，可以在Termux上执行

	ssh user@linux_clinet "cat ~/.ssh/id_rsa.pub" >> ~/.ssh/authorized_keys

就行了，其中linux_clinet为linux客户机的地址，user为登陆用户

## 客户端登陆

在客户端上执行

ssh 192.4.4.9 -p 8022
将这里的 192.4.4.9 修改为手机的ip，就能登陆到Termux中了。

手机ip可以通过在 Termux 中运行 ifconfig -a 来查看。

需要说明的是，使用ssh登陆Termux时无需带上用户名，因为Termux是单用户系统。即使你登陆时带上了用户名，Termux也会忽略该用户名

为了方便，我们可以配置一下ssh client的配置文件,将下面内容加入到 ~/.ssh/config 文件中

Host termux
     HostName 192.4.4.9
     Port 8022


这样只需要执行 ssh termux 就能登陆termx了。

## 展示

<img src="/img/sshToPhone.jpg">