#!/usr/bin/env bash
topic_constraing="none"

while [[ "$#" -gt 0 ]]; do
	case $1 in
	1 | lang)
		topic_constraint="lang"
		shift
		;;
	esac
done

topic=""
if [[ "$topic_constraint" == "lang" ]]; then
	topic=$(printf "go\nrust\nc" | fzf)
	stty sane
else
	topic=$(curl -s cht.sh/:list | fzf)
	stty sane
fi

if [[ -z "$topic" ]]; then
	exit 0
fi

sheet=$(curl -s cht.sh/$topic/:list | fzf)

if [[ -z "$sheet" ]]; then
	curl -s cht.sh/$topic?style=rtt | less -R
	exit 0
fi

curl -s cht.sh/$topic/$sheet?style=rtt | less -R
