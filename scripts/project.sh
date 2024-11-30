#!/bin/bash

# Define session and window names
SESSION_NAME="workflow"
EDITOR_WINDOW="editor"
CLI_WINDOW="cli"
WPATH=$(find ~/Documents/Programming -type d -iname Projects)
cd $WPATH
# Check if the tmux session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
  # Create a new tmux session named 'workflow' with the first window named 'editor' and start `nvim`
  tmux new-session -d -s $SESSION_NAME -n $EDITOR_WINDOW "nvim"

  # Create a second window named 'cli'
  tmux new-window -t $SESSION_NAME:2 -n $CLI_WINDOW

fi

# Switch to the 'editor' window and attach to the session
 tmux select-window -t $SESSION_NAME:0
tmux attach-session -t $SESSION_NAME


