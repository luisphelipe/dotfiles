#!/bin/bash

# Get the dimensions of the second screen using xrandr
SCREEN2_DIMENSIONS=$(xrandr | grep ' connected' | awk 'NR==2 {print $3}' | cut -d'+' -f1)
DISPLAY_NAME=$(xrandr --listmonitors | grep '1: +' | awk '{print $4}')

# Start capturing screen 2 and streaming it locally
ffmpeg -f x11grab -s $SCREEN2_DIMENSIONS -i $DISPLAY_NAME -vcodec libx264 -preset ultrafast -f mpegts udp://localhost:12345 &
FFMPEG_PID=$!

# Wait for a moment to ensure ffmpeg starts properly
sleep 2

# Start viewing the stream in mpv
mpv udp://localhost:12345

# Clean up
kill $FFMPEG_PID

