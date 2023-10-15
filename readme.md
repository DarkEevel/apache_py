# Apache-Py

Ein Apache Container mit aktiviertem Python3/CGI auf Ubuntu Basis.

## Usage

Einfach eine docker-compose Datei erstellen und die Config nach belieben bearbeiten.

anschließend mit
```
docker-compose up -d
```
starten.


## Docker-Compose

```
version: '3'
services:
  db:
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: mydatabase
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - //d/docker/mariadb/data:/var/lib/mysql
    ports:
      - "3306:3306"
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

      # !!! ACHTUNG !!!
      # Unter Windows muss für Python Dateien die EOL auf Unix umgestellt werden, ansonsten kann die Datei nicht gelesen werden.
          - //d/docker/apache/data:/var/www/html
      ports:
          - '8080:80' # Port 80 IM Container wird auf Port 8080 AUßERHALB des Containers gemappt. http://localhost:8080/
      image: darkx3/apache_py
```