#!/bin/bash

while [ ! -f "$HOME/.cache/wal/colors-kitty.conf" ]; do
	sleep 0.2
done

sleep 0.5

exec kitty
