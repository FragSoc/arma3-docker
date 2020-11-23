APPID := 233780
UID := 999
STEAMCMD := /usr/games/steamcmd
SERVER_FILES_TMP := server_files

.PHONY: final_image build clean ${SERVER_FILES_TMP} base_image

build: ${SERVER_FILES_TMP} Dockerfile
	docker build --build-arg UID=${UID} -t fragsoc/arma3 .

clean:
	rm -rf ${SERVER_FILES_TMP}

${SERVER_FILES_TMP}:
	mkdir -p ./$@
	${STEAMCMD} +login ${STEAM_USER} \
		+force_install_dir $(shell pwd -P)/$@ \
		+app_update ${APPID} validate \
		+exit
