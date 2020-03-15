#!/bin/bash
# 0315 update no more push to github, only local
printf "%s" `date`
cd ~/code/anonymity12.github.io
#git pull
#echo "pulling..."
hexo clean
hexo generate
echo "genertating..."
#hexo deploy
#echo "deploying to master"
git add .
git commit -m "push src md files"
hexo s
#git push
#echo "pushing to hexo branch"
