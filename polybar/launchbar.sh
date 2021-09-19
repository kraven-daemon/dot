#!/usr/bin/env sh

# Terminate quietly
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch Polybar
polybar wonderbar 2>&1 | tee -a /tmp/polybar.log &
