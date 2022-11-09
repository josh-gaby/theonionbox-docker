# theonionbox-docker
This docker provides a simple way to run [The Onion Box](https://github.com/ralphwetzel/theonionbox)

The Onion Box provides a web interface to monitor the operation of a Tor node. It is able to monitor any Tor node operated as relay, as bridge and even as client - as long as it can establish a connection to the node and authenticate successfully.

The connection to the Tor node to be monitored must have either a ControlSocket or a ControlPort enabled. Advanced users may establish a connection via the Tor network to a node proving access to it's ControlPort by means of a Hidden Service - supporting on demand as well Hidden Service Client Authorization.

The Onion Box supports whatever authentication method the Tor node provides.

A single instance of The Onion Box is able to provide monitoring functionality for as many nodes as you like.

Above that, The Onion Box is able to display Tor network status protocol data for any Tor node known by Onionoo.

### Quickstart - The Onion Box in minutes

#### Prerequisites:
- A Tor Relay with it's ControlPort enabled on 0.0.0.0:9051 (listening for connections outside of localhost is not usually recommended but if you aren't forwarding the port on your router you should be fine)
- Docker installed.

Create a directory for your config file and download a copy of the default config file:
```
mkdir -vp theonionbox && \
wget https://raw.githubusercontent.com/josh-gaby/theonionbox/master/Docker/theonionbox.cfg -O theonionbox/tob.cfg
```

Edit the config file and update the [Tor] section to point to your main tor relay, you will be able setup more relay nodes from the web interface once its running.
```
control = port
host = 192.168.1.7   # your tor relays ip
port = 9051          # your tor relays ControlPort as set in its torrc
```

Run the docker
```
docker run -d --init --name=theonionbox --net=host \
-e cc_enabled=true \
-v $PWD/theonionbox/tob.cfg:/theonionbox-config/theonionbox.cfg \
--restart=always joshgaby/theonionbox
```
