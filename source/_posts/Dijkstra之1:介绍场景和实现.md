---
title: Dijkstra之1:介绍场景和实现
date: 2019-10-31 17:27:22
tags: algo
categories: work
---

![Dijkstra.jpeg](http://ww1.sinaimg.cn/mw690/005JrW9Kly1ge1ocy4n74j30po0g3jyg.jpg)

let me show you the dijkstra algo, implements in C++

<!--more-->

# notes

## 什么时候，你会使用 dijkstra 算法呢

你有一个带权（每个边有距离值）有向图（带箭头的图），你想知道一个点（比如:a)到其余各个顶点(比如：b,c,i,j,k,x,y...)的最短距离，这个时候，你会使用dijkstra 算法；

## dijkstra 算法 的 思想

首先你安排一个集合：S， 这个S 里面包含已经求得最短路径的那些顶点(比如你已经知道了a 到 b,c,d的最短路径，那么此时，S里面就有 a,b,c,d);

你可以使用一个数组实现这个 集合; 当 `s[vi] = 1`， 就说明 vi 这个点在S集合内了。

你在一开始的时候，会把源点放在 这个 S集合里。比如我想知道点 `v0` 到其余各个点 `vx` 的距离，故此，我一开始，会设置 `s[v0] = 1`. 如果我们的v0 直接设置为s数组的第一个点，其实就会比较方便，于是初始时候，你得到s就如：

    s := [1, 0, 0, 0....//后面全是0]

### 辅助的两个数组

`dist[]`: 记录了源点v0 到其他各个顶点的当前的最短路径长度。

`path[]`: 记录了前驱节点；比如 `path[i] = j` 表示：源点v0 到 点vi ，其中vi 前面的一个点是：vj。事后，我们可以根据这个path 值来追溯最短路径。 

### 具体表述

1) 初始化：S集合；s数组里面就源点自己。 也初始化 `dist[]`，根据输入，来填入源点 到各个节点的距离，离得近（一步就到）的就填其对应的一步的距离，离得远的（输入中，没有给出的距离，比如源点到目标终点），就填写 int_max （-1也行，看个人选择）。

2）  **找跳板** 从全集V - 集合S 的集合：V-S 中选取vj 这个节点：满足了：dist[j] = min(dist[i]| vi属于V-S)(tt: 这里不懂)。（

我的理解是：从本轮更新最短距离的节点们中，选一个最小距离的：vj，vj会是下一轮更新其他vx 节点的跳板，而且是最合适的跳板，因为vj 路径距离最小）

3） **开始跳**： 修改从v0出发的，到V-S集合上的任意一个点(say:k)的距离，怎么该呢：如果

    dist[k] > dist[j] + arcs[j][k] 

则令：

    dist[k] = dist[j] + arcs[j][k] 

4) 重复2，3；重复n-1次，直到所有的节点 都被包含在S集合中（V-S集合于是就是空集了）

## 小tips

1.  dijkstra 是贪心的。
2.  双重循环
3.  时间复杂度：O(v^2);  v 是顶点数，不论是使用邻接表还是邻接矩阵都是这个复杂度。
4. 不适合含有 负权边 的图

# code in cpp

```c++
#include <iostream>
#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <cstdlib>
using namespace std;
int map[110][110];//这就是map数组，存储图
int dis[10010];//dis数组，存储估计值
int book[10010];//book[i]代表这个点有没有被当做源点去搜索过，1为有，0为没有。这样就不会重复搜索了。
int n,m;
void dijkstra(int u)//主函数，参数是源点编号
{
    memset(dis,88,sizeof(dis));//把dis数组附最大值（88不是十进制的88，其实很大）
    int start=u;//先从源点搜索
    book[start]=1;//标记源点已经搜索过
    for(int i=1;i<=n;i++)
    {
        dis[i]=min(dis[i],map[start][i]);//先更新一遍
    }
    for(int i=1;i<=n-1;i++)
    {
        //tt minn是用于记录一个最小值：哪个点到源点的距离最小呢？（在未访问过的点中找，aka：book[j] == 0;//这表示未被标记为已经访问过
        int minn=9999999;//谢评论区，改正一下：这里的minn不是题解上的minn，这代表的是最近点到源点的距离，start才代表最近的点、
        for(int j=1;j<=n;j++) {
            //book[j] == 0这表示未被标记为已经访问过
            if(book[j]==0 && minn>dis[j]){
                minn=dis[j];
                start=j;//找到离源点最近的点，然后把编号记录下来，用于搜索。
            }
        }
        // 标记这个点（j点），将是新的出发点（start），也就是记book下来：它已经被踩过了。
        book[start]=1;

        // tt 这里就是核心了，拿最近的，好使的点，更新到其他点的距离。
        for(int j=1;j<=n;j++)
            dis[j]=min(dis[j],dis[start]+map[start][j]);//以新的点来更新dis。
    }
}
int main()
{
    cin>>n>>m;
    memset(map,88,sizeof(map));
    for(int i=1;i<=m;i++)
    {
        int a,b,c;
        cin>>a>>b>>c;
        map[a][b]=c;
    }
    for(int i=1;i<=n;i++)
        for(int j=1;j<=n;j++)
            if(i==j)
                map[i][j]=0;
    dijkstra(1);//以1为源点。
    for(int i=1;i<=n;i++)
        cout<<dis[i]<<" ";
}
```


# Ref

https://www.cnblogs.com/jason2003/p/7222182.html