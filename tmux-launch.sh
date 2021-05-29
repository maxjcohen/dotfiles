#!/bin/sh

# Session name
session="workenv"

# Start tmux session
tmux new-session -d -s $session

# Main window (Vim + term)
tmux rename-window -t 0 'Main'
# ls ".env" > /dev/null 2>&1
# if [ $? -eq 0 ]; then
#     tmux send-keys -t 'Main' '. .env/bin/activate' C-m
# fi
# tmux split-window -hb
tmux send-keys -t 'Main' 'vim' C-m
# tmux resize-pane -R 30

# Second window (Top and nvidia-smi)
tmux new-window -n 'Watch'
tmux send-keys -t 'Watch' 'htop' C-m
tmux split-window -h
tmux send-keys -t 'Watch' 'watch -n 2 "nvidia-smi"' C-m

# Jupyter lab
while [ ! -z $1 ]; do
    case "$1" in
	jupyter)
	    tmux new-window -n 'Jupyter'
	    tmux send-keys -t 'Jupyter' 'python -m jupyter lab' C-m
	    ;;
	tensorboard)
	    tmux new-window -n 'Tensorboard'
	    tmux send-keys -t 'Tensorboard' 'tensorboard --logdir lightning_logs' C-m
	    ;;
    esac
    shift
done

tmux attach-session -t $session:0
