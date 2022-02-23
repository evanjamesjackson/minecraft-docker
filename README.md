# spigot-geysermc-floodgate-docker
Docker container combining [Spigot](https://www.spigotmc.org/), [GeyserMC](http://geysermc.org/) and [Floodgate](https://wiki.geysermc.org/floodgate/).

## Setup
1. Clone the repository.
2. Run `cp .env.stub .env` and update `.env` with the user and group IDs you would like to run the container under.
3. Run `cp server.properties.stub` and update `server.properties` with your preferred settings. Note that this file will be mapped into the container, so any changes you make here will be reflected in the container.
3. Update `docker-entrypoint.sh` and `geyser-config.yml` with your preferred settings. Note that geyser-config.yml has already been set up to use Floodgate.
4. Run `docker-compose up --build -d` to build and run the container.
