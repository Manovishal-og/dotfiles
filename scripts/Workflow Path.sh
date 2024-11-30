#!/bin/bash

WPATH=$(find ~/Documents/Programming -type d -iname Notes)
cd $WPATH
tmux -d "nvim"
tmux new-session -s "learning" nvim


