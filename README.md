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
-v UPLOADED/FILES/LOCATION:/usr/lufi/files \
-p 8080:8081 \
 --name lufi hamzelot/lufi
```

The build command is optionally

### Variables

##### CONTACT_HTML [STRING]
Put a way to contact you here  
_Default: "\<a href= 'example.com'>here</a>"_
##### REPORT_EMAIL [STRING]
Put an URL or an email address to receive file reports  
_Default: "abc@example.com"_
##### SITE_NAME [STRING]
Name of the instance, displayed next to the logo  
_Default: "lufi"_
##### URL_LENGTH [NUMBER]
The length of the generated links  
_Default: 4_
##### MAX_FILE_SIZE [NUMBER]
The maximum upload size in bytes  
_Default: 104857600 (100MBytes)_
##### MAX_DEALY [NUMBER]
Number of days after which the files will be deleted, even if they were uploaded with "no delay" (or value superior to max_delay)  
_Default: 0 (no limit)_
##### USE_PROXY [NUMBER]
if you use Lufi behind a reverse proxy like Nginx, you want to set proxy to 1  
_Default: 0_
##### ALLOW_PWD [NUMBER]
Allow to add a password on files, asked before allowing to download files  
_Default: 1_
##### THEME [STRING]
Choose a theme. See the available themes in `themes` directory  
Explanation of use below  
_Default: "default"_
##### PROVIS_STEP [NUMBER]
How many URLs will be provisioned in a batch ?  
_Default: 5_
##### PROVISIONING [NUMBER]
Max number of URLs to be provisioned  
_Default: 100_
##### TOKEN_LENGTH [NUMBER]
Length of the modify/delete token  
_Default: 32_
##### PIWIK_IMAGE_TRACKER [STRING]
If you want to have piwik statistics, provide a piwik image tracker  
_Default: (no default, optional)_
##### BROADCAST_MESSAGE [STRING]
Broadcast_message which will displayed on the index page  
_Default: (no default, optional)_
##### LIMIT_FILE_DESTROY_DAYS [NUMBER]
Default time limit for files  
_Default: 0 (no limit)_
##### URL_PREFIX [STRING]
URL sub-directory in which you want Lufi to be accessible  
_Default: "/"_
##### FORCE_BURN_AFTER_READING [NUMBER]
Force all files to be in "Burn after reading mode"  
_Default: 0 (disabled, optional)_
##### X_FRAME [STRING]
X-Frame-Options header that will be sent by Lufi  
_Default: "DENY"_
##### X_CONTENT_TYPE [STRING]
X-Content-Type-Options that will be sent by Lufi  
_Default: "nosniff"_
##### X_XSS_PROTECTION [STRING]
X-XSS-Protection that will be sent by Lufi  
_Default: "1; mode=block"_
##### KEEP_IP_DURING [NUMBER]
Number of days senders' IP addresses are kept in database  
_Default: 365_
##### DELETE_NO_LONGER_VIEWED_FILES_DAYS [NUMBER]
Files which are not viewed since delete_no_longer_viewed_files days will be deleted by the cron cleanfiles task  
_Default: (no default, optional)_
##### WORKER [NUMBER]
Number of worker processes
_Default: 30_
##### CLIENTS [NUMBER]
Maximum number of accepted connections each worker process
_Default: 1_
##### DELAY_FOR_SIZE [HASHTABLE]
Size thresholds: if you want to define max delays for different sizes of file
_Default (no default, optional)_
``` yaml
    environment:
      DELAY_FOR_SIZE: >-
        10000000 => 90,
        50000000 => 60, 
        1000000000 => 2
``` 
between 10MB and 50MB => max is 90 days, less than 10MB => max is max_delay (see above)
between 50MB ans 1GB  => max is 60 days
more than 1GB         => max is 2 days
##### ABUSE [HASHTABLE]
Abuse reasons
Set an integer in the abuse field of a file in the database and it will not be downloadable anymore
The reason will be displayed to the downloader, according to the reasons you will configure here.
_Default (no default, optional)_
``` yaml
    environment:
      ABUSE: >-
        0 => 'Copyright infringment',
        1 => 'Illegal content',
```
##### ALLOWED_DOMAINS [ARRAY]
Array of authorized domains for API calls.
_Default (no default, optional)_
##### FIXED_DOMAIN [STRING]
If set, the files' URLs will always use this domain
_Default (no default, optional)_
##### DISABLE_MAIL_SENDING [NUMBER]
Disable sending mail through the server
_Default 1_
##### MAIL_SENDER [STRING]
Email sender address
_Default (no default, optional)_
##### MAIL
 [HASHTABLE]
Mail configuration
See https://metacpan.org/pod/Mojolicious::Plugin::Mail#EXAMPLES
_Default (no default, optional)_
``` yaml
    environment:
      MAIL: >-
        how => 'smtp',
        howargs => ['smtp.example.org']
```
Valid values are 'sendmail' and 'smtp'

## Own Themes

For a custom theme, you need to create a volume. This must point to the `/usr/lufi/themes` folder. 

After that you can copy your theme into the container with 
`docker cp /PATH/TO/THEME lufi:/usr/lufi/themes/`, after editing the variable with the name of the theme restart the container

Alternatively, of course, the selected storage area may already contain the theme.

##### docker-compose volume

``` bash
    volumes:
      - "data:/usr/lufi/files"
      - "themes:/usr/lufi/themes"
    environment:
      THEME: "NAMEOFTHEME"
```

##### docker volume

Add the `-v THEMES/FILES/LOCATION:/usr/lufi/themes -e THEME="NAMEOFTHEME"` suffix to the command in the Docker header.


## Access

Access is now via http://SERVER_IP:8080.

## TLS Proxy

How to use a Nginx or Apache proxy is described [here](https://framagit.org/fiat-tux/hat-softwares/lufi/-/wikis/installation#reverse-proxies).

!Important! Set the environment variable "USE_PROXY" to 1
