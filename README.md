# Transmission BitTorrent on alpine linux
 
## build docker image
> docker build -t transmission .

## start container
> docker run -d -v &lt;download directory&gt;:/torrent -p &lt;rpc port&gt;:9091 transmission

## How to use
Access to localhost:9091 with your web browser.