# spigot-geysermc-floodgate-docker
Docker container combining [Spigot](https://www.spigotmc.org/), [GeyserMC](http://geysermc.org/) and [Floodgate](https://wiki.geysermc.org/floodgate/).

## Setup
<ol>
	<li> Clone the repository.</li>
<li> Run `cp .env.stub .env` and update `.env` with the user and group IDs you would like to run the container under, and the Java options you would like to run Minecraft with.</li>
<li> Copy the sample files located under `config` (e.g. `cp server.properties.sample server.properties`) and update with your preferred settings. Note that these files will be mapped into the container, so any changes you make here will be reflected in the container (and vice versa).</li>
	<ol>
		<li> Note that `geyser-config.yml.sample` has already been configured to use Floodgate.</li>
	</ol>
	<li> Run `docker-compose up --build -d` to build and run the container.</li>
</ol>
