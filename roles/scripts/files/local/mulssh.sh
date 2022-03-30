#!/bin/bash
SESSION=$USER

current_pane=$TMUX_PANE
echo $current_pane

while getopts "u:i:" arg ; do
    case $arg in
        u)
            user="${OPTARG}@"
            ;;
        i)
            inventory=${OPTARG}
            ;;
        *)
            exit 1
    esac
done
shift $((OPTIND -1))

if [ ! -z "$inventory" ] ; then
    hosts="$(ansible -i $inventory $1 --list-hosts)"
else
    hosts="$@"
fi

for cmd in $hosts ; do
    echo $cmd
    tmux split-window "ssh $user$cmd"
    tmux select-layout -t "${tmux_session}" tiled
done

tmux setw synchronize-panes on

tmux kill-pane -t "$current_pane"
