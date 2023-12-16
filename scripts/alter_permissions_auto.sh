#!/bin/bash

watch_dir="/var/www/html/"

make_executable() {
    permissions=$(stat -c %a $1)

    if [ $permissions != "755" ]; then
        chmod +x "$1"
        echo "Permission changed for file $1" >> /var/tmp/py.log
    else
        echo "Datei $1 ist bereits ausfühbar"
    fi
}

export -f make_executable

find "$watch_dir" -type f -name "*.py" -exec bash -c 'make_executable "$0"' {} \;

inotifywait -m -e modify,create -r --format "%w%f" "$watch_dir" | 
while read file; do
    if [[ "$file" == *.py ]]; then
        sleep 1
        make_executable "$file"
    fi
done