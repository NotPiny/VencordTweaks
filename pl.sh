#!/bin/bash
pluginFolder=""
pluginRepo=""
pluginPath=""

echo "Enter the following information to add a plugin to the map file"
read -p "Enter the plugin folder name: " pluginFolder
read -p "Enter the plugin repo name: " pluginRepo
read -p "Enter the plugin path: " pluginPath

if [ -z "$pluginFolder" ] || [ -z "$pluginRepo" ] || [ -z "$pluginPath" ]; then
    echo "Please enter all the required fields"
    exit 1
fi

echo -e "\n$pluginFolder;$pluginRepo;$pluginPath" >> plugins.map