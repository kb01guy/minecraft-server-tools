# Minecraft Server Tools

This is everything I will use to setup a Minecraft Server preconfigured with awesome plugins.
You will need a Debian based System to use this Script.

You might need to manually adjust your System afterwards to run the Server automatically, if you're not using Debian 10.



```
git clone https://github.com/kb01guy/minecraft-server-tools
cd minecraft-server-tools

# Make sure the Script is executable
chmod u+x setup.sh

# DO NOT USE sh TO EXECUTE THIS SCRIPT! Some String Operations require bash.
./setup.sh

# Some Plugins can't be downloaded with the latest Version, make sure you klick every Link in the Console and Download it from the Website.
```




## Tutorials
This is a list of interesting Tutorials, wich will help you to set up your own Minecraft Server:
- A Tutorial for setting up a Minecraft Server on a Raspberry Pi. It is helpful for showing how you can run your Server as a Systemd Service and a non privileged User. https://linuxize.com/post/how-to-install-minecraft-server-on-raspberry-pi/

## Software I additionally use on my Server
- strato-dns-updater https://github.com/aortmannm/strato-dns-updater


## Planned Features:
- Roles
  - admin
  - team
  - player
- Lobby
  - Tutorial
  - Teleport
- Survival World
  - Claiming (no one can destroy them)
  - ChestShop (buy and sell Items from Users)
  - Homes (Your Personal Teleport Places)
  - Micro Blocks (You can Buy every Block as a Head from a Wandering Trader)
  - Player Heads (If you kill a Player you get their Head as a Trophy)
  - Mob Heads (Every Mob has a possibility to drop their Head)
- Minigames
  - Bedwars (Destroy the Bed wich lets the other Players respawn)
  - Quake (a fast paced non violent shooter)
  - QuickSurvivalGames (Loot Chests and Fight until the last alive player wins)
- Creative World
  - Plots (Buy square Land to build in)
  - CreativeMode (use all Blocks to be crative)
- Compartibility
  - Bedrock (PocketEdition, Windows10, Switch)
  - Emotecraft
  - ViveCraft (VR Minecraft)
