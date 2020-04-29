---
title: shell_sort
date: 2019-10-26 07:27:22
tags: algorithm
categories: work
---

let me show you the shell sort algo, implements in C

<!--more-->

# Ref

https://www.cnblogs.com/skywang12345/p/3597597.html



# The implementation

Then I show you the shell sort algo, implements in C:

```

void shell_sort(int a[], int n){
	int i,j,gap;
	for (gap = n/2; gap > 0; gap /=2){
		for (i = 0; i < gap; i++) {
			for (j = i + gap; j < n; j += gap){
				// tt1 see below pic
				if (a[j - gap] > a[j]) {
					int tmp = a[j];
					int k = j - gap;
					// In this `while` loop
					// I will move all the bigger one
					// to the rear position, until 
					// the one is not bigger than our tmp
					// (tmp is a[j])
					while (k >= 0 && a[k] > tmp) {
						a[k + gap] = a[k];
						k -= gap;
					}
                    // then we move a[j] to this position
                    // which is suitable for a[j]
                    a[k + gap] = tmp;
				}
			}
		}
	}	
}

```

# pic for explain 

## tt1 

![shellSortExplain1.jpg](http://ww1.sinaimg.cn/mw690/005JrW9Kly1ge1oaszpi0j30mg0d2751.jpg)