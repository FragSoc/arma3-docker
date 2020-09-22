# ARMA 3 Dedicated Server

## Building

Run the command:

```
make build USER=<your steam username>
```

### Dependencies

- steamcmd
- docker

### Troubleshooting

- If docker reports an error communicating with `docker.sock`, you make need to run the above command as root
- If an error is thrown saying `steamcmd` not found, you need to locate your steamcmd executable (`which steamcmd`) and append it as a variable to the make command:
  `make build USER=<your steam username> STEAMCMD=<your steamcmd location>`
  or:
  `make build USER=<your steam username> STEAMCMD=$(which steamcmd)`
