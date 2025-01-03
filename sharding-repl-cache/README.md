# Задание 4. Кэширование

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
 - shard1-master
 - shard1-slave1
 - shard1-slave2
 - shard2-master
 - shard2-slave1
 - shard2-slave2
 - mongos_router

**2 Заполение данных
 - 1000

**3 Проверку данных
 - На shard1-master
 - На shard1-slave1
 - На shard1-slave2
 - На shard2-master
 - На shard2-slave1
 - На shard2-slave2

## Если вы запускаете проект на локальной машине

Откройте в браузере 
 - http://localhost:8080
 - http://localhost:8080/docs


