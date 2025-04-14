# Excalidraw (Complete) with Local Storage
Self hosted design System with simple charts and flows
With locally synced and stored files (excalidraw-complete)

Git Repo: https://github.com/PatWie/excalidraw-complete/releases

Latest Release: https://github.com/PatWie/excalidraw-complete/releases/download/0.0.2/excalidraw-complete_Linux_i386.tar.gz

* Application: www.excalidraw.com

* Docker Container: 

* Installation: 

* User Guide: 

* Repository: 

---
### ToDo
- [ ] To change

---
### Changes 
* 

---
### Installation & Setup for Manual

To get started, download the latest release binary:
```
# Visit https://github.com/PatWie/excalidraw-complete/releases/ for the download URL
wget <binary-download-url>
chmod +x excalidraw-complete
./excalidraw-complete
```

Once launched, Excalidraw Complete is accessible at localhost:3002, ready for drawing and collaboration.

### Configuration
Excalidraw Complete adapts to your preferences with customizable storage solutions, adjustable via the STORAGE_TYPE environment variable:

- Filesystem: Opt for `STORAGE_TYPE=filesystem` and define LOCAL_STORAGE_PATH to use a local directory.
- SQLite: Select `STORAGE_TYPE=sqlite` with DATA_SOURCE_NAME for local SQLite storage, including the option for :memory: for ephemeral data.
- AWS S3: Choose `STORAGE_TYPE=s3` and specify S3_BUCKET_NAME to leverage S3 bucket storage, ideal for cloud-based solutions.
These flexible configurations ensure Excalidraw Complete fits seamlessly into your existing setup, whether on-premise or in the cloud.