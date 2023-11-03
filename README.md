# 

## 环境

node-14.21.3v

jdk8

maven3.8

## 部署

**编译**

后端 

```
cd  保存地址/app-hospital/hospital
mvn clen package
```

前端

医院后台

```
cd  保存地址/app-hospital/hospital-web
npm run build-dev
```

用户前台

```
cd  保存地址/app-hospital/hospital-wxapp
使用hbuilder-发行-手机h5
```

**部署**

```
cd  保存地址/app-hospital
docker-compose up -d
```

