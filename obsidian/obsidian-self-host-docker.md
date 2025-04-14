
- Docker CE Portainer host to host this service and serve it using an Nginx reverse proxy
- Obsidian LiveSync
- CouchDB
- Reverse Proxy - NGINX
- [Obsidian WebSever](https://docs.linuxserver.io/images/docker-obsidian/)


- Reddit - [guide_obsidian_with_free_selfhosted_instant_sync](https://www.reddit.com/r/selfhosted/comments/1eo7knj/guide_obsidian_with_free_selfhosted_instant_sync/)
- Medium - [Setup Self Hosted Sync for Obsidian](https://leduccc.medium.com/setup-self-hosted-synchronization-for-obsidian-cba121166d5e)
- Blackvoid - [Obsidian running sync engine via Docker](https://www.blackvoid.club/obsidian-running-sync-engine-via-docker/)

## Setup self-hosted synchronization for Obsidian

The SaaS sync feature for Obsidian is rather expensive at $5 USD per month for a single vault and a tiny 1GB storage limit (However, do get the 25$ support package, the devs need your support). As such, in this guide, we will set up the free community version of LiveSync, which consists of a client plugin working in tandem with a self-hosted CouchDB instance.

As with all my other self-hosted services, we will be using a Docker CE Portainer host to host this service and serve it using an Nginx reverse proxy.

Finally, to facilitate this setup, I made a Docker image to run CouchDB with the appropriate configuration for obsidian-livesync. The original plugin author serves the configuration via a bash script, which has to be run at runtime, and the process is a bit convoluted. This Docker image abstracts all of that. It can be found [here](https://github.com/oleduc/docker-obsidian-livesync-couchdb/tree/master).

Prerequisites
- A Linux host
- Portainer
- Docker CE with Docker Compose
- A registered domain name
- Nginx Proxy Manager

CouchDB
First, we need to add a new stack in Portainer and populate it with a Docker Compose configuration for our CouchDB instance.

```
version: "3.8"

services:
  couchdb-obsidian-livesync:
    image: docker.io/oleduc/docker-obsidian-livesync-couchdb:master
    container_name: couchdb-obsidian-livesync
    restart: always
    environment:
      SERVER_URL: ${SERVER_URL}
      COUCHDB_USER: ${COUCHDB_USER}
      COUCHDB_PASSWORD: ${COUCHDB_PASSWORD}
      COUCHDB_DATABASE: ${COUCHDB_DATABASE}
    ports:
      - "${COUCHDB_PORT:-5984}:5984"
    volumes:
      - ${COUCHDB_DATA}:/opt/couchdb/data
```

Once you have pasted this configuration in the editor, you can now add the following environment variables via the Portainer GUI.

```
SERVER_URL: This is the complete URL that will be used to serve the CouchDB instance. Example: `https://obsidian.example.com`
COUCHDB_USER: The administrator user that will be used to manage your CouchDB instance. Example: `obsidian`
COUCHDB_PASSWORD: The password for the CouchDB admin user.
COUCHDB_DATABASE: The name of the database within CouchDB that will be used to contain your sync data for Obsidian.
COUCHDB_DATA: An existing path on your host’s filesystem where the CouchDB data will be saved. This folder will have to be backed up regularly to safeguard your notes.
```

### Portainer stack configuration
Confirm that your CouchDB application is running and has been correctly configured by navigating to the host IP on the CouchDB port. Log in and confirm that your settings have been applied.

Example: `http://192.168.2.1:5941/_utils`


Confirm that the following settings were applied (note that exact values may change over time):

```
enable_cors = true
max_http_request_size = 4294967296
max_document_size = 50000000
require_valid_user = true
origins = app://obsidian.md,capacitor://localhost,http://localhost
WWW-Authenticate = Basic realm=\”couchdb\”
```

### Create the _users table
The container expects the _user table to exist on your couchDB instance otherwise it will continuously throw errors you can create it with a call to CouchDB’s API via curl.

```
# Replace "admin" and "password" with your CouchDB credentials created above
curl -u admin:password -X PUT http://localhost:5984/_users 
```

### Reverse proxy setup
If you want to use the mobile version of Obsidian, you will need to serve CouchDB via HTTPS with a valid certificate. The easiest way to achieve this is by using Let’s Encrypt in conjunction with Nginx Proxy Manager, which provides a nice tabular interface to easily configure reverse proxies. Please refer to my host setup guide for the configuration guide for Portainer, Nginx, and Let’s Encrypt.

Add the Upstream to Nginx Proxy Manager
First add your upstream.


Then enable SSL by requesting a new SSL certificate for your domain.


Make sure that your reverse proxy is working correctly by navigating to your domain. JSON data should be returned after you enter your login details.

And voilà! Your CouchDB instance should be ready to go!

### Generating your setup URL
Now that your CouchDB instance is up and running, we need to configure your devices. The plugin author chose to use setup URLs, which have to be generated using a script that they made. The script is included in the same Docker container that you used to setup your service and can be run with the following command on any Docker-compatible container runner. Simply pass the same environment variables values that you used in your Portainer stack and the correct setup URL will be generated.

```
docker run \
 -e hostname=https://example.com \
 -e database=obsidiannotes \
 -e username=johndoe \
 -e password=abc123 \
 -e passphrase=dfsapkdjaskdjasdas \
 docker.io/oleduc/docker-obsidian-livesync-couchdb:master \
 deno -A /scripts/generate_setupuri.ts
```

Here is the mapping for the environment variables:
- SERVER_DOMAIN -> hostname
- COUCHDB_USER -> username
- COUCHDB_PASSWORD -> password
- COUCHDB_DATABASE -> database
- passphrase -> This one is new and can be set to an arbitrary value. Make sure to save it, as you will need it each time you want to add a new device.

### Configuring your clients
First, start with a single instance, ideally on desktop. Make sure to back up your vault if you have existing data, as it is very easy to select the wrong option and wipe your vault when setting up LiveSync.

First, use `CTRL+P` to open the command shortcut. Search for “Settings”.


Then, go to “Community Plugins” and click the button to enable them. Then, click the “Browse” button.


Then, search for “Self-hosted LiveSync” and click “Install.” Once the installation is complete, click “Enable” and then follow the wizard.

First, paste your encrypted setup URL.
Then, paste the passphrase you passed to the setup URL script.
Then, follow the rest of the wizard.
The entire procedure is shown in this video: https://youtu.be/7sa_I1832Xc?si=hnQanWYalbPZzIje&t=128

