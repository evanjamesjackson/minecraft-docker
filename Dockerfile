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

# Add GeyserMC and Floodgate plugins
ADD --chown=minecraft:minecraft https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot /home/minecraft/plugins/Geyser-Spigot.jar
ADD --chown=minecraft:minecraft https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot /home/minecraft/plugins/floodgate-spigot.jar

# Create directories for worlds (will be volume-mapped)
RUN mkdir -p /home/minecraft/world; \
	mkdir -p /home/minecraft/world_the_end; \
	mkdir -p /home/minecraft/world_nether

# Set proper permissions on minecraft directory
RUN chown -R minecraft:minecraft /home/minecraft

WORKDIR /home/minecraft
COPY start.sh /home/minecraft/start.sh
CMD ["/home/minecraft/start.sh"]
