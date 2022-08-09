FROM confluentinc/cp-server-connect-base:7.2.1

#COPY ./data/ifxjdbc-4.50.3.zip /tmp/ifxjdbc-4.50.3.zip

RUN  confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.5.1

RUN curl https://repo1.maven.org/maven2/com/ibm/informix/jdbc/4.50.8/jdbc-4.50.8.jar --compressed --output /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib/informix-jdbc-4.50.3.jar

# RUN curl https://repo1.maven.org/maven2/com/ibm/informix/jdbc/4.50.8/jdbc-4.50.8.jar --compressed --output /data/connect-jars/informix-jdbc-4.50.3.jar

#RUN curl https://repo1.maven.org/maven2/com/ibm/informix/jdbc/4.50.8/jdbc-4.50.8.jar --compressed --output /usr/share/java/kafka-connect-jdbc/informix-jdbc-4.50.3.jar
    