#!/bin/bash

# We create backups around 23:00 UTC, so a backup for today might not exist yet
yesterday=$(date -v -1d '+%Y-%m-%d' 2>/dev/null || date -d "yesterday" '+%Y-%m-%d')
url="https://pub-5200ce7fb4b64b5ea3b6b0b0f05cfcd5.r2.dev/${yesterday}_rating.backup"
curl -o rating.backup "$url"
