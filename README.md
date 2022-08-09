# Pasos para demo de replica de una db INFORMIX hacia una db PostgreSQL
### Iniciar los containers.

` docker-compose up -d `

### Ingresar a Control Center para visualizar las configuraciones y los mensajes del Topic

[Confluent - Control Center][http://localhost:9021/clusters]

### Crear la DB "testdb", la tabla "test" y su secuencia en Informix

` docker-compose exec informix bash -c '/docker-entrypoint-initdb.d/esquema.sh' `

### Registrar kafka Source y Sink connectors con el container connect.

` docker-compose exec connect bash -c '/docker-entrypoint-initdb.d/connectors.sh' `

### Nota: esto crea un conector de origen (Informix) y un conector receptor (PostgreSQL).

### Conectarse a la DB de Informix para insertar los registros en la tabla "test"

` docker-compose exec informix bash -c '/docker-entrypoint-initdb.d/insert.sh' `

### Conectarse a la DB de PostgreSQL y verificar que se haya generado la tabla y los registros insertados en la DB de Informix.

` docker-compose exec postgres bash -c '/docker-entrypoint-initdb.d/select' `

### Eliminar todos los containers

` docker-compose down -v `


## Información acerca de parámetros de los conectores SOURCE
https://docs.confluent.io/kafka-connect-jdbc/current/source-connector/index.html
https://docs.confluent.io/kafka-connect-jdbc/current/source-connector/source_config_options.html

## Información acerca de parámetros del conector SINK (PostgreSQL)
https://docs.confluent.io/cloud/current/connectors/cc-postgresql-sink.html