FROM maven:3.5-jdk-8-alpine AS build
LABEL Author="chenchuxin <idesireccx@gmail.com>"
ARG version=0.10.2
ARG package_name=apollo-${version}.tar.gz
COPY build.sh /scripts/ 
WORKDIR /src
RUN wget -c https://github.com/ctripcorp/apollo/archive/v0.10.2.tar.gz -O ${package_name} \
    && tar zxf ${package_name} --strip-components=1 \
    && cp /scripts/build.sh scripts/ \
    && chmod 777 scripts/build.sh
RUN scripts/build.sh
RUN mkdir /app \
    && cp apollo-configservice/target/apollo-configservice-${version}.jar /app/configservice.jar \
    && cp apollo-adminservice/target/apollo-adminservice-${version}.jar /app/adminservice.jar \
    && cp apollo-portal/target/apollo-portal-${version}.jar /app/portal.jar
RUN apk add -U tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

FROM java:8-jre-alpine
WORKDIR /app
COPY --from=build /app .
COPY --from=build /etc/localtime /etc/localtime
ENTRYPOINT [ "java", "-jar" ]
CMD [ "configservice.jar" ]