FROM arigaio/atlas:latest

COPY ./migrations /migrations

CMD ["migrate", "apply", "--url", "mysql://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}"]
