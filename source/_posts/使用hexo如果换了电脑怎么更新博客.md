---
title: 使用hexo如果换了电脑怎么更新博客
date: 2019-08-24 17:12:02
tags: hexo
categories: tech
---


使用hexo如果换了电脑怎么更新博客.md

当重装电脑之后，或者想在其他电脑上修改博客，可以使用下列步骤：1. 使用git clone git@github.com:CrazyMilk/CrazyMilk.github.io.git拷贝仓库（默认分支为hexo）；2. 在本地新拷贝的http://CrazyMilk.github.io文件夹下通过Git bash依次执行下列指令：npm install hexo、npm install、npm install hexo-deployer-git（记得，不需要hexo init这条指令）

作者：CrazyMilk
链接：https://www.zhihu.com/question/21193762/answer/79109280
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。