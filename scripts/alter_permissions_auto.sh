#!/bin/bash

inotifywait -m /var/www/html -e create -e moved_to |
    while read dir action file; do
        if [[ $file == *.py ]] || [[ $file == *.cgi ]]; then
            chmod +x /var/www/html/$file
        fi
    done