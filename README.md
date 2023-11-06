# 

## 环境

node-14.21.3v

https://nodejs.org/download/release/v14.21.3/

jdk8

https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html

maven3.8

https://archive.apache.org/dist/maven/maven-3/

## 部署

**编译**

后端 

```
cd  保存地址/app-hospital/hospital
mvn clen package
localhost:9090
```

前端

医院后台

```
cd  保存地址/app-hospital/hospital-web
npm run build-dev
localhost:9092/
```

用户前台

```
cd  保存地址/app-hospital/hospital-wxapp
使用hbuilder-发行-手机h5
localhost:9091/
```

**部署**

```
cd  保存地址/app-hospital
docker-compose up -d
```

