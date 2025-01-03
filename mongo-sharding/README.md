# Задание 2. Шардирование

## Как запустить

Выполняем
```shell
docker compose up -d
```

## Как проверить

Выполняем
```shell
./scripts/mongo-init.sh
```

Скрипт mongo-init.sh выполняет 
**1 Инициализацию 
 - configSrv
 - shard1
 - shard2
 - mongos_router

**2 Заполение данных
 - 1000

**3 Проверку данных
 - На shard1
 - На shard2

## Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

