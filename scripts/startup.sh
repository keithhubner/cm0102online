#!/usr/bin/env bash

sleep 1s


Xvfb :99 &
DISPLAY=:99 wine $WINEPREFIX/dosdevices/d:/setup.exe -nosound &
x11vnc -display :99 -forever