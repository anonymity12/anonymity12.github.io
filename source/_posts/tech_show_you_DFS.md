---
title: DFS核心代码
date: 2019-10-31 20:27:22
tags: algorithm
categories: work
---

![dfsExplain.jpg](http://ww1.sinaimg.cn/mw690/005JrW9Kly1ge1o309r7bj30a009gwer.jpg)

let me show you the dfs algo, implements in C

<!--more-->



## 递归实现
￼
```c
#include <iostream>
#define N 5
using namespace std;
int maze[N][N] = {
    { 0, 1, 1, 0, 0 },
    { 0, 0, 1, 0, 1 },
    { 0, 0, 1, 0, 0 },
    { 1, 1, 0, 0, 1 },
    { 0, 0, 1, 0, 0 }
};
int visited[N + 1] = { 0, };
void DFS(int start)
{
    visited[start] = 1;
    for (int i = 1; i <= N; i++)
    {
        if (!visited[i] && maze[start - 1][i - 1] == 1)
            DFS(i);
    }
    cout << start << " ";
}
int main()
{
    for (int i = 1; i <= N; i++)
    {
        if (visited[i] == 1)
            continue;
        DFS(i);
    }
    return 0;
}
```


## 非递归实现

如下，借助一个栈：
￼
```c
#include <iostream>
#include <stack>
#define N 5
using namespace std;
int maze[N][N] = {
    { 0, 1, 1, 0, 0 },
    { 0, 0, 1, 0, 1 },
    { 0, 0, 1, 0, 0 },
    { 1, 1, 0, 0, 1 },
    { 0, 0, 1, 0, 0 }
};
int visited[N + 1] = { 0, };
void DFS(int start)
{
    stack<int> s;
    s.push(start);
    visited[start] = 1;
    bool is_push = false;
    while (!s.empty())
    {
        is_push = false;
        int v = s.top();
        for (int i = 1; i <= N; i++)
        {
            if (maze[v - 1][i - 1] == 1 && !visited[i])
            {
                visited[i] = 1;
                s.push(i);
                is_push = true;
                break;
            }
        }
        if (!is_push)
        {
            cout << v << " ";
            s.pop();
        }

    }
}
int main()
{
    for (int i = 1; i <= N; i++)
    {
        if (visited[i] == 1)
            continue;
        DFS(i);
    }
    return 0;
}
```
有的DFS是先访问读取到的结点，等回溯时就不再输出该结点，也是可以的。算法和我上面的区别就是输出点的时机不同，思想还是一样的。DFS在环监测和拓扑排序中都有不错的应用。

