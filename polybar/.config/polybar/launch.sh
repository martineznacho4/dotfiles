#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

# Launch bar1
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar newbar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
