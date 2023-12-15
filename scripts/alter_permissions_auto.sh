#!/bin/bash

WATCH_DIR="/var/www/html"

# inotifywait starten und rekursiv nach Dateierstellungsereignissen filtern
inotifywait -m -r -e create -e moved_to --format "%w%f" "$WATCH_DIR" |
while read file
do
    # Nur Dateien mit der Endung .py berücksichtigen
    if [[ "$file" == *.py ]] || [[ $file == *.cgi ]]; then
        # Befehl ausführen: chmod +x
        chmod +x "$file"
        echo "Datei $file wurde ausführbar gemacht."
    fi
done