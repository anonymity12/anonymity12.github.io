#!/bin/bash
printf "Site last updated at %s " `date`
cd ~/code/anonymity12.github.io
git pull
hexo clean
hexo deploy
git add .
git commit -m "push src md files"
git push
