FROM ubuntu:20.04

WORKDIR /minecraft

# Set timezone so installing tzdata doesn't cause things to hang
ENV TZ=America/Halifax
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Update and install software
RUN apt-get update
RUN apt-get install --no-install-recommends git openjdk-17-jdk -y

# Build Spigot
ARG MINECRAFT_VERSION
ENV MINECRAFT_VERSION=$MINECRAFT_VERSION
ADD https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar ./BuildTools.jar
RUN ls -l ./BuildTools.jar
RUN java -jar ./BuildTools.jar --rev $MINECRAFT_VERSION
RUN echo eula=true > ./eula.txt

# Add GeyserMC and Floodgate plugins
ADD https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar ./plugins/Geyser-Spigot.jar
ADD https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar ./plugins/floodgate-spigot.jar

# Copy entrypoint script into the container
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Setup user permissions
ARG UID
ARG GID
RUN useradd -ms /bin/bash minecraft && \
	usermod -u $UID minecraft && \
	groupmod -g $GID minecraft
RUN chown -R minecraft:minecraft . 

USER minecraft

ENTRYPOINT ["/docker-entrypoint.sh"]
