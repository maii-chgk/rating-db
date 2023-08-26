#!/bin/bash

psql -U postgres -d postgres -c "DROP SCHEMA public CASCADE;" && pg_restore --dbname=postgres --username=postgres /backup/rating.backup
