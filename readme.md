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


## Usage

vorhandene Tags:

`x86`
`arm`

ARM wir für Mac mit M-Chips empfohlen.

einfach eine docker-compose Datei erstellen und die Config nach belieben bearbeiten.

anschließend mit

```
docker-compose up -d
```

starten.


## Docker-Compose

```
version: '3'
services:
  apache2:
      container_name: apache-py
      environment:
          - TZ=Europe/Berlin
      volumes:
      # Mappen des html Ordners nach außen auf das Host System:

      # WSL Beispiel für D:/test
      # //d/test:/var/www/html

      # Ubuntu Beispiel:
      # /home/user/html:/var/www/html

      # Mac Beispiel:
      # /Users/username/Desktop/docker/apache/data

      # !!! ACHTUNG !!!
      # Unter Windows muss für Python Dateien die EOL auf Unix umgestellt werden, ansonsten kann die Datei nicht gelesen werden.
          - //d/docker/apache/data:/var/www/html
      ports:
          - '8080:80' # Port 80 IM Container wird auf Port 8080 AUßERHALB des Containers gemappt. http://localhost:8080/
      image: darkx3/apache_py
```