FROM cm2network/steamcmd:root

LABEL maintainer=""

# CRON
RUN apt-get update && apt-get -y install cron
COPY necesse-cron /etc/cron.d/necesse-cron
RUN chmod 0644 /etc/cron.d/necesse-cron
RUN crontab /etc/cron.d/necesse-cron
RUN touch /var/log/cron.log

ENV STEAMAPPID 1169370
ENV STEAMAPP necesse
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV WORLD_NAME "MyWorld"

COPY entry.sh ${HOMEDIR}
COPY necesse_update ${HOMEDIR}

RUN set -x \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& chmod 755 "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& chown "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

# User is 'steam'
USER ${USER}
WORKDIR ${HOMEDIR}

CMD ["./entry.sh"]

# Expose ports
EXPOSE 14159/udp