#! /bin/bash

SCRIPTS=$HOME/dev/helpful_scripts
$SCRIPTS/keymaps.sh

# save dbus session info so I can source it from mbsyncrc cronjob
touch /tmp/.Xdbus
chmod 600 /tmp/.Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > /tmp/.Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> /tmp/.Xdbus

#python /home/oscar/dev/gis-weather/gis-weather.py
