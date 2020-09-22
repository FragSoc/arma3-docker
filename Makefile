USER := anonymous
APPID := 233780
STEAMCMD := /usr/games/steamcmd
SERVER_FILES_TMP := server_files

.PHONY: final_image base_image build clean

build: final_image

clean:
	rm -rf ${SERVER_FILES_TMP}
	docker image rm fragsoc/arma3_pre_install

final_image: base_image ${SERVER_FILES_TMP} Dockerfile.post_install
	docker build -f Dockerfile.post_install -t fragsoc/arma3 .

base_image: Dockerfile.pre_install docker-entrypoint.sh
	docker build -f Dockerfile.pre_install -t fragsoc/arma3_pre_install .

${SERVER_FILES_TMP}:
	mkdir -p ./$@
	${STEAMCMD} +login ${USER} \
		+force_install_dir ${PWD}/$@ \
		+app_update ${APPID} validate \
		+exit
