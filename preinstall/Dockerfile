FROM steamcmd/steamcmd
MAINTAINER Ryan Smith <fragsoc@yusu.org>
MAINTAINER Laura Demkowicz-Duffy <fragsoc@yusu.org>

ARG APPID=233780
ARG UID=999

ENV CONFIG_LOC="/config"
ENV PROFILES_LOC="/profiles"

USER root

# Upgrade the system
RUN apt update
RUN apt upgrade --assume-yes

# Setup directory structure and permissions
RUN useradd -m -s /bin/false -u $UID arma
RUN mkdir -p /home/arma/.local/share $CONFIG_LOC $PROFILES_LOC
RUN ln -s $CONFIG_LOC "/home/arma/.local/share/Arma 3"
RUN ln -s $PROFILES_LOC "/home/arma/.local/share/Arma 3 - Other Profiles"
RUN chown -R arma:arma $CONFIG_LOC $PROFILES_LOC

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh
