FROM postgres:15
COPY schema.sql /docker-entrypoint-initdb.d/
