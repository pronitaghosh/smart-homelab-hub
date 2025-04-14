
# Obsidian Self-Hosted with LiveSync
Self Hosted Obsidian with Local Storage in Docker container

Building service with notes from Forums

* Application: 

* Docker Container: 

* Installation: 

* User Guide: 

* Repository: 

---
### ToDo
- [ ] To change

---
### Changes 
* http://localhost:5984/_utils/ <-- CouchDB initial Setup URL

* CouchDB Error on Docker logs:
```
[notice] 2025-04-29T21:01:40.587672Z nonode@nohost <0.361.0> -------- chttpd_auth_cache changes listener died because the _users database does not exist. Create the database to silence this notice.


[error] 2025-04-29T21:01:40.588499Z nonode@nohost emulator -------- Error in process <0.1777.0> with exit value:


{database_does_not_exist,[{mem3_shards,load_shards_from_db,[<<"_users">>],[{file,"src/mem3_shards.erl"},{line,445}]},{mem3_shards,load_shards_from_disk,1,[{file,"src/mem3_shards.erl"},{line,420}]},{mem3_shards,load_shards_from_disk,2,[{file,"src/mem3_shards.erl"},{line,449}]},{mem3_shards,for_docid,3,[{file,"src/mem3_shards.erl"},{line,100}]},{fabric_doc_open,go,3,[{file,"src/fabric_doc_open.erl"},{line,38}]},{chttpd_auth_cache,ensure_auth_ddoc_exists,2,[{file,"src/chttpd_auth_cache.erl"},{line,210}]},{chttpd_auth_cache,listen_for_changes,1,[{file,"src/chttpd_auth_cache.erl"},{line,156}]}]}
```

* Create the _users table
```
# Replace "admin" and "password" with your CouchDB credentials created above
curl -u admin:PASSWD -X PUT http://localhost:5984/_users
```

* Create LiveSync API
```
docker run \
 -e hostname=http://localhost \
 -e database=obsidian \
 -e username=admin \
 -e password=PASSWD \
 -e passphrase=PASSPHRASE \
 docker.io/oleduc/docker-obsidian-livesync-couchdb:master \
 deno -A /scripts/generate_setupuri.ts
```
Response:
```
Download https://registry.npmjs.org/octagonal-wheels
Download https://registry.npmjs.org/idb
Download https://registry.npmjs.org/xxhash-wasm
Download https://registry.npmjs.org/octagonal-wheels/-/octagonal-wheels-0.1.11.tgz
Download https://registry.npmjs.org/idb/-/idb-8.0.2.tgz
Download https://registry.npmjs.org/xxhash-wasm/-/xxhash-wasm-0.4.2.tgz
Download https://registry.npmjs.org/xxhash-wasm/-/xxhash-wasm-1.1.0.tgz

Passkey in other local file smart-readme.md : livesync passkey
```

* Create API Key from current running server
```
docker run \
 -e hostname=http://192.168.4.142:5984 \
 -e database=obsidian \
 -e username=admin \
 -e password=PASSWD \
 -e passphrase=PASSPHRASE \
 oleduc/docker-obsidian-livesync-couchdb:master \
 deno -A /scripts/generate_setupuri.ts
```

```
Your passphrase of Setup-URI is:  solitary-shadow
Passkey in other local file smart-readme.md : livesync passkey
```

---
### Setup Steps
1. 

---
### Notes:
* 