#!/bin/bash
logger "A new file has been created: $(date +"%d-%m-%Y-%r")"
touch "$(date +"%d-%m-%Y-%r")" | logger
logger "Find and delete files older than 1 minute in the current directory"
find . -maxdepth 1  -type f -mmin +1 -type f -not -name script.sh -delete -print | logger