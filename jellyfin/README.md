# JellyFin 
Media App to share HDD Movies for casting or viewing

* Application:

* Docker Container: https://hub.docker.com/r/jellyfin/jellyfin

* Installation: https://jellyfin.org/docs/general/installation/container/

* User Guide: https://jellyfin.org/docs/

* Repository: https://github.com/jellyfin/jellyfin

---
### ToDo:
- [ ] To change

---
### Changes:
* 
---
 
### Setup
Docker image:
`docker pull jellyfin/jellyfin`

Steps: 
1. Add Media folder to Docker Desktop
2. Update docker compose with bind information
3. Map it to /media

Open Browser to http://192.168.4.142:8096


Create volume(s) if needed
```
docker volume create jellyfin-config
docker volume create jellyfin-cache
```

Command to start Docker container from CMD:
```
docker run -d \
 --name jellyfin \
 --user uid:gid \
 --net=host \
 --volume /path/to/config:/config \ # Alternatively --volume jellyfin-config:/config
 --volume /path/to/cache:/cache \ # Alternatively --volume jellyfin-cache:/cache
 --mount type=bind,source=/path/to/media,target=/media \
 --restart=unless-stopped \
 jellyfin/jellyfin
```

---
### UI Changes Made

There is an Option to browse folders:
Dashboard -> Libraries -> Display -> Display a folder view to show plain media folders

You can Ignore media folders by adding a .ignore file to the folder you want to ignore.

Keep in mind that jellyfin still relies on the folder structure and naming scheme to identify the media and obtain metadata from external providers. This is how jellyfin works and you are more or less required to structure your media Libraries that way to make jellyfin work as intended.

---
### Notes:
* 