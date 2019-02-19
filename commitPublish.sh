#!/bin/bash
git pull
hexo clean
hexo deploy
git add .
git commit -m "push src md files"
git push