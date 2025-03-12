FROM eclipse-temurin:21

RUN apt update; \
	apt-get install -y --no-install-recommends adduser git; \
	rm -rf /var/lib/apt/lists/*

# Minecraft user
RUN adduser minecraft

# Build Spigot
ARG MINECRAFT_VERSION
ENV MINECRAFT_VERSION=${MINECRAFT_VERSION}
ADD --chown=minecraft:minecraft https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar /home/minecraft/BuildTools.jar
RUN set -eux; \
	cd /home/minecraft; \
	java -jar /home/minecraft/BuildTools.jar --rev $MINECRAFT_VERSION; \
	echo eula=true > eula.txt

# Add plugins
ADD --chown=minecraft:minecraft https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot /home/minecraft/plugins/Geyser-Spigot.jar
ADD --chown=minecraft:minecraft https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot /home/minecraft/plugins/floodgate-spigot.jar
ADD --chown=minecraft:minecraft https://dev.bukkit.org/projects/thizzyz-tree-feller/files/latest /home/minecraft/plugins/ultimate-tree-feller.jar
ADD --chown=minecraft:minecraft https://github.com/EssentialsX/Essentials/releases/download/2.20.1/EssentialsX-2.20.1.jar /home/minecraft/plugins/essentialsx.jar
ADD --chown=minecraft:minecraft https://download.luckperms.net/1573/bukkit/loader/LuckPerms-Bukkit-5.4.156.jar /home/minecraft/plugins/luckperms.jar
ADD --chown=minecraft:minecraft https://github.com/MC-Machinations/PaperTweaks/releases/download/v0.5.0/PaperTweaks.jar /home/minecraft/paper-tweaks.jar
ADD --chown=minecraft:minecraft https://www.spigotmc.org/resources/chestsort-api.59773/download?version=563662 /home/minecraft/chest-sort.jar

# Create directories for worlds (will be volume-mapped)
RUN mkdir -p /home/minecraft/world; \
	mkdir -p /home/minecraft/world_the_end; \
	mkdir -p /home/minecraft/world_nether

# Set proper permissions on minecraft directory
RUN chown -R minecraft:minecraft /home/minecraft

WORKDIR /home/minecraft
COPY start.sh /home/minecraft/start.sh
CMD ["/home/minecraft/start.sh"]
