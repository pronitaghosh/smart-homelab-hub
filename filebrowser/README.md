# FileBrowser 
Self hosted File Browser to share folder / HDD like drive

* Application: 

* Docker Container: https://hub.docker.com/r/filebrowser/filebrowser

* Installation: https://filebrowser.org/installation

* User Guide: 

* Repository: https://github.com/filebrowser/filebrowser


---
### ToDo
- [ ] To change


---
### Changes 
- converted to docker-compose
- mounted multiple hdd via updating volume binds in compose
- renamed folder which serves storage (srv -> storage)


---
### Setup
File Browser is also available as a Docker image. You can find it on Docker Hub. The usage is as follows:
Docker Image: `docker pull filebrowser/filebrowser`
Sample [`settings.json`](./settings.json)

Steps followed:
1. Change : {HOME}/smart-filebrowser
2. Create Folder for Server storage share
3. Update `docker-compose.yml` volume mounts
4. Update `settings.json` with bind folder name (default: srv)
5. Update `settings.json` with Port (default: 80)
6. Create dummy `filebrowser.db` (touch db/`filebrowser.db`)

#### Docker image run default commands:
For linuxserver (Linux Based tag:s6)
```
docker run \
    -v {HOME}/smart-filebrowser/app:/srv \
    -v {HOME}/smart-filebrowser/db/filebrowser.db:/database/filebrowser.db \
    -v {HOME}/smart-filebrowser/config/settings.json:/config/settings.json \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -p 8080:80 \
    filebrowser/filebrowser:s6
```
For base alpine server (Alpine Based tag:latest)
```
docker run \
    -v /path/to/root:/srv \
    -v /path/filebrowser.db:/database.db \
    -v /path/.filebrowser.json:/.filebrowser.json \
    -u $(id -u):$(id -g) \
    -p 8080:80 \
    filebrowser/filebrowser
```

By default, we already have a configuration file with some defaults so you can just mount the root and the database. Although you can overwrite by mounting a directory with a new config file. If you don't already have a database file, make sure to create a new empty file under the path you specified. Otherwise, Docker will create an empty folder instead of an empty file, resulting in an error when mounting the database into the container.


---
### Notes:
* 