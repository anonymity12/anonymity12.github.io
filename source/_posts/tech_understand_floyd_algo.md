---
title: floyd_algo我终于理解啦
date: 2019-11-09 20:44:38
tags: algo
categories: tech
---

todo 2020-04-29 19:48 你仍旧需要自己写个代码，才算理解了

![floyd_intro.jpg](http://ww1.sinaimg.cn/mw690/005JrW9Kly1ge1odmva7zj32801e0wky.jpg)

<!--more-->

path 矩阵 每次会被更新一下：

![floyd_path.jpg](http://ww1.sinaimg.cn/mw690/005JrW9Kly1ge1odu8ousj32801e0ags.jpg)


如果你要知道 1 到 0的最短路径经过了啥，那么上图的 printPath 函数可能就会输出：

    <1,3> <3,2> <2,0>
其核心算法如下：

![floyd_core.jpg](http://ww1.sinaimg.cn/mw690/005JrW9Kly1ge1oe29filj32801e00yr.jpg)

820 要求你会艹上图中的A 和 path 数组。


---

参考：

https://www.bilibili.com/video/av69308899?from=search&seid=17458840725710118669
