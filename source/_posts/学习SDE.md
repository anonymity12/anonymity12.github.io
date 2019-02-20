---
title: 学习SDE
date: 2019-02-16 13:12:02
tags: sde
---

描述SDE 和 OS 的关系，来明白我们如何 对接RGOS

<!--more-->

[TOC]


# 先说说什么是ONL


ONL 是专为网络交换机开发的系统，可以特别地支持 端口，LED， 风扇 这些特殊硬件


# 明确的问题是：SDE 在ONL 中的作用和行为特征

## ref

https://support.barefootnetworks.com/hc/en-us/categories/200358035-Barefoot-P4-Studio-SDE


## 什么是SDE 

software development environment  旨在在各种OS 上进行P4 的开发，生成BF芯片 需要的data panel 可执行的程序

当前我们在ONL （open network linux) 上搭建好了SDE

### SDE 中包含p4c

利用p4c 我们可以编译p4 程序

### 使用run_switchd.sh 可以开始载入编译好的p4 程序

`run_switchd.sh` 指定了配置文件 作为参数，此配置文件中，包含tofino 需要的bin


![image](https://ws1.sinaimg.cn/large/005JrW9Kgy1g0cqgb18p3j30pe0exgnf.jpg)

使用了`bf_switchd`， 这是 在 ` /root/bf-sde-8.2.0/install/bin` 中的一个可执行文件










