# Apache-Py

Ein Apache Container mit aktiviertem Python3/CGI auf Ubuntu Basis.

## Was ist enthalten

Der auf Ubuntu basierende Container kommt mit folgenden Tools vorinstalliert:

- apache2 + python3-mods
- python3
- inotify-tools
- cron
- nano

`apache2` und `python3` werden für den Webserver benötigt.
Das Image ist darauf ausgelegt, `.py` und `.cgi` Dateien im Webserver abbilden zu können.
Da die Dateien aber ausfürbar sein müssen, enthält dieses Image ein Script, welches neue Dateien, 
welche unter `/var/www/html` angelegt werden, automatisch ausführbar macht. Hierzu wird `inotify-tools` und `cron` benötigt,
um den Ordner zu überwachen und diese Überwachung bei Containerstart auszuführen. 
Geändert werden nur die Berechtigungen für `.py` und `.cgi` Dateien.

Die Container sind lediglich über die Host Maschine erreichbar.
Geräte aus dem Netzwerk können die Container nicht erreichen.
Dies wird ermöglicht, in dem der veröffentlichte Port nur für Localhost exposed wird:

```yaml
ports:
  - "127.0.0.1:8080:80"
```


## Usage

vorhandene Tags:

`x86`

`arm`

ARM wir für Mac mit M-Chips empfohlen.

einfach eine docker-compose Datei erstellen und die Config nach belieben bearbeiten.

anschließend mit

```bash
docker-compose up -d
```

starten.


## Docker-Compose

```yaml
version: '3'
services:
  db:
    network-mode: "host"
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: mydatabase
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - //d/docker/apache_stack/db_data:/var/lib/mysql
    ports:
      - "127.0.0.1:3306:3306"
  apache2:
    network-mode: "host"
    container_name: apache-py
    environment:
        - TZ=Europe/Berlin
    volumes:
        - //d/docker/apache_stack/html_data:/var/www/html       
# Mappen des html Ordners nach außen auf das Host System:

# WSL Beispiel für D:/test
# //d/test:/var/www/html

# Ubuntu Beispiel:
# /home/user/html:/var/www/html

# !!! ACHTUNG !!!
# Unter Windows muss für Python Dateien die EOL auf Unix umgestellt werden, ansonsten kann die Datei nicht gelesen werden.

    ports:
      - '127.0.0.1:8080:80'
# Port 80 IM Container wird auf Port 8080 AUßERHALB des Containers gemappt. http://localhost:8080/
# 127.0.0.1 wird verwendet, damit der Container lediglich auf der Host Maschine und nicht extern erreichbar ist.

    image: darkx3/apache_py:latest
      
# !!! ACHTUNG !!!

# MAC USER mit M1/M2 CPU: 
#image: darkx3/apache:py:arm

# WINDOWS/LINUX USER
#image: darkx3/apache_py:x86
# or
#image: darkx3/apache_py:latest 

```