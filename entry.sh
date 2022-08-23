#!/bin/bash

mkdir -p "${STEAMAPPDIR}" || true  

${STEAMCMDDIR}/./steamcmd.sh +runscript ${HOMEDIR}/necesse_update

${STEAMAPPDIR}/./StartServer-nogui.sh -world "${WORLD_NAME}"
