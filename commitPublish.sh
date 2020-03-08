#!/bin/bash
printf "%s" `date`
cd ~/code/anonymity12.github.io
git pull
echo "pulling..."
hexo clean
hexo generate
echo "genertating..."
hexo deploy
echo "deploying to master"
git add .
git commit -m "push src md files"
git push
echo "pushing to hexo branch"
