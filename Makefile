setup:
	docker compose up -d

down:
	docker compose down --volumes --rmi local

mysql-login:
	docker compose exec mysql mysql -u tecpark -ptecpark -h 127.0.0.1 tecpark

