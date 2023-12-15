#!/bin/bash

WATCH_DIR="/var/www/html/"

find "$WATCH_DIR" -type f -name "*.py" -exec chmod +c {} +

# inotifywait starten und rekursiv nach Dateierstellungsereignissen filtern
inotifywait -m -r -e modify,create,moved_to --format "%w%f" "$WATCH_DIR" |
while read newfile
do
    # Nur Dateien mit der Endung .py berücksichtigen
    if [[ "$newfile" == *.py ]]; then
        # Befehl ausführen: chmod +x
        chmod +x "$newfile"
    fi
done