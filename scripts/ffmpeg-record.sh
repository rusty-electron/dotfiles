#!/bin/sh

# full video-audio recording
#ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -f pulse -i default ~/myfiles/screencasts/`date '+%Y-%m-%d_%H-%M-%S'`.mp4 &> ~/myfiles/screencasts/logs/`date '+%Y-%m-%d_%H-%M-%S'`.log

# desktop audio recording ; audio source numbers change so may need reconfiguring
ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 -f pulse -i 4 -preset ultrafast ~/myfiles/screencasts/`date '+%Y-%m-%d_%H-%M-%S'`.mp4 &> ~/myfiles/screencasts/logs/`date '+%Y-%m-%d_%H-%M-%S'`.log

# no-audio recording
#ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0 ~/myfiles/screencasts/`date '+%Y-%m-%d_%H-%M-%S-no-aud'`.mp4 &> ~/myfiles/screencasts/logs/`date '+%Y-%m-%d_%H-%M-%S-no-aud'`.log

