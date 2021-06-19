#!/bin/bash

BASEDIR=$(pwd)

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
  # GriefPrevention https://www.curseforge.com/minecraft/bukkit-plugins/grief-prevention
  curl -OL https://media.forgecdn.net/files/3173/411/GriefPrevention.jar
  # ArmorStandEditor https://www.curseforge.com/minecraft/bukkit-plugins/armor-stand-edit
  curl -OL https://media.forgecdn.net/files/2999/757/armorstandeditor-1.16-25.jar
  # LuckPerms https://github.com/lucko/LuckPerms
  wget https://ci.lucko.me/job/LuckPerms/1345/artifact/bukkit/loader/build/libs/LuckPerms-Bukkit-5.3.47.jar
  # floodgate-bukkit Geyser-Spigot https://geysermc.org/
  wget https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar
  wget https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar
  # emotecraft https://www.curseforge.com/minecraft/bukkit-plugins/emotecraft-bukkit
  LATEST=$(get_latest_release KosmX/emotes)
  curl -OL https://github.com/KosmX/emotes/releases/download/${LATEST}/emotecraft-2.0.5-bukkit.jar
  # Multiverse https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-core
  curl -OL https://media.forgecdn.net/files/3074/594/Multiverse-Core-4.2.2.jar
  # MV-inventories https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-inventories
  curl -OL https://media.forgecdn.net/files/3222/929/Multiverse-Inventories-4.2.2.jar
  # MV-SignPortals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-signportals
  curl -OL https://media.forgecdn.net/files/3074/605/Multiverse-SignPortals-4.2.0.jar
  # MV-Portals https://www.curseforge.com/minecraft/bukkit-plugins/multiverse-portals
  curl -OL https://media.forgecdn.net/files/3113/114/Multiverse-Portals-4.2.1.jar
  # WorldEdit (Dependency for Plot²) https://www.curseforge.com/minecraft/bukkit-plugins/worldedit
  curl -OL https://media.forgecdn.net/files/3283/695/worldedit-bukkit-7.2.5-dist.jar
  # Plot² https://www.curseforge.com/minecraft/bukkit-plugins/plotsquared (Buyable for 15€ here: https://www.spigotmc.org/resources/plotsquared-v5.77506/ )
  curl -OL https://media.forgecdn.net/files/2932/66/PlotSquared-Bukkit-4.494.jar
  # ChestShop https://www.curseforge.com/minecraft/bukkit-plugins/chestshop
  LATEST=$(get_latest_release ChestShop-authors/ChestShop-3)
  curl -OL https://github.com/ChestShop-authors/ChestShop-3/releases/download/${LATEST}/ChestShop.jar
