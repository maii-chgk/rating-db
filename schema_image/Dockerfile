FROM postgres:15
COPY schema_image/pre_restore.sql /docker-entrypoint-initdb.d/01_pre_restore.sql
COPY schema.sql /docker-entrypoint-initdb.d/02_schema.sql
COPY schema_image/post_restore.sql /docker-entrypoint-initdb.d/03_post_restore.sql
