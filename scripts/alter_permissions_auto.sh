#!/bin/bash

inotifywait -m /var/www/html -e create -e moved_to |
    while read dir action file; do
        chmod +x /var/www/html/$file
    done