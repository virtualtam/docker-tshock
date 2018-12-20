#!/bin/sh
cd ~tshock
mono \
    --server \
    --gc=sgen \
    -O=all \
    TerrariaServer.exe \
    -configpath /tshock/data/config \
    -logpath /tshock/data/logs \
    -worldpath /tshock/data/worlds \
    -world /tshock/data/worlds/default.wld \
    -autocreate ${TSHOCK_WORLD_SIZE} \
    --stats-optout
