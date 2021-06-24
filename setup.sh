#!/bin/bash

BASEDIR=$(pwd)

MANUAL_DOWNLOAD="\nPlease Download these Plugins manually! \n\n"

# Helper
get_latest_release() {  # Source: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}


# Install Essentials
sudo apt-get -yq install git build-essential gnupg curl

# Add Repositories
# Azul Zulu OpenJDK
#sudo apt-key adv \
#  --keyserver hkp://keyserver.ubuntu.com:80 \
#  --recv-keys 0xB1998361219BD9C9
#curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-2_all.deb
#sudo apt-get install ./zulu-repo_1.0.0-2_all.deb

#sudo apt-get update


# Install Software
#sudo apt-get install zulu16-jdk




# Create File Structure
mkdir -p ${BASEDIR}/tools/buildtools && \
mkdir -p ${BASEDIR}/tools/java && \
mkdir -p ${BASEDIR}/server/plugins

# Setup mcrcon
cd ${BASEDIR}/tools && git clone https://github.com/Tiiffi/mcrcon.git \
&& cd ${BASEDIR}/tools/mcrcon && gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c

# Setup Java 16
cd ${BASEDIR}/tools/java && curl -O https://cdn.azul.com/zulu/bin/zulu16.30.15-ca-jdk16.0.1-linux_amd64.deb \
&& sudo apt -y install ./zulu16.30.15-ca-jdk16.0.1-linux_amd64.deb

# Setup Spigot
cd ${BASEDIR}/tools/buildtools && curl -O https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar \
&& java -jar BuildTools.jar --rev 1.17

# Setup Server-Space
cd ${BASEDIR}/server && cp ${BASEDIR}/tools/buildtools/spigot*.jar ./spigot.jar

  # Download Plugins
  cd ${BASEDIR}/server/plugins

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
  # emotecraft https://www.curseforge.com/minecraft/bukkit-plugins/emotecraft-bukkit
  LATEST=$(get_latest_release KosmX/emotes)
  curl -OL https://github.com/KosmX/emotes/releases/download/${LATEST}/emotecraft-${LATEST:0:5}-bukkit.jar
  # Multiverse: Core, Inventries, SignPortals, Portals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-core
  MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD}Multiverse: \n"
  MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Core https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-core \n"
  MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Inventories https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-inventories \n"
  MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - Portals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-portals \n"
  MANUAL_DOWNLOAD="${MANUAL_DOWNLOAD} - SignPortals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-signportals \n"
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
