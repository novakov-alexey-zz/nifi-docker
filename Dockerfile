FROM apache/nifi:1.11.4
#based on https://github.com/apache/nifi/blob/master/nifi-docker/dockerhub/Dockerfile

USER root

# add JDBC drivers
RUN mkdir /lib/jdbc
WORKDIR /lib/jdbc
RUN wget https://download.microsoft.com/download/3/F/7/3F74A9B9-C5F0-43EA-A721-07DA590FD186/sqljdbc_6.2.2.0_enu.tar.gz && \
    tar xvzf sqljdbc_6.2.2.0_enu.tar.gz && \
    cp ./sqljdbc_6.2/enu/mssql-jdbc-6.2.2.jre8.jar ./ && \
    rm sqljdbc_6.2.2.0_enu.tar.gz && \
    rm -r sqljdbc_6.2 && \
    wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.2.10/postgresql-42.2.10.jar && \
    wget https://repo1.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/2.6.0/mariadb-java-client-2.6.0.jar && \
    wget https://repository.apache.org/content/repositories/releases/org/apache/nifi/nifi-hive_1_1-nar/1.11.4/nifi-hive_1_1-nar-1.11.4.nar -O /opt/nifi/nifi-current/lib/nifi-hive_1_1-nar-1.11.4.nar

USER nifi

EXPOSE 8080 8443 10000 8000

WORKDIR ${NIFI_HOME}
ENTRYPOINT ["../scripts/start.sh"]
