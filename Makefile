USER := anonymous
APPID := 233780
STEAMCMD := /usr/games/steamcmd

.PHONY: final_image all base_image build

all: final_image

final_image: base_image build Dockerfile.post_install
	docker build -f Dockerfile.post_install -t fragsoc/arma3 .

base_image: Dockerfile.pre_install docker-entrypoint.sh
	docker build -f Dockerfile.pre_install -t fragsoc/arma3_pre_install .

build:
	mkdir -p ./$@
	${STEAMCMD} +login ${USER} \
		+force_install_dir ${PWD}/$@ \
		+app_update ${APPID} validate \
		+exit
