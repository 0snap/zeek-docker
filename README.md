Zeek Docker
===========

- Builds [Zeek IDS](https://www.zeek.org/) from scratch (github master)
- Container base is `debian:buster`
- Uses `python 3`
- Installs the `zkg` [packet manager](https://packages.zeek.org/)

Zeek was formerly Bro IDS. Beware that some paths may still contain the old name.

### Usage

[Zeek can be scripted](https://docs.zeek.org/en/stable/examples/scripting/index.html). Per default, it will load the script at `$ZEEK_HOME/share/bro/site/local.bro`. See also the [broctl#bro-scripts](https://github.com/zeek/broctl#bro-scripts) documentation.

You can mount a directory to `/usr/local/zeek/share/zeek/site` to set custom scripts for Zeek to use.

### Build

    $ docker build . -t fixel/zeek:latest
    
### Run

You can find a container image on docker hub: [fixel/zeek](https://cloud.docker.com/repository/docker/fixel/zeek)

The container expects that you pass arguments to it, everything is passed to the `zeek` command. To listen on the interface `enp0s31f6` you would run this:

    $ docker run --net=host --name=zeek -ti fixel/zeek -i enp0s31f6

The logs will be stored in `/usr/local/zeek/logs`, which is marked as docker volume. You can extract the logs by the usual means of container management.

### Computation Speed Up & Clustering

Zeek IDS can only leverage one processor core. But it can be run in a worker cluster setup to share the computational costs of traffic processing. Find a docker based Zeek IDS worker cluster on github: [0ortmann/zeek-cluster](https://github.com/0ortmann/zeek-cluster), on docker hub: [fixel/zeek-cluster](https://cloud.docker.com/u/fixel/repository/docker/fixel/zeek-cluster).