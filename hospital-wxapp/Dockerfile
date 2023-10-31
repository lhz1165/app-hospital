# 设置基础镜像
FROM nginx:1.16.1
ADD unpackage/dist/build/h5 /target/h5
ADD nginx/conf.d/default.conf  /etc/nginx/conf.d/default.conf
ADD nginx/nginx.conf  /etc/nginx/nginx.conf
EXPOSE 8081
MAINTAINER laihz

