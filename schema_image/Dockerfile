FROM postgres:15
COPY pre_restore.sql /docker-entrypoint-initdb.d/01_pre_restore.sql
COPY ../schema.sql /docker-entrypoint-initdb.d/02_schema.sql
COPY post_restore.sql /docker-entrypoint-initdb.d/03_post_restore.sql
