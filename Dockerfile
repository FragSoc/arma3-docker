FROM steamcmd/steamcmd AS steambuild
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ARG APPID=233780
ARG UID=999
ARG STEAM_LOGIN=anonymous

ENV INSTALL_LOC "/arma"
ENV CONFIG_LOC "/config"
ENV PROFILES_LOC "/profiles"

USER root

# Upgrade the system
RUN apt update
RUN apt upgrade --assume-yes

# Setup directory structure and permissions
RUN useradd -m -s /bin/false -u $UID arma
RUN mkdir -p $INSTALL_LOC /home/arma/.local/share $CONFIG_LOC $PROFILES_LOC
RUN ln -s $CONFIG_LOC "/home/arma/.local/share/Arma 3"
RUN ln -s $PROFILES_LOC "/home/arma/.local/share/Arma 3 - Other Profiles"
RUN chown -R arma:arma $INSTALL_LOC $CONFIG_LOC $PROFILES_LOC

# Install the arma server
RUN steamcmd \
    +login $STEAM_LOGIN \
    +force_install_dir $INSTALL_LOC \
    +app_update $APPID validate \
    +quit

COPY docker-entrypoint.sh /docker-entrypoint.sh

# Expose and run
USER arma
WORKDIR $INSTALL_LOC

EXPOSE 2344/udp 2344
EXPOSE 2345
EXPOSE 2302/udp 2303/udp 2304/udp 2305/udp 2306/udp

VOLUME $CONFIG_LOC
VOLUME $PROFILES_LOC

ENTRYPOINT /docker-entrypoint.sh
