FROM alpine:latest

ARG config_dir="/root/.config/transmission-daemon"
ARG settings_file="$config_dir/settings.json"

RUN apk --update add transmission-daemon && \
    rm -rf /var/cache/apk/*
# dump-settings option will be output to standard error.
RUN /usr/bin/transmission-daemon --dump-settings 2> "/root/settings.json"
# Creating the 'config' directory in advance causes, the 'dump-settings' option output NULL.
# Because transmission to attempt to read the empty config directory.
RUN mkdir /torrent && \
    chmod 666 /torrent && \
    mkdir -p $config_dir && \
    chmod 666 $config_dir && \
    mv /root/settings.json $settings_file
RUN sed -i 's/"rpc-whitelist-enabled": [^,]*/"rpc-whitelist-enabled": false/' $settings_file && \
    sed -i 's/"rpc-host-whitelist-enabled": [^,]*/"rpc-host-whitelist-enabled": false/' $settings_file && \
    sed -i 's/"download-dir": [^,]*/"download-dir": "\/torrent"/' $settings_file && \
    sed -i 's/"incomplete-dir": [^,]*/"download-dir": "\/torrent"/' $settings_file && \
    sed -i 's/"speed-limit-up": [^,]*/"speed-limit-up": 100/' $settings_file && \
    sed -i 's/"speed-limit-up-enabled": [^,]*/"speed-limit-up-enabled": true/' $settings_file && \
    sed -i 's/"upload-slots-per-torrent": [^,]*/"upload-slots-per-torrent": 0/' $settings_file

EXPOSE 9091

ENTRYPOINT /usr/bin/transmission-daemon --foreground