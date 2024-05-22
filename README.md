# 

## 环境

node-14.21.3v

https://nodejs.org/download/release/v14.21.3/

jdk8

https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html

maven3.8

https://archive.apache.org/dist/maven/maven-3/

mysql 8.0

cd  保存地址/app-hospital/init.sql

## 部署方式一

**编译**

后端 

```
cd  保存地址/app-hospital/hospital
打包: mvn clen package
启动: java -jar hospital.jar
浏览器地址: localhost:9090
```

前端

医院后台

```
cd  保存地址/app-hospital/hospital-web
启动： npm run build-dev
浏览器地址: localhost:9092/
```

用户前台

```
cd  保存地址/app-hospital/hospital-wxapp
启动： 打开hbuilder-发行-手机h5
浏览器地址: localhost:9091/
```

## 部署方式二
windows10以上有wsl，或者有linux虚拟机安装了docker，可一键启动
```
cd  保存地址/app-hospital
docker-compose up -d
```

