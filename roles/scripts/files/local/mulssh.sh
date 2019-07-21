#!/bin/bash
SESSION=$USER

current_pane=$TMUX_PANE
echo $current_pane

user=""
if [ "$1" == "-u" ] ; then
    user=$2'@'
    shift 2
fi

for cmd in "$@" ; do
    tmux split-window "ssh $user$cmd"
    tmux select-layout -t "${tmux_session}" tiled
done

tmux kill-pane -t "$current_pane"
