---
title: 学习SDE
date: 2019-02-16 13:12:02
tags: sde
---

描述SDE 和 OS 的关系，来明白我们如何 对接RGOS

描述 SDE 编译出来的 thrift 代码，以及实现一个 简单的控制面

<!--more-->

[TOC]


# 先说说什么是ONL


ONL 是专为网络交换机开发的系统，可以特别地支持 端口，LED， 风扇 这些特殊硬件


# 明确的问题是：SDE 在ONL 中的作用和行为特征

## ref

https://support.barefootnetworks.com/hc/en-us/categories/200358035-Barefoot-P4-Studio-SDE

SDE 当前在ONL（open network linux) 中作为P4 程序 编译，部署 的环境


# 什么是SDE 

software development environment  旨在在各种OS 上进行P4 的开发，生成BF芯片 需要的data panel 可执行的程序

当前我们在ONL （open network linux) 上搭建好了SDE

内容包含：

1. 核心软件
2. 参考代码
3. 测试框架
4. 示例
5. 第三方lib

## SDE 中包含p4c 及其他工具

![image](https://ws1.sinaimg.cn/large/005JrW9Kgy1g0ezqr7d3tj30b50h475l.jpg)

编译器，工具，目标模型，系统库，驱动

利用p4c 我们可以编译p4 程序

## 使用run_switchd.sh 可以开始载入编译好的p4 程序

`run_switchd.sh` 指定了配置文件 作为参数，此配置文件中，包含tofino 需要的bin


![image](https://ws1.sinaimg.cn/large/005JrW9Kgy1g0cqgb18p3j30pe0exgnf.jpg)

`run_switchd.sh` 使用了`bf_switchd`

 `bf_switchd`是 在 ` /root/bf-sde-8.2.0/install/bin` 中的一个可执行文件

我的理解就是，`bf_switchd` 作为一个加载p4 程序的 进程，同时也是一个开放 数据层面 API 的 服务器

它实现了C/S 模型，这便于之后我们使用thrift RPC 的方式来进行 通信

![image](https://ws4.sinaimg.cn/large/005JrW9Kgy1g0eyvde20vj30uf0k8k0l.jpg)

# 与PD API交互，打通控制层面和数据层面

## 生成pythrift

在SDE中 编译我们的p4 后会自动生成pd_api的thrift文件，这包含了我们程序中的table 等内容的`CRUD` api

![image](https://ws4.sinaimg.cn/large/005JrW9Kgy1g0ez0gtwhij30al09t747.jpg)

![image](https://wx4.sinaimg.cn/large/005JrW9Kgy1g0ezx1iqruj30cu04ha9w.jpg)

![image](https://wx4.sinaimg.cn/large/005JrW9Kgy1g0ezxbi682j30cv0d1mx8.jpg)


如图，如果以py 为例，那么我们会得到 `gen-py` 这个文件夹，它其实是通过

```
thrift --gen py p4_pd_rpc.thrift
thrift --gen py res.thrift
```

生成了客户端可用的RPC 代码

如果我们把这些产物copy 出来，并以此为基础，编写一个py 的访问数据层面的小程序，我们是这样做的

![image](https://ws2.sinaimg.cn/large/005JrW9Kgy1g0ezs31el8j3094052t8k.jpg)

## 使用py，控制面作为客户端调用thriftAPI 访问数据层面的示例

```py
import sys
sys.path.append('./gen-py')

# 那这些就是我们的 pd 相关的 client 可调用的api， 就是来自 ./gen-py 的那些文件（lib）
from p4_pd_rpc import basic_switching
from p4_pd_rpc.ttypes import *
from res_pd_rpc.ttypes import *

# 这些thrift 的 lib 是 我们必须的
from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.protocol import TMultiplexedProtocol

def hex_to_i16(h):
    x = int(h)
    if (x > 0x7FFF) : x -= 0x10000
    return x

# now BIG!! connect to thrift server
transport = TSocket.TSocket('192.168.193.102', 9090) # 这意味着控制面可以与数据层面实体 分离的很远
transport = TTransport.TBufferedTransport(transport)
protocol = TBinaryProtocol.TBinaryProtocol(transport)
p4_protocol = TMultiplexedProtocol.TMultiplexedProtocol(protocol, "basic_switching") # 运行的p4 程序的名字
client = basic_switching.Client(p4_protocol)

# 打开沟通的连接
transport.open()

# example： 获得一张表的entry 的数量（ forward 表）
dev_tgt = DevTarget_t(0, hex_to_i16(0xFFFF))
print client.forward_get_entry_count(0, dev_tgt)
print ("now is OK I think!")
```



## 结果：

![image](https://wx1.sinaimg.cn/large/005JrW9Kgy1g0eyxtwl4wj30k301qt8i.jpg)

# 使用c++ 的示例 ，调用thriftAPI 访问数据层面的示例

```C
#include "./gen-cpp/p4_prefix.h"


#include <thrift/transport/TSocket.h>
#include <thrift/transport/TBufferTransports.h>
#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/protocol/TMultiplexedProtocol.h>
 
#include <iostream>
#include <vector>
#include <sys/stat.h>
#include <sys/types.h>



using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;
using namespace std;
 
using boost::shared_ptr;


int main() {
    boost::shared_ptr<TSocket> socket(new TSocket("192.168.193.102", 9090));
    boost::shared_ptr<TTransport> transport(new TBufferedTransport(socket));
    boost::shared_ptr<TProtocol> protocol(new TBinaryProtocol(transport));
    // boost::shared_ptr<TProtocol>TMultiplexedProtocol *mp2 = new boost::shared_ptr<TProtocol>TMultiplexedProtocol(protocol, "WeatherReport");
    boost::shared_ptr<TProtocol> tm(new TMultiplexedProtocol(protocol, "basic_switching"));

    p4_pd_rpc::basic_switchingClient client(tm);

    // 打开沟通的连接
    transport->open();
    printf("%s\n", "s6");
    // example： 获得一张表的entry 的数量（ forward 表）
    res_pd_rpc::DevTarget_t *dev_tgt = new res_pd_rpc::DevTarget_t();
    dev_tgt->__set_dev_id(0);
    dev_tgt->__set_dev_pipe_id(-1);

    printf("%s\n", "s7");

    printf("%d\n", client.forward_get_entry_count(0, *dev_tgt));
    printf("%s\n", "now C++ is OK!");

}


```


![image](https://wx2.sinaimg.cn/large/005JrW9Kgy1g0if95ca94j30fm035jr7.jpg)




