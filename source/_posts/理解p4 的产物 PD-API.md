---
title: 理解p4 的产物 PD-API
date: 2019-02-16 13:12:02
tags: sde
---

描述p4 编译器 自动生成的 programe dependent API， 这属于 衔接RGOS 高级控制层 与 SAI 的架构中 最下方的一层

![image](https://wx4.sinaimg.cn/large/005JrW9Kgy1g0cwyo7822j30kt0mudlr.jpg)

<!--more-->

## 详细p4c探究生成了什么

### 自动生成的API

见 `pd.h` , 位置在 build 下，你工程文件夹内的pd文件夹内：

/root/bf-sde-8.2.0/build/customer/myporg/tofino/myprog/pd


![image](https://wx4.sinaimg.cn/large/005JrW9Kgy1g0cx3wpz1vj31470gbn11.jpg)

那同层级的src 目录对应的是h 文件的c 实现

![image](https://wx3.sinaimg.cn/large/005JrW9Kgy1g0cxhuc8dyj315o0kpn01.jpg)

### 结构关系

![image](https://wx4.sinaimg.cn/large/005JrW9Kgy1g0cxw1ohtvj30dz03wt8k.jpg)


## 如何要像bfshell 那样和数据层面沟通，CRUD表项

那么要立即bfshell 如何加载的如下文件（以myprog 为例）

![image](https://wx1.sinaimg.cn/large/005JrW9Kgy1g0cymj7of2j30ad0b9749.jpg)