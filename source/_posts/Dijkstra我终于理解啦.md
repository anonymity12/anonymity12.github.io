---
title: Dijkstra我终于理解啦
date: 2019-11-10 09:47:30
tags: algo
categories: work
---

<img src="/img/Dijkstra.jpg">

单源最短路径：解决单一个源点到某个点的（任意点的）最短的路径的问题 


<!--more-->

# ref

https://www.cnblogs.com/biyeymyhjob/archive/2012/07/31/2615833.html

# note

## 一图胜千言，动图胜万言：

<img src="https://pic002.cnblogs.com/images/2012/426620/2012073019540660.gif">

## 算法步骤：

a.初始时，S只包含源点，即S＝{v}，v的距离为0。U包含除v外的其他顶点，即:U={其余顶点}，若v与U中顶点u有边，则<u,v>正常有权值，若u不是v的出边邻接点，则<u,v>权值为∞。

b.从U中选取一个距离v最小的顶点k，把k，加入S中（该选定的距离就是v到k的最短路径长度）。

c.以k为新考虑的中间点，修改U中各顶点的距离；若从源点v到顶点u的距离（经过顶点k）比原来距离（不经过顶点k）短，则修改顶点u的距离值，修改后的距离值的顶点k的距离加上边上的权。

d.重复步骤b和c直到所有顶点都包含在S中。

## 算法代码实现(需要多多阅读）：

```c
const int  MAXINT = 32767;
const int MAXNUM = 10;
int dist[MAXNUM];
int prev[MAXNUM];

int A[MAXUNM][MAXNUM];

void Dijkstra(int v0)
{
  　　bool S[MAXNUM];                                  // 判断是否已存入该点到S集合中
      int n=MAXNUM;
  　　for(int i=1; i<=n; ++i)
 　　 {
      　　dist[i] = A[v0][i];
      　　S[i] = false;                                // 初始都未用过该点
      　　if(dist[i] == MAXINT)    
            　　prev[i] = -1;
 　　     else 
            　　prev[i] = v0;
   　　}
   　 dist[v0] = 0;
   　 S[v0] = true; 　　
 　　 for(int i=2; i<=n; i++)
 　　 {
       　　int mindist = MAXINT;
       　　int u = v0; 　　                            // 找出当前未使用的点j的dist[j]最小值
      　　 for(int j=1; j<=n; ++j)
      　　    if((!S[j]) && dist[j]<mindist)
      　　    {
         　　       u = j;                             // u保存当前邻接点中距离最小的点的号码 
         　 　      mindist = dist[j];
       　　   }
       　　S[u] = true; 
       　　for(int j=1; j<=n; j++)
       　　    if((!S[j]) && A[u][j]<MAXINT)
       　　    {
           　    　if(dist[u] + A[u][j] < dist[j])     //在通过新加入的u点路径找到离v0点更短的路径  
           　    　{
                   　　dist[j] = dist[u] + A[u][j];    //更新dist 
                   　　prev[j] = u;                    //记录前驱顶点 
            　　    }
        　    　}
   　　}
}

```

## 啊哈磊 的代码：

更容易理解的

https://blog.csdn.net/ahalei/article/details/22717661

```c
#include <stdio.h>
int main()
{
    int e[10][10],dis[10],book[10],i,j,n,m,t1,t2,t3,u,v,min;
    int inf=99999999; //用inf(infinity的缩写)存储一个我们认为的正无穷值
    //读入n和m，n表示顶点个数，m表示边的条数
    scanf("%d %d",&n,&m);
                                                           
    //初始化
    for(i=1;i<=n;i++)
        for(j=1;j<=n;j++)
            if(i==j) e[i][j]=0;
              else e[i][j]=inf;
                                                                     
    //读入边
    for(i=1;i<=m;i++)
    {
        scanf("%d %d %d",&t1,&t2,&t3);
        e[t1][t2]=t3;
    }
    //初始化dis数组，这里是1号顶点到其余各个顶点的初始路程
    for(i=1;i<=n;i++)
        dis[i]=e[1][i];
    //book数组初始化
    for(i=1;i<=n;i++)
        book[i]=0;
    book[1]=1;
                                                           
    //Dijkstra算法核心语句
    for(i=1;i<=n-1;i++)
    {
        //找到离1号顶点最近的顶点
        min=inf;
        // 第一个loop ： 从“可以接触到的区域 tt1”，找到离感染区最近的一个未感染的细胞
        for(j=1;j<=n;j++)
        {
            if(book[j]==0 && dis[j]<min)
            {
                min=dis[j];
                u=j;// u 是标记的这次loop 找到最近的细胞
            }
        }
        book[u]=1;// 细胞u已经被感染
        // 第二个loop：从这个找到的受害者细胞出发，看看有什么细胞我们还能接触到
        // aka：构成了新的：更大的：“可以接触到的区域 tt1”
        for(v=1;v<=n;v++)
        {
            if(e[u][v]<inf)
            {
                if(dis[v]>dis[u]+e[u][v])
                    dis[v]=dis[u]+e[u][v];
            }
        }
    }
                                                           
    //输出最终的结果
    for(i=1;i<=n;i++)
        printf("%d ",dis[i]);
                                                               
    getchar();
    getchar();
    return 0;
}
```

## 最后的疑问：

和prim （最近细胞感染法）有何区别呢？

