FROM steamcmd/steamcmd
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ARG APPID=233780
ARG UID=999

ENV CONFIG_LOC="/config"
ENV PROFILES_LOC="/profiles"
ENV MODS_LOC="/mods"
ENV MISSIONS_LOC="/missions"
ENV INSTALL_LOC="/arma"

USER root

# Game appears to require ifconfig
RUN apt-get update && \
    apt-get install --no-install-recommends -y net-tools rename

# Setup directory structure and permissions
RUN useradd -m -s /bin/false -u $UID arma && \
    mkdir -p /home/arma/.local/share $CONFIG_LOC $PROFILES_LOC $MODS_LOC $MISSIONS_LOC && \
    ln -s $CONFIG_LOC "/home/arma/.local/share/Arma 3" && \
    ln -s $PROFILES_LOC "/home/arma/.local/share/Arma 3 - Other Profiles" && \
    chown -R arma:arma $CONFIG_LOC $PROFILES_LOC

# Copy server files in
COPY --chown=arma ./server_files $INSTALL_LOC
RUN rm -rf $INSTALL_LOC/mpmissions && \
    ln -s $MISSIONS_LOC $INSTALL_LOC/mpmissions && \
    ln -s $MODS_LOC $INSTALL_LOC/mods
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./install-mods.sh /usr/bin/install-mods
RUN chmod a+x /docker-entrypoint.sh /usr/bin/install-mods

# Expose and run
USER arma
ENV HOME="/arma"
WORKDIR $INSTALL_LOC

EXPOSE 2344/udp 2344 2345
EXPOSE 2302/udp 2303/udp 2304/udp 2305/udp 2306/udp

VOLUME $CONFIG_LOC $PROFILES_LOC $MISSIONS_LOC $MODS_LOC

ENTRYPOINT /docker-entrypoint.sh
