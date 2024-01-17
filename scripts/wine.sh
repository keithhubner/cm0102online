#!/usr/bin/env bash

sleep 1s

mkdir /cm0102/.vnc

Xvfb :99 &
DISPLAY=:99 winecfg &
x11vnc -storepasswd $VNCPASSWORD /cm0102/.vnc/passwd &
x0vncserver -passwordfile /cm0102/.vnc/passwd -display :99