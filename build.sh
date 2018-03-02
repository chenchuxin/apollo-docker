#!/bin/sh

echo "==== starting to build config-service and admin-service ===="
mvn clean package -DskipTests -pl apollo-configservice,apollo-adminservice -am -Dapollo_profile=github -Dspring_datasource_url=jdbc:mysql://localhost:3306/ApolloConfigDB?characterEncoding=utf8 -Dspring_datasource_username=root

echo "==== starting to build portal ===="
mvn clean package -DskipTests -pl apollo-portal -am -Dapollo_profile=github,auth -Dspring_datasource_url=jdbc:mysql://localhost:3306/ApolloPortalDB?characterEncoding=utf8 -Dspring_datasource_username=root -Ddev_meta=http://localhost:8080