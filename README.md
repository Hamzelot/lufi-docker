# Docker Image for Lufi

Lufi means Let's Upload that FIle. It's a E2E encrypted file sharing software.

## Owner
The writer of the lufi-software is [Luc Didry](https://framagit.org/fiat-tux/hat-softwares/lufi/) his project is licensed under the GNU Affero General Public License v3.0.

## Installation

Create the Docker Image

```bash
docker build -t lufi .
```
Now, start it!

```bash
docker run -itd \
-e contact="<a href= 'your-website.eu'>here</a>" \
-e report="name@email.eu" \
-e site_name="SiteName" \
-e url_length=4 \
-e max_file_size=104857600 \
-e max_delay=180 \
-v UPLOADED/FILES/LOCATION:/files \
-p 8080:8081 \
 --name LUFI lufi
```

##### url_length
The length of the generated links
##### max_file_size
The maximum upload size in bytes
##### max_delay
The maximum duration until the uploaded files are deleted

## Access

Access is now via http://SERVER_IP:8080.

## TLS Proxy

How to use a Nginx proxy is described [here](https://framagit.org/fiat-tux/hat-softwares/lufi/-/wikis/installation#reverse-proxies).
