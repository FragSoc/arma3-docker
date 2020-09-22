# ARMA 3 Dedicated Server

![](https://arma3guide.com/custom/images/Banner.jpg)

A [Docker](https://www.docker.com/) image to run a dedicated server for [ARMA 3](https://arma3.com/).

## Running

### Ports

- 2344 - TCP and UDP
- 2345 - TCP
- 2302 to 2306 inclusive - UDP

### Volumes

- `/config` - server configuration
- `/profiles` - difficulty profiles

## Building

Run the command:

```
make build USER=<your steam username>
```

You will probably be prompted to login with steam - this is handled entirely by steamcmd; no code or scripts in this repo **ever** see your steam credentials.

If you want to rebuild the image with the latest version of ARMA 3, run `make clean` first.

### Dependencies

- steamcmd
- docker
- a steam account (doesn't need to own the game)

### Troubleshooting

- You require a steam account because, for whatever reason, the arma 3 dedicated server app on steam cannot be downloaded by the `anonymous` steam account
- If docker reports an error communicating with `docker.sock`, you make need to run the above command as root
- If an error is thrown saying `steamcmd` not found, you need to locate your steamcmd executable (`which steamcmd`) and append it as a variable to the make command:
  `make build USER=<your steam username> STEAMCMD=<your steamcmd location>`
  or:
  `make build USER=<your steam username> STEAMCMD=$(which steamcmd)`

## Disclaimer

The files in this repo are licensed under the AGPL v3.
ARMA 3 is proprietary software owned by [Bohemia Ineractive](https://www.bohemia.net/), no credit is taken for their work.
