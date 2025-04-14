
# Immich
Self Hosted Photo organizer 

* Smart Immich - http://localhost:2283/

* Application: https://immich.app/

* Docker Container: 

* Installation: https://immich.app/docs/install/docker-compose/

* User Guide: https://immich.app/docs/install/environment-variables/

* Repository: https://github.com/immich-app/immich

---
### ToDo
- [ ] To change

---
### Changes 
* 

---
### Setup Steps
1. Download Docker Compose & ENV files:
```
wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml

wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
```
2. Update `.env` file with locations of storage
3. Create local directory structure
```
mkdir immich
cd immich
mkdir -p photos thumbs videos profile backups
```
3. Start Docker container with `docker compose up -d`


---
### Notes:
* 