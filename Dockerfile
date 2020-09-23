FROM fragsoc/arma3_pre_install
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ENV INSTALL_LOC="/arma"

COPY --chown=arma ./server_files $INSTALL_LOC

# Expose and run
USER arma
WORKDIR $INSTALL_LOC

EXPOSE 2344/udp 2344
EXPOSE 2345
EXPOSE 2302/udp 2303/udp 2304/udp 2305/udp 2306/udp

VOLUME $CONFIG_LOC
VOLUME $PROFILES_LOC

ENTRYPOINT /docker-entrypoint.sh