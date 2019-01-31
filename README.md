Zeek Docker
===========

- Builds [Zeek IDS](https://www.zeek.org/) from scratch (github master)
- Container base is `debian:stretch`
- Build stages to separate install dependencies
- Enables `python 3`
- Installs the `bro-pkg` [packet manager](https://packages.zeek.org/)

Zeek was formerly Bro IDS. Beware that the binary and some paths still contain the old name.

### Usage

[Zeek can be scripted](https://docs.zeek.org/en/stable/examples/scripting/index.html). Per default, it will load the script at `$ZEEK_HOME/share/bro/site/local.bro`. See also the [broctl#bro-scripts](https://github.com/zeek/broctl#bro-scripts) documentation.

You can mount a directory to `/usr/local/bro/share/bro/site` to set custom scripts for Zeek to use.

### Build

    $ docker build . -t fixel/zeek:latest
    
### Run

You can find a container image on docker hub: [fixel/zeek](https://cloud.docker.com/repository/docker/fixel/zeek)

The container expects that you pass arguments to it, everything is passed to the `bro` command. To listen on the interface `enp0s31f6` you would run this:

    $ docker run --net=host --name=zeek -ti fixel/zeek -i enp0s31f6

The logs will be stored in `/usr/local/bro/logs/current`. The parent folder `/usr/local/bro/logs` is marked as docker volume. You can extract the logs by the usual means of container management.