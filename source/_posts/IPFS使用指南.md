---
title: ipfs 使用指南
date: 2020-02-03 09:49:58
tags: ipfs
categories: work
---

ipfs (desktop) 使用指南

<!--more-->


# 概念


ipfs 是一个点对点的网络，它不需要腾讯的服务器，就可以让两个人沟通上。（更多请搜索p2p网络，bittorrent)

打开你手头的ipfs desktop， 你的电脑就是一个ipfs 节点。

接着，你可以在你的电脑（节点）上进行和众人的沟通

# 沟通方式

## 我的“电话号码”

每个人都有电话号码，每个人的电脑都有IP地址，于是在ipfs网络里面，你也有一个节点id。

利用节点id，你就可以知道自己的“电话号码”，把这个电话号码告诉别人吧。

## 给我打call

知道了 电话号码（也就是 节点id），我们就可以连接上了。

比如，我的ID是

	节点 ID	QmSoLnSGccFuZQJzRadHn95W2CrSFmZuTdDWP8HXaHca9z

你通过命令行，可以：（注意，你的IPFS desktop 没有命令行，或许你让对方有命令行的那位主动call你，by：）

Search for a given peer on the network:

```sh
ipfs dht findpeer QmSoLnSGccFuZQJzRadHn95W2CrSFmZuTdDWP8HXaHca9z
```

上述命令，返回给你一个：

`/ip4/104.236.176.52/tcp/4001/ipfs/QmSoLnSGccFuZQJzRadHn95W2CrSFmZuTdDWP8HXaHca9z`

现在你就可以 把 这个 ip4 巴拉巴拉的东西，通过

`节点页面` 的 `添加链接` 按钮，填入框里，就能连接上对方了。

## 连接上之后，访问彼此的数据

社会里，人和人的连接是为了交换信息

我们的网络里也是如此。

每个文件（你想传递的信息，消息，可以放在一个文件里）都有自己的ID，ipfs 称之为 cid：content id.

原理是hash 函数：

    cid = hash(yourFile);//hash 的结果比如： Qmbalabalabala

你告诉别人这个 `Qmbalabalabala` 的 `cid` （可以通过qq，反正qq他也不理解这个hash的意思，理解了我们也可以把他从我们的网络中踢出，以至于外人无法获得我们的沟通内容）通过某些方式告诉对方。

对方在 `文件界面` 的 `添加` 按钮可以添加上述文件到他的节点（电脑）。具体来说，是选择：

```
文件
文件夹
来自 IPFS
新建文件夹

```

选项中的 `来自 IPFS`

填入 `cid` 即可。


