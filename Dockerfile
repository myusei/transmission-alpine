FROM alpine:latest

RUN apk --update add transmission-daemon && rm -rf /var/cache/apk/* && mkdir /torrent && chmod 777 /torrent && mkdir -p /root/.config/transmission-daemon/ && chmod 777 /root/.config/transmission-daemon/

COPY settings.json /root/.config/transmission-daemon/

EXPOSE 9091

ENTRYPOINT /usr/bin/transmission-daemon --foreground