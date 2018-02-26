# Apollo配置中心docker

## 说明
- 此项目为[Apollo](https://github.com/ctripcorp/apollo)的非官方docker
- 镜像中并未包含mysql，mysql搭建参照[官方文档](https://github.com/ctripcorp/apollo/wiki/%E5%88%86%E5%B8%83%E5%BC%8F%E9%83%A8%E7%BD%B2%E6%8C%87%E5%8D%97#21-%E5%88%9B%E5%BB%BA%E6%95%B0%E6%8D%AE%E5%BA%93)。有空写个快速搭建apollo mysql的镜像

## 使用方法

- 镜像中包含configservice、adminservice、portal，默认configservice。如要更改成adminservice，则在运行参数中添加对应xxx.jar，如下
```
docker run chenchuxin/apollo adminservice.jar
```

- 要修改配置直接用环境变量，例如
```
docker run \
-e spring_datasource_url=jdbc:mysql://localhost:3306/ApolloConfigDB?characterEncoding=utf8 \
-e spring_datasource_username=ccx \
chenchuxin/apollo
```

- 一个比较完整的例子
```
docker run \
-e spring_datasource_url=jdbc:mysql://localhost:3306/ApolloConfigDB?characterEncoding=utf8 \
-e spring_datasource_username=root \
-e spring_datasource_password=xxx \
-e server.port=8080 \
-e logging.file=/opt/logs/configservice.log \
-v /opt/logs:/var/log/apollo \
--network host \
--restart always \
--name apollo_configservice \
chenchuxin/apollo \
configservice.jar
```

- 项目提供了简单的docker-compose.yml，修改成一下配置即可用
```
docker-compose up -d
```

## 注意
portal设置meta_server的时候，不要用环境变量设置，在运行参数用`-D`设置，如
```
docker run chenchuxin/apollo -Ddev_meta=http://localhost:8080 portal.jar
```
