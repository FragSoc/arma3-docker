# ARMA 3 Dedicated Server

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
