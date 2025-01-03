#!/bin/bash

# Инициализируем configSrv
echo -e "\n Инициализируем configSrv"
docker compose exec -T configSrv mongosh --port 27017 --quiet <<EOF
rs.initiate({_id : 'config_server',configsvr:true,members: [{ _id : 0, host : 'configSrv:27017' }]});
EOF

# Инициализируем shard1
echo -e "\n Инициализируем shard1"
docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
rs.initiate({_id : "shard1",members: [{ _id : 0, host : "shard1:27018" }]});
EOF

# Инициализируем shard2
echo -e "\n Инициализируем shard2"
docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
rs.initiate({_id : "shard2",members: [{ _id : 0, host : "shard2:27019" }]});
EOF

# Добавляем шарды в кластер
echo -e "\n Добавляем шарды в кластер"
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
sh.addShard("shard1/shard1:27018");
sh.addShard("shard2/shard2:27019");
EOF

# Заполняем данными данные в бд
echo -e "\n Заполняем данными данные в бд"
docker compose exec -T mongos_router mongosh --port 27020 --quiet <<EOF
use somedb;
sh.enableSharding("somedb");
db.createCollection("helloDoc")
db.helloDoc.createIndex({ "name": "hashed" });
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" });
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i});
db.helloDoc.countDocuments();
EOF

sleep 10
# Проверяем shard1
echo -e "\n Проверяем shard1"
docker compose exec -T shard1 mongosh --port 27018 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

# Проверяем shard2
echo -e "\n Проверяем shard2"
docker compose exec -T shard2 mongosh --port 27019 --quiet <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF