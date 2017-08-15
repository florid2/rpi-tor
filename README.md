# rpi-tor
Tor node for Raspberry PI deployed by Docker

```
docker run -d -v torrc:/etc/tor/torrc -p 9001:9001 florid/rpi-tor:latest
```
