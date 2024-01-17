#!/usr/bin/env bash

sleep 1s


mkdir /cm0102/.vnc

# Xvfb :99 -screen 0 1080x768x16 -fbdir /tmp &
Xvfb :99 &
DISPLAY=:99 wine $WINEPREFIX/dosdevices/d:/cm0102.exe -nosound &
x11vnc -storepasswd $VNCPASSWORD /cm0102/.vnc/passwd &
#x11vnc -rfbauth /cm0102/.vnc/passwd -display :99 -forever
x0vncserver -passwordfile /cm0102/.vnc/passwd -display :99