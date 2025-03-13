#!/bin/bash

set -e

echo "Setting UID and GID of minecraft user..."
usermod -u $PUID minecraft
groupmod -g $PGID minecraft

IFS=',' read -ra PLUGINS <<< "$CUSTOM_PLUGIN_URLS"
for plugin in "${PLUGINS[@]}"; do
  echo "Downloading $plugin..."
  wget -P /home/minecraft/plugin $plugin
done


echo "Starting Minecraft (via Spigot)..."
java $JAVA_OPTIONS -jar /home/minecraft/spigot-$MINECRAFT_VERSION.jar --nogui
