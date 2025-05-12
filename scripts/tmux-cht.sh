#!/usr/bin/env bash
languages=$(echo "golang lua python bash" | tr ' ' '\n')
selected=$(printf "$languages" | fzf)

read -p "Enter Query: " query

if printf "$languages" | grep -qs "$selected"; then
	tmux neww bash -c "curl cht.sh/$selected/$(echo $query | tr ' ' '+')& while [ : ]; do sleep 1; done"
else
	tmux neww bash -c "curl cht.sh/$selected~$query & while [ : ]; do sleep 1; done"
fi
