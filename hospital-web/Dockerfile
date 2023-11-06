FROM nginx:1.16.1
ADD dist/ /target/dist
ADD nginx/conf.d/default.conf  /etc/nginx/conf.d/default.conf
ADD nginx/nginx.conf  /etc/nginx/nginx.conf
EXPOSE 9092
MAINTAINER laihz
