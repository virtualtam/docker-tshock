FROM mono:5

LABEL maintainer VirtualTam

# Worlds
ENV TSHOCK_WORLD_SIZE 2

# Build options
ARG TSHOCK_VERSION="4.3.25"
ENV DEBIAN_FRONTEND non-interactive

RUN apt-get update \
    && apt-get install -y unzip \
    && curl -L https://github.com/Pryaxis/TShock/releases/download/v$TSHOCK_VERSION/tshock_$TSHOCK_VERSION.zip -o /tmp/tshock.zip \
    && unzip /tmp/tshock.zip -d /tshock \
    && rm /tmp/tshock.zip \
    && apt remove -y unzip \
    && apt-get clean

RUN mkdir -p \
        /tshock/data/config \
        /tshock/data/logs \
        /tshock/data/worlds

COPY docker-entrypoint.sh /usr/local/bin/
COPY config.json /tshock/data/config/config.json

RUN adduser --quiet --disabled-password --home /tshock tshock \
    && chown -R tshock:tshock /tshock

USER tshock
WORKDIR /tshock

# Game port
EXPOSE 7777

# REST API port
EXPOSE 7878

VOLUME /tshock/data/config
VOLUME /tshock/data/logs
VOLUME /tshock/data/worlds

CMD ["docker-entrypoint.sh"]
