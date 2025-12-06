#!/bin/bash

# Find the "Notes" directory inside ~/Documents/Programming
WPATH=$(find ~/Documents/Programming -type d -iname "Notes" 2>/dev/null)

# Check if WPATH is found
if [[ -z "$WPATH" ]]; then
    echo "Notes directory not found!"
    exit 1
fi

# Start a new tmux session named "TMUX" with an "editor" window running nvim
tmux new-session -d -s TMUX -n editor "nvim"

# Split the "editor" window into two panes (vertical split)
tmux split-window -h -p 25 -t TMUX:editor

# Create a new window named "notes" and switch to the Notes directory
tmux new-window -t TMUX -n notes -c "$WPATH"

# Attach to the tmux session
tmux attach-session -t TMUX


