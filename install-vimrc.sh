#!/usr/bin/env bash
mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/backup
ln -s `pwd`/vimrc ~/.vimrc

ln -s `readlink -f coc-settings.json` ~/.vim/
