FROM arigaio/atlas:latest-alpine

COPY . /migrations

# デフォルトだとatlasになり変数展開できないので上書きする
ENTRYPOINT ["/bin/sh", "-c"]

CMD ["atlas migrate apply --url mysql://$MYSQL_USER:$MYSQL_PASSWORD@$MYSQL_HOST:$MYSQL_PORT/$MYSQL_DATABASE"]
