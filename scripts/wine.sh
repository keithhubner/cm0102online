#!/usr/bin/env bash

sleep 1s

Xvfb :99 &
DISPLAY=:99 winecfg &
x11vnc -display :99 -forever