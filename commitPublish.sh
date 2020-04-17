#!/bin/bash
# 0315 update no more push to github, only local
printf "%s" `date`
cd ~/code/anonymity12.github.io
git pull
echo "pulling..."
hexo clean
hexo generate
echo "genertating..."
hexo deploy
echo "pushed public blog to master branch"
git add .
git commit -m "wrote at `date`"
#hexo s
git push
echo "pushed backup blog to hexo branch"
