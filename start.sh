#!/bin/bash

echo Setting UID and GID of minecraft user...
usermod -u $PUID minecraft
groupmod -g $PGID minecraft

echo "Starting Minecraft (via Spigot)..."
java $JAVA_OPTIONS -jar /home/minecraft/spigot-$MINECRAFT_VERSION.jar --nogui
