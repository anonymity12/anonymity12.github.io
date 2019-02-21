---
title: API 分类，以及如何使用这些API
date: 2019-02-21 13:12:02
tags: p4
---

描述p4 生成的API， 以及如何使用她的API 写程序

<!--more-->

# runtime api

## gRPC 是 测试框架使用的，或许平常开发不需要使用RPC

gRPC 适用于测试情景，此时python客户端通过RPC 进行 与 BF Runtime API 的交互

# fix function api

## ref

D:\prjP4\SDE相关\寻找API\固定功能API介绍.pdf

## note

此部分的api 是固定功能，与程序无关的api， 比如端口管理的, 流量管理，多播，pkt gen 包生成

还有在 `bf-driver` 的 api ，他们是你control panel 不能用的，这些都是核心的底层功能：

1. 流水线的管理, 比如table 的操作，这些api 确实和你的p4 程序相关，但是他们并非是为了让你直接操作的。而是我们的PD 相关的api 调用这些api
2. LLD =  lower level driver


### 5. TM API 管理流量的api

三种流量类型

Switch.p4 List of Supported SAI API Attributes
===


CAP-UG23-001EA-SAI-d.pdf

仅仅是罗列了支持SAI 的一些h文件内容

![image](https://wx3.sinaimg.cn/large/005JrW9Kgy1g0e16jufo7j30p70htdi1.jpg)

bfSwitchAPI
===

使用C++ 语言的一个CRUD api 集合


## api 和 数据结构

所有的都包含 一个obj id 


```
typedef struct _switch_object_id_s {
	uint64_t data; // 低48 是obj 的index， 高16 是obj type
} switch_object_id_t;
```

## 使用c 和 c++  以及 py 实现的api 调用

