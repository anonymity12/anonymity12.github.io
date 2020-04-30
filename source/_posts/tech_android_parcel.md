---
title: android_os_parcel
date: 2020-03-27 18:26:43
tags: android 
categories: work
---

明白 android 里面的 parcel 概念

what, why, how

<!--more-->

# ref

How to do Android IPC with Parcelable and AIDLs.

https://www.vogella.com/tutorials/AndroidParcelable/article.html

# what is parcelable 

android 自己 用 parcelable  实现了 java 里面的  serializable, parcelable 能在Android 里面 速度比  serializable 更快。


#  why we use it

如果想要你的数据，能在几个组件之间能被解析，所以你要 实现 parcelable 接口


# how to use it


1) 首先你知道，我们需要在Android的几个组件之间传递数据，这是一个软件内部解藕的好方法。你将使用bundle 传递 数据。

2） 你把bundle 会放在 intent里面，你在另外一个 组件 里拿这个intent，然后从中取出bundle， 然后bundle 里面就是你自定义的对象数据。

## code 

```java
package com.vogella.android.autovalueparceable;

import android.os.Parcel;
import android.os.Parcelable;

public class Student implements Parcelable {

    public static final Parcelable.Creator CREATOR = new Parcelable.Creator() {
        public Student createFromParcel(Parcel in) {
            return new Student(in);
        }

        public Student[] newArray(int size) {
            return new Student[size];
        }
    };

    private long id;
    private String name;
    private String grade;

    // Constructor
    public Student(long id, String name, String grade){
        this.id = id;
        this.name = name;
        this.grade = grade;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    // Parcelling part
       public Student(Parcel in){
           this.id = in.readLong();
           this.name = in.readString();
           this.grade =  in.readString();
       }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
       public void writeToParcel(Parcel dest, int flags) {
        dest.writeLong(this.id);
        dest.writeString(this.name);
        dest.writeString(this.grade);
       }

    @Override
    public String toString() {
        return "Student{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", grade='" + grade + '\'' +
                '}';
    }
}
```

Once you have defined this, you can put it into the extra of an intent.

```java
intent.putExtra("student", new Student("1","Mike","6"));
```

To access the parcel on the other side, you can use the following example code.


```java
Bundle data = getIntent().getExtras();
Student student = (Student) data.getParcelable("student");
```
# further reading 

https://www.jianshu.com/p/df35baa91541

