
#Para eliminar los connectors...
echo "Primero elimine los connectors si ya estaban registrados..."
echo ""
curl -X DELETE localhost:8083/connectors/informix-sql-source
curl -X DELETE localhost:8083/connectors/informix-postgres-sql-sink
curl -X DELETE localhost:8083/connectors/informix-sql-source-timestamp
curl -X DELETE localhost:8083/connectors/informix-postgres-sql-sink-timestamp

# PARA TABLA TEST
echo ""
echo "Crear SOURCE connector para Informix..."
echo ""
#Crear source connector para Informix
curl -X POST -H "Content-Type":"application/json" -d '{"name":"informix-sql-source","config":{"connector.class":"io.confluent.connect.jdbc.JdbcSourceConnector","tasks.max": "1","connection.url":"jdbc:informix-sqli://informix:9088/testdb:informixserver=informix;user=informix;password=in4mix","query":"select * from test ","incrementing.column.name":"id","topic.prefix":"test","poll.interval.ms":"100000","mode":"incrementing"}}' http://localhost:8083/connectors

echo ""
#Listando connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1

#Crear sink connector para Informix hacia PostgreSQL
echo ""
echo "Crear SINK connector para Informix hacia PostgreSQL..."
echo ""
curl -X POST -H "Content-Type: application/json" -d '{"name":"informix-postgres-sql-sink","config":{"connector.class":"io.confluent.connect.jdbc.JdbcSinkConnector","tasks.max":"1","connection.url":"jdbc:postgresql://postgres:5432/postgres","connection.user":"postgres","connection.password":"postgres","topics":"test","mode":"upsert","table.name.format":"test","pk.mode":"record_value","pk_fields":"record_value","pk.fields":"id","auto.create":"true","auto.evolve":"true"}}' http://localhost:8083/connectors

echo ""
#Listar connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1

# PARA TABLA TEST_INCREM
echo ""
echo "Crear SOURCE connector para Informix (incrementing+timestamp)..."
echo ""
#Crear source connector para Informix (incrementing+timestamp)
curl -X POST -H "Content-Type":"application/json" -d '{"name":"informix-sql-source-timestamp","config":{"connector.class":"io.confluent.connect.jdbc.JdbcSourceConnector","tasks.max":"1","connection.url":"jdbc:informix-sqli://informix:9088/testdb:informixserver=informix;user=informix;password=in4mix","query":"select * from test_increm ","topic.prefix":"test_increm","poll.interval.ms":"30000","mode":"timestamp+incrementing","schema.pattern":"informix","timestamp.column.name":"update_ts","incrementing.column.name":"id","validate.non.null":false}}' http://localhost:8083/connectors

echo ""
#Listando connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1

#Crear sink connector para Informix hacia PostgreSQL (incrementing+timestamp)
echo ""
echo "Crear SINK connector para Informix hacia PostgreSQL (incrementing+timestamp)..."
echo ""
curl -X POST -H "Content-Type: application/json" -d '{"name":"informix-postgres-sql-sink-timestamp","config":{"connector.class":"io.confluent.connect.jdbc.JdbcSinkConnector","tasks.max":"1","connection.url":"jdbc:postgresql://postgres:5432/postgres","connection.user":"postgres","connection.password":"postgres","topics":"test_increm","insert.mode":"UPSERT","db.timezone":"UTC","table.name.format":"test_increm","pk.mode":"record_value","pk.fields":"id","auto.create":"true","auto.evolve":"true"}}' http://localhost:8083/connectors

echo ""
#Listar connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1


#Chequear el STATUS de los connector
echo ""
echo "Check informix-sql-source connector status..."
echo ""
curl -s "http://localhost:8083/connectors/informix-sql-source/status"
echo ""
echo "Check informix-postgres-sql-sink connector status..."
echo ""
curl -s "http://localhost:8083/connectors/informix-postgres-sql-sink/status"
echo ""

echo ""
echo "Check informix-sql-source-timetamp connector status..."
echo ""
curl -s "http://localhost:8083/connectors/informix-sql-source-timestamp/status"
echo ""

echo ""
echo "Check informix-postgres-sql-sink-timestamp connector status..."
echo ""
curl -s "http://localhost:8083/connectors/informix-postgres-sql-sink-timestamp/status"
echo ""