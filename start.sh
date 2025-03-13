#!/bin/bash

set -e

echo "Setting UID and GID of minecraft user..."
usermod -u $PUID minecraft
groupmod -g $PGID minecraft

echo "Adding custom plugins..."
echo "$CUSTOM_PLUGIN_URLS" | tr ',' '\n' | while read -r plugin; do
  echo "Adding $plugin..."
  wget -P /home/minecraft/plugins $plugin 
done

echo "Starting Minecraft (via Spigot)..."
java $JAVA_OPTIONS -jar /home/minecraft/spigot-$MINECRAFT_VERSION.jar --nogui
