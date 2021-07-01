#!/bin/bash

BASEDIR=$(pwd)

# Helper
get_latest_release() {  # Source: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}


# Stop the Server
sudo systemctl stop minecraft

sleep 10

# Update mcrcon
cd ${BASEDIR}/tools/mcrcon && git pull
gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c

# TODO: OpenJDK-Update (v16 required!)

# Update spigot (Rebuilding is Fine, because the BuildTools pull the required Repositories autmagically)
cd ${BASEDIR}/tools/buildtools && java -jar BuildTools.jar --rev 1.17 \
&& cp ${BASEDIR}/tools/buildtools/spigot*.jar ${BASEDIR}/server/spigot.jar

# Update Plugins
mkdir -p ${BASEDIR}/server/plugins/backup
cd ${BASEDIR}/server/plugins/backup && rm *.jar
mv ${BASEDIR}/server/plugins/*.jar ${BASEDIR}/server/plugins/backup
cd ${BASEDIR}/server/plugins/

MANUAL_DOWNLOAD="\nPlease Download these Plugins manually! \n\n"
# BackupOnEvent https://www.curseforge.com/minecraft/bukkit-plugins/backuponevent
LATEST=$(get_latest_release enayet123/BackupOnEventPlugin)
curl -OL https://github.com/enayet123/BackupOnEventPlugin/releases/download/${LATEST}/BackupOnEvent.jar
# Vault https://www.curseforge.com/minecraft/bukkit-plugins/vault
LATEST=$(get_latest_release MilkBowl/Vault)
curl -OL https://github.com/MilkBowl/Vault/releases/download/${LATEST}/Vault.jar
# Essentials https://www.curseforge.com/minecraft/bukkit-plugins/essentialsx
LATEST=$(get_latest_release EssentialsX/Essentials)
curl -OL https://github.com/EssentialsX/Essentials/releases/download/${LATEST}/EssentialsX-${LATEST}.0.jar
curl -OL https://github.com/EssentialsX/Essentials/releases/download/${LATEST}/EssentialsXChat-${LATEST}.0.jar
# GriefPrevention https://www.curseforge.com/minecraft/bukkit-plugins/grief-prevention
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}GriefPrevention: https://www.curseforge.com/minecraft/bukkit-plugins/grief-prevention \n"
# ArmorStandEditor https://www.curseforge.com/minecraft/bukkit-plugins/armor-stand-edit
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}ArmorStandEditor: https://www.curseforge.com/minecraft/bukkit-plugins/armor-stand-edit \n"
# LuckPerms https://github.com/lucko/LuckPerms
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}LuckPerms: https://ci.lucko.me/job/LuckPerms/lastSuccessfulBuild/artifact/bukkit/loader/build/libs/ \n"
# floodgate-bukkit Geyser-Spigot https://geysermc.org/
wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar
wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar
LATEST=$(get_latest_release Camotoy/GeyserSkinManager)
curl -OL https://github.com/Camotoy/GeyserSkinManager/releases/download/${LATEST}/GeyserSkinManager-Spigot.jar
# emotecraft https://www.curseforge.com/minecraft/bukkit-plugins/emotecraft-bukkit
LATEST=$(get_latest_release KosmX/emotes)
curl -OL https://github.com/KosmX/emotes/releases/download/${LATEST}/emotecraft-${LATEST:0:5}-bukkit.jar
# Multiverse: Core, Inventries, SignPortals, Portals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-core
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}Multiverse: \n"
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Core https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-core \n"
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Inventories https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-inventories \n"
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Portals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-portals \n"
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - SignPortals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-signportals \n"
# StayPut: https://www.spigotmc.org/resources/stayput.34848/
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}StayPut: https://www.spigotmc.org/resources/stayput.34848/ \n"
# Plot² Price: 15€ https://www.spigotmc.org/resources/plotsquared-v6.77506/
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}Plot² (Payed!): \n"
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Plugin https://www.spigotmc.org/resources/plotsquared-v6.77506 \n"
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Dependency WorldEdit https://www.curseforge.com/minecraft/bukkit-plugins/worldedit \n"
# ChestShop https://www.curseforge.com/minecraft/bukkit-plugins/chestshop
LATEST=$(get_latest_release ChestShop-authors/ChestShop-3)
curl -OL https://github.com/ChestShop-authors/ChestShop-3/releases/download/${LATEST}/ChestShop.jar
# MoreMobHeads2 https://www.curseforge.com/minecraft/bukkit-plugins/moremobheads2
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}MoreMobHeads2: https://www.curseforge.com/minecraft/bukkit-plugins/moremobheads2 \n"
# Heart https://www.curseforge.com/minecraft/bukkit-plugins/heart
MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}Heart: https://www.curseforge.com/minecraft/bukkit-plugins/heart \n"
# ImageOnMap https://www.curseforge.com/minecraft/bukkit-plugins/imageonmap
LATEST=$(get_latest_release zDevelopers/ImageOnMap)
curl -OL https://github.com/zDevelopers/ImageOnMap/releases/download/${LATEST}/ImageOnMap-${LATEST[@]/v/}.jar

printf "${MANUAL_DOWNLOAD}"



read -p "Press Enter to start thes Server" </dev/tty
