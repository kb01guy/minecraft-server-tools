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

# BackupOnEvent https://www.curseforge.com/minecraft/bukkit-plugins/backuponevent
LATEST=$(get_latest_release enayet123/BackupOnEventPlugin)
curl -OL https://github.com/enayet123/BackupOnEventPlugin/releases/download/${LATEST}/BackupOnEvent.jar
# Vault https://www.curseforge.com/minecraft/bukkit-plugins/vault
LATEST=$(get_latest_release MilkBowl/Vault)
curl -OL https://github.com/MilkBowl/Vault/releases/download/${LATEST}/Vault.jar
# Essentials https://www.curseforge.com/minecraft/bukkit-plugins/essentialsx
LATEST=$(get_latest_release EssentialsX/Essentials)
curl -OL https://github.com/EssentialsX/Essentials/releases/download/${LATEST}/EssentialsX-${LATEST}.0.jar

# floodgate-bukkit Geyser-Spigot https://geysermc.org/
wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar
wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar

echo "Please Download the following Plugins manually: \
GriefPrevention https://www.curseforge.com/minecraft/bukkit-plugins/grief-prevention \
ArmorStandEditor https://www.curseforge.com/minecraft/bukkit-plugins/armor-stand-edit \
emotecraft https://github.com/KosmX/emotes/releases/latest \
LuckPerms https://luckperms.net/ "
