#!/bin/bash
 
current_path=$(cd $(dirname $0); pwd)
if [ ! -d ~/Library/Developer/Xcode/Templates ]
then
    mkdir ~/Library/Developer/Xcode/Templates
fi
if [ ! -d ~/Library/Developer/Xcode/Templates/File\ Templates ]
then
    mkdir ~/Library/Developer/Xcode/Templates/File\ Templates
fi
ln -fs ${current_path}/Templates/File\ Templates/* ~/Library/Developer/Xcode/Templates/File\ Templates
