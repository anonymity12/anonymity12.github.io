---
title: dijkstra 单源最短路径算法
date: 2019-10-31 17:27:22
tags: algorithm
categories: work
---

<img src="/img/Dijkstra.jpeg">

let me show you the dijkstra algo, implements in C

<!--more-->

# Ref

https://www.cnblogs.com/jason2003/p/7222182.html

# detail

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