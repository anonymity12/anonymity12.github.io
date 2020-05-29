---
title: tech-learn-blockchain
date: 2020-05-25 13:47:19
tags: blockchain
categories: work
---

说人话，说区块链


<!--more-->

# 分布式共识

BFT == Byzantine Fault Tolerance ；；拜占庭容错算法 拜占庭将军问题（Byzantine Generals Problem）；

这个问题是说，几个人如何交换到正确的信息，因为这些人之间使用了送信的人，这个送信的半路可能死了，可能传假消息。总之，得让大家同意某一个决策，观点，让大家达到一个一致的状态。 这件事情，就叫个术语：分布式共识

- 参考： https://www.jianshu.com/p/5d10cf62d942

> 基于BFT的PoS的典型例子是tendermint（Cosmos采用了tendermint作为共识核心）。

这句话是说，权益证明基于 了这个拜占庭容错算法

## 我们就说说 tendermint

参考了：https://blog.csdn.net/simple_the_best/article/details/77198837

上文引出了 原文： https://docs.tendermint.com/master/

### 粗浅地总结一下 什么是 tendermint

参考了： https://docs.tendermint.com/master/introduction/what-is-tendermint.html

翻译： https://blog.csdn.net/simple_the_best/article/details/76785314


我的理解是：现在btc 和以太坊 都是不错的 拜占庭容错 问题的，良好的解决方案，tendermint 也是一个不错的选择，他能允许 1/3 的机器做任何坏行为：中毒，变坏，掉线，欺骗， 而其他的2/3 还能保持一致性的状态。

tendermint 有两个 核心的技术组件： 1）区块链合约引擎 2） 通用的应用程序接口

![输入图片说明](https://images.gitee.com/uploads/images/2020/0525/142230_bf73c552_1867476.png "986DB594-7454-4F7A-B4DD-4460273E2037.png")


# 分布式系统

参考了： https://www.cnblogs.com/xybaby/p/7787034.html


- 利用更多的机器，处理更多的数据。
- 分布式系统分为分布式计算（computation）与分布式存储（storage）。计算与存储是相辅相成的，计算需要数据，要么来自实时数据（流数据），要么来自存储的数据；而计算的结果也是需要存储的。
- 在操作系统中，对计算与存储有非常详尽的讨论，分布式系统只不过将这些理论推广到多个节点罢了。
- mapReduce 是google 做的分布式计算的实现
- partition 是分布式存储的一个想法

这片文章，引出了英文book： http://book.mixu.net/distsys/
