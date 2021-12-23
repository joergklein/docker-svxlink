# Docker base image for SvxLink

SvxLink is an advanced repeater system software with EchoLink support for Linux
including a GUI, `Qtel - the Qt EchoLink client`. It is a project that develops
software targeting the `ham radio community`. It started out as an EchoLink
application for Linux back in 2003 but has now evolved to be something much more
advanced.

More information about SvxLink is amiable on the [Homepage][1], the
[GitHub Repository][2] and on the [GitHub Wiki][3].

[1]: http://svxlink.org
[2]: https://github.com/sm0svx/svxlink
[3]: https://github.com/sm0svx/svxlink/wiki

[joergklein/svxlink][4] is a Docker base image for SvxLink.

[4]: https://hub.docker.com/r/joergklein/svxlink

**Notice:** The SvxLink Repeater is not configured. Only the qtel client is
configured. The config file Qtel.conf will be saved on the local host.

## Clone the Repository and run Qtel

```sh
git clone https://github.com/joergklein/docker-svxlink.git
./run
qtel &
```

## Build and run the image

```sh
docker build -t joergklein/svxlink:[<Tag>] .
./run
qtel &
```

## Configure the svxlink server

1. Configure the soundcard:  
   /etx/svxlink/svxlink.conf `AUDIO_DEV=alsa:plug hw:1`  
2. Set the Echolink callsign  
   /etc/svxlink.d/ModuleEchoLink.conf the Echolink Callsign
