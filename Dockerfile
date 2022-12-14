FROM alpine:latest
MAINTAINER Mickael Monsieur <mickael.monsieur@gmail.com>

ENV LANG=C.UTF-8
ENV LC_ALL C.UTF-8

RUN set -e \
&& apk add --update --quiet \
         asterisk \
         asterisk-sample-config >/dev/null \
&& asterisk -U asterisk &>/dev/null \
&& sleep 5s \
&& [ "$(asterisk -rx "core show channeltypes" | grep PJSIP)" != "" ] && : \
     || rm -rf /usr/lib/asterisk/modules/*pj* \
&& pkill -9 ast \
&& sleep 1s \
&& truncate -s 0 \
     /var/log/asterisk/messages \
     /var/log/asterisk/queue_log || : \
&& mkdir -p /var/spool/asterisk/fax \
&& chown -R asterisk: /var/spool/asterisk \
&& rm -rf /var/run/asterisk/* \
          /tmp/* \
          /var/tmp/*

RUN apk add nano sngrep
ADD sounds/Robert /var/lib/asterisk/sounds/Robert
ADD asterisk/extensions.conf /etc/asterisk/extensions.conf
ADD asterisk/pjsip.conf /etc/asterisk/pjsip.conf
RUN chown -R asterisk:asterisk /var/lib/asterisk/sounds/Robert
RUN chown asterisk:asterisk /etc/asterisk/extensions.conf
RUN echo '' > /etc/asterisk/extensions.ael
RUN echo 'extensions = { }' > /etc/asterisk/extensions.lua
RUN rm -rf /var/cache/apk/*

EXPOSE 5060/udp 5060/tcp
VOLUME /var/lib/asterisk/sounds /var/lib/asterisk/keys /var/lib/asterisk/phoneprov /var/spool/asterisk /var/log/asterisk

ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
