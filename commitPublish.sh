#!/bin/bash
echo "start 1.pull and 2.deploy and 3.push src md files"
cd ~/code/anonymity12.github.io
git pull
hexo clean
hexo deploy
git add .
git commit -m "push src md files"
git push
