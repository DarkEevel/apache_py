#!/bin/bash

for file in /var/www/html/*; do
    if [[ $file == *.py ]] || [[ $file == *.cgi ]]; then
        chmod +x /var/www/html/$file
    fi
done