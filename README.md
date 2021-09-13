# Transmission BitTorrent on alpine linux
 
## build docker image
> docker build -t transmission .

## start container
> docker run -d -v <download directory>:/torrent -p <rpc port>:9091 transmission

