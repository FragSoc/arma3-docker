FROM fragsoc/arma3_pre_install
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

# Setup directory structure and permissions
RUN useradd -m -s /bin/false -u $UID arma
RUN mkdir -p /home/arma/.local/share $CONFIG_LOC $PROFILES_LOC
RUN ln -s $CONFIG_LOC "/home/arma/.local/share/Arma 3"
RUN ln -s $PROFILES_LOC "/home/arma/.local/share/Arma 3 - Other Profiles"
RUN chown -R arma:arma $CONFIG_LOC $PROFILES_LOC

# Copy server files in
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=arma ./server_files $INSTALL_LOC
RUN chmod a+x /docker-entrypoint.sh

# Expose and run
USER arma
WORKDIR $INSTALL_LOC

EXPOSE 2344/udp 2344
EXPOSE 2345
EXPOSE 2302/udp 2303/udp 2304/udp 2305/udp 2306/udp

VOLUME $CONFIG_LOC
VOLUME $PROFILES_LOC
VOLUME $MISSIONS_LOC
VOLUME $MODS_LOC

ENTRYPOINT /docker-entrypoint.sh
