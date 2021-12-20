# Docker Image for Lufi

Lufi means Let's Upload that FIle. It's a E2E encrypted file sharing software.

## Owner
The writer of the lufi-software is [Luc Didry](https://framagit.org/fiat-tux/hat-softwares/lufi/) his project is licensed under the GNU Affero General Public License v3.0.

## Installation


### Docker Compose

Please adjust the environment variables in the .docker-compose file then start

```bash
docker-compose build
docker-compose up

```

The build command is optionally

### Docker

Adjust the environment variable and execute the run command

```bash
docker build -t hamzelot/lufi .

docker run -itd \
-e CONTACT_HTML="<a href= 'your-website.eu'>here</a>" \
-e REPORT="name@email.eu" \
-e SITE_NAME="SiteName" \
-v UPLOADED/FILES/LOCATION:/files \
-p 8080:8081 \
 --name lufi hamzelot/lufi
```

The build command is optionally

### Variables

##### CONTACT_HTML 
Put a way to contact you here  
_Default: "\<a href= 'example.com'>here</a>"_
##### REPORT_EMAIL
Put an URL or an email address to receive file reports  
_Default: "abc@example.com"_
##### SITE_NAME 
Name of the instance, displayed next to the logo  
_Default: "lufi"_
##### URL_LENGTH 
The length of the generated links  
_Default: 4_
##### MAX_FILE_SIZE 
The maximum upload size in bytes  
_Default: 104857600_
##### MAX_DEALY 
Number of days after which the files will be deleted, even if they were uploaded with "no delay" (or value superior to max_delay)  
_Default: 0 (no limit)_
##### USE_PROXY 
if you use Lufi behind a reverse proxy like Nginx, you want to set proxy to 1  
_Default: 0_
##### ALLOW_PWD 
Allow to add a password on files, asked before allowing to download files  
_Default: 1_
##### THEME 
Choose a theme. See the available themes in `themes` directory  
Explanation of use below  
_Default: "default"_
##### PROVIS_STEP 
How many URLs will be provisioned in a batch ?  
_Default: 5_
##### PROVISIONING 
Max number of URLs to be provisioned  
_Default: 100_
##### TOKEN_LENGTH 
Length of the modify/delete token  
_Default: 32_
##### PIWIK_IMAGE_TRACKER 
If you want to have piwik statistics, provide a piwik image tracker  
_Default: ""_
##### BROADCAST_MESSAGE 
Broadcast_message which will displayed on the index page  
_Default: ""_
##### LIMIT_FILE_DESTROY_DAYS 
Default time limit for files  
_Default: 0 (no limit)_
##### URL_PREFIX 
URL sub-directory in which you want Lufi to be accessible  
_Default: "/"_
##### FORCE_BURN_AFTER_READING 
Force all files to be in "Burn after reading mode"  
_Default: 0 (disabled, optional)_
##### X_FRAME 
X-Frame-Options header that will be sent by Lufi  
_Default: "DENY"_
##### X_CONTENT_TYPE 
X-Content-Type-Options that will be sent by Lufi  
_Default: "nosniff"_
##### X_XSS_PROTECTION 
X-XSS-Protection that will be sent by Lufi  
_Default: "1; mode=block"_
##### KEEP_IP_DURING 
Number of days senders' IP addresses are kept in database  
_Default: 365_
##### DELETE_NO_LONGER_VIEWED_FILES_DAYS 
Files which are not viewed since delete_no_longer_viewed_files days will be deleted by the cron cleanfiles task  
_Default: (no default, optional)_

## Own Themes

For a custom theme, you need to create a volume. This must point to the `/lufi/themes` folder. 

After that you can copy your theme into the container with 
`docker cp /PATH/TO/THEME lufi:/lufi/themes/`, after editing the variable with the name of the theme restart the container

Alternatively, of course, the selected storage area may already contain the theme.

##### docker-compose volume

``` bash
    volumes:
      - "data:/files"
      - "themes:/lufi/themes"
    environment:
      THEME: "NAMEOFTHEME"
```

##### docker volume

Add the `-v THEMES/FILES/LOCATION:/lufi/themes -e THEME="NAMEOFTHEME"` suffix to the command in the Docker header.


## Access

Access is now via http://SERVER_IP:8080.

## TLS Proxy

How to use a Nginx or Apache proxy is described [here](https://framagit.org/fiat-tux/hat-softwares/lufi/-/wikis/installation#reverse-proxies).

!Important! Set the environment variable "USE_PROXY" to 1
