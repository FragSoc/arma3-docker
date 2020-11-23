![](https://arma3guide.com/custom/images/Banner.jpg)

![GitHub](https://img.shields.io/github/license/FragSoc/arma3-docker?style=flat-square)

---

A [Docker](https://www.docker.com/) image to run a dedicated server for [ARMA 3](https://arma3.com/).

## Running

Sample run command:

```bash
docker run -d \
  -p 2344:2344/udp \
  -p 2344:2344 \
  -p 2345:2345 \
  -p 2302-2306:2302-2306/udp \
  fragsoc/arma3
```

### Ports

All ports taken from the [wiki page](https://community.bistudio.com/wiki/Arma_3_Dedicated_Server#Port_Forwarding).

Port(s) | TCP | UDP
---|---|---
2344 | yes | yes
2345 | yes | no
2302-2306 inclusive | no | yes

### Volumes

- `/config` - server configuration
- `/profiles` - difficulty profiles

## Building

Run the command:

```
STEAM_USER=<your steam username> make build
```

You will probably be prompted to login with steam - this is handled entirely by steamcmd; no code or scripts in this repo **ever** see your steam credentials.

If you want to rebuild the image with the latest version of ARMA 3, run `make clean` first.

### Dependencies

- [`steamcmd`](https://developer.valvesoftware.com/wiki/SteamCMD)
- `docker`, look [here](https://docs.docker.com/docker-for-windows/install/) for windows or [here](https://docs.docker.com/engine/install/) for linux
- GNU `make`, usually installed under the `build-essential` package on linux; on windows, you must use [cygwin](https://www.cygwin.com/) or the [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10), etc.
- a steam account (doesn't need to own the game)

> You require a steam account because, for whatever reason, the ARMA 3 dedicated server app on steam cannot be downloaded by the `anonymous` steam account

### Troubleshooting

- If docker reports an error communicating with `docker.sock`, you may need to run the above command as root
- If an error is thrown saying `steamcmd` not found, you need to locate your steamcmd executable (`which steamcmd`) and append it as a variable to the make command:

  `STEAM_USER=<your steam username> STEAMCMD=<your steamcmd location> make build `

  or:

  `STEAM_USER=<your steam username> STEAMCMD=$(which steamcmd) make build `
- If you get an instant `SEGFAULT` from the server when using [bind mounts](https://docs.docker.com/storage/bind-mounts/), either change the owner of the mounts to user:group `999:999` or rebuild the image, passing `UID=<desired system user ID>` before `make`

## Disclaimer

The files in this repo are licensed under the AGPL v3.
ARMA 3 is proprietary software owned by [Bohemia Ineractive](https://www.bohemia.net/), no credit is taken for their work.
