# Docker: danschmidt5189/systemd_mon

Includes fixes to the existing krommit/systemd_mon image:

- Adds the ca-certificates package so SSL connections work
- Uses a (very) specific base image and auto-builds when that updates
- Sets a default config file so you don't have to (`./systemd_mon.yml`)

## Usage

As a one-off container:

```sh
docker run \
  --rm \
  --name systemd_mon \
  --mount type=bind,src=/path/to/systemd_mon.yml,dst=/systemd_mon.yml,ro \
  --mount type=bind,src=/var/run/dbus,dst=/var/run/dbus,ro \
  --hostname "$HOSTNAME" \
  danschmidt5189/systemd_mon
```

As a Swarm service:

```sh
docker service create \
  --name systemd_mon \
  --mount type=bind,src=/path/to/systemd_mon.yml,dst=/systemd_mon.yml,ro \
  --mount type=bind,src=/var/run/dbus,dst=/var/run/dbus,ro \
  --hostname "$HOSTNAME" \
  danschmidt5189/systemd_mon
```

Two comments:

- We set `--hostname` so that systemd_mon sends the _actual_ host's hostname and not just its ephemeral container ID.
- Docker experts will probably want to use something other than a bind-mount to load the configuration file (e.g. `docker config`; systemd_mon's config loading isn't very Docker-friendly at the moment).
