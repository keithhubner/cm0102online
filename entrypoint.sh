#!/bin/bash

# Setup

GROUPNAME="cm0102"
USERNAME="cm0102"

export WINEPREFIX="/$USERNAME/appdata"

LUID=${LOCAL_UID:-0}
LGID=${LOCAL_GID:-0}

# Step down from host root to well-known nobody/nogroup user

if [ $LUID -eq 0 ]
then
    LUID=1001
fi
if [ $LGID -eq 0 ]
then
    LGID=1001
fi

# Create user and group

groupadd -o -g $LGID $GROUPNAME >/dev/null 2>&1 ||
groupmod -o -g $LGID $GROUPNAME >/dev/null 2>&1
useradd -o -u $LUID -g $GROUPNAME -s /bin/false $USERNAME >/dev/null 2>&1 ||
usermod -o -u $LUID -g $GROUPNAME -s /bin/false $USERNAME >/dev/null 2>&1
mkhomedir_helper $USERNAME

chmod -R 700 /cm0102
chown -R $USERNAME:$GROUPNAME /cm0102



exec gosu $USERNAME:$GROUPNAME sh /cm0102/scripts/$SCRIPT