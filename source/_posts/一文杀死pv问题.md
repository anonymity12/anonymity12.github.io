---
title: 一文杀死pv问题
date: 2019-11-10 16:11:52
tags: pv
categories: work
---

PV： 

1. 要用什么，P一下
2. 互斥夹紧
3. 提供什么，V一下

<!--more-->

>屁股当让是最先进入的。

>夹紧点不仅是为了舒服，还为了安全。

>用完P还要V，V是提供（三角区）

# basic code

```c
seamphore mutex = 1;
seamphore empty = n;
seamphore full = 0;

producer() {
    while(1) {
        // 生产一个蜜桃
        // 1. 要用什么，P一下
        P(empty);
        // 2. 互斥夹紧
        P(mutex);
        MiTao_Generate_By_niuniu();
        // 2. 夹紧的你可以放开了
        V(mutex);
        // 3. 提供什么，V一下
        V(full); 
    }
}
consumer() {
    while(1) {
        P(full);
        P(mutex);
        eat_MiTao_of_NIUNIU();
        V(mutex);
        V(empty);
    }
}

// follow is what 820 exam like you to write
main() {
    cobegin:
        producer();
        consumer();
}

```