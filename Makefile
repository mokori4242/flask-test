install:
	@make build
	@make up
	docker compose exec app composer install
	docker compose exec app cp .env.example .env
	docker compose exec app php artisan key:generate
	docker compose exec app php artisan storage:link
	docker compose exec app chmod -R 777 storage bootstrap/cache
	@make fresh
up:
	docker compose up -d
build:
	docker compose build
remake:
	@make destroy
	@make install
stop:
	docker compose stop
down:
	docker compose down --remove-orphans
down-v:
	docker compose down --remove-orphans --volumes
restart:
	@make down
	@make up
destroy:
	docker compose down --rmi all --volumes --remove-orphans
ps:
	docker compose ps
migrate:
	docker compose exec app php artisan migrate
fresh:
	docker compose exec app php artisan migrate:fresh --seed
seed:
	docker compose exec app php artisan db:seed
logs:
	docker compose logs
logs-watch:
	docker compose logs --follow
log-web:
	docker compose logs web
log-web-watch:
	docker compose logs --follow web
log-app:
	docker compose logs app
log-app-watch:
	docker compose logs --follow app
log-db:
	docker compose logs db
log-db-watch:
	docker compose logs --follow db
log-cron:
	docker compose logs cron
log-cron-watch:
	docker compose logs --follow cron
login-app:
	docker compose exec app bash
login-web:
	docker compose exec web ash
login-db:
	docker compose exec db bash
login-cron:
	docker compose exec cron bash
npmrd:
	docker compose exec app npm run dev
composer:
	docker compose exec app composer install
larastan:
	docker compose exec app composer larastan
phpmd:
	docker compose exec app composer phpmd
cs-fixer:
	docker compose exec app composer cs-fixer

