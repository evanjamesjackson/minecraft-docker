This is a Docker container which conveniently combines [Spigot](https://www.spigotmc.org/), [GeyserMC](http://geysermc.org/) and [Floodgate](https://wiki.geysermc.org/floodgate/). This will allow you to run a Minecraft Java Edition server that Bedrock Edition clients can still log into. 

## Setup
1. Clone the repository.
2. Run `cp .env.stub .env` and update `.env` with you preferred values.
3. Copy the sample files located under `config` (e.g. `cp server.properties.sample server.properties`) and update with your preferred settings. Note that these files will be mapped into the container, so any changes you make here will be reflected in the container (and vice versa). Note that `geyser-config.yml.sample` has already been configured to use Floodgate.	
4. Run `docker-compose up -d` to build and run the container.
5. Open (and port forward, if you want them to be Internet-accessible) the ports you've defined for `JAVA_PORT` and `BEDROCK_PORT`.
