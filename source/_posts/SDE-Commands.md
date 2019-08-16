---
title: SDE命令集合
date: 2019-02-16 13:12:02
tags:
---

bf 的 SDE命令汇总

<!--more-->

[TOC]

# 故障性命令

## 网络连接

修改/etc/network/interfaces文件配置如下：
	
	$ vi /etc/network/interfaces
	auto ma1
	iface ma1 inet dhcp


配置完成后重启网络即可生效：
	
	$ /etc/init.d/networking restart


## 加载内核

内核模块驱动

bf_kdrv.ko是Tofino设备的标准内核模块驱动，通过以下命令加载bf_kdrv.ko


	cd $SDE
	sudo install/bin/bf_kdrv_mod_load $SDE_INSTALL



## 环境变量设置

	export SDE=`pwd`

	杨鹏飞(杨鹏飞) 20:07:21
	不安装翻不过强的依赖：
	sde环境
	. ./set_sde.bash
	./sde_build.sh -r -a -c --no-bmv2 --no-deps


## 进入switch 状态

	./run_switchd.sh -p switch

然后可以看到：

![image](https://ws2.sinaimg.cn/large/005JrW9Kgy1g0amze6wtqj30em099dfu.jpg)

使用？来进行命令提示

![image](https://wx1.sinaimg.cn/large/005JrW9Kgy1g0an0h9ue7j30f807jq2w.jpg)

使用ucli 进入bf-sde 层级

![image](https://ws1.sinaimg.cn/large/005JrW9Kgy1g0an1ocf8cj30dg04gjr7.jpg)

使用`pd-switch` 进入 和我们的p4程序相关的 cli界面

![image](https://wx4.sinaimg.cn/large/005JrW9Kgy1g0apnjtmohj30fs0endg3.jpg)

### port manage 的命令


	bf-sde.pm 


	o port-add <dev_id> <port_str> <speed (1G, 10G, ...)> <fec (NONE, FC, RS)>

	o port-del <dev_id> <port_str>

	o port-enb <dev_id> <port_str>

	o port-dis <dev_id> <port_str>

	o show <dev_id> [optional arguments]

	o link-poll-timer <dev_id> <0|1>

	o port-stats-timer <dev_id> <0|1>

	o an-set <dev_id> <port_str> <0|1|2>

	o link-dbn-timer <dev_id> <port_str> <debounce time in ms>

	o prbs-set <dev_id> <port_str> <prbs_speed (10G, 25G)> <prbs_mode (31, 23, 15, 13, 11, 9, 7)>

	o prbs-clnup <dev_id> <port_str>

## 常见错误：

Please load driver with bf_kdrv_mod_load script. Exiting.

### 方法：

参考：3.3内核模块驱动

	cd $SDE
	sudo install/bin/bf_kdrv_mod_load $SDE_INSTALL
