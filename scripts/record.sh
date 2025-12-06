#!/bin/bash 

pid=`pgrep wf-recorder`
status=$?

if [ $status != 0 ] 
then 
  wf-recorder -audio="alsa_output.pci-0000_00_1b.0.analog-stereo.monitor" -f ~/Videos/Screen-Recording/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
else 
  pkill --signal SIGINT wf-recorder
fi;
