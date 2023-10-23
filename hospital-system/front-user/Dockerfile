#1、基于镜像node，版本自己查看上面的链接
FROM node:14.21.3
#3、参数，node的环境为生产环境
#ENV NODE_ENV=production
#5、容器内创建目录blog-nuxt
RUN mkdir -p /target
#6、复制当前的内容到容器内容部目录blog
COPY behappy-hospital-user /target/behappy-hospital-user
#7、切换工作目录到blog
WORKDIR /target/behappy-hospital-user
#8、暴露端口3000，默认端口
EXPOSE 3000
#9、配置npm的远程仓库
#RUN npm install cnpm -g --registry=https://registry.npm.taobao.org
#10、清除缓存
RUN npm cache clean --force
#11、安装依赖
RUN npm install
#12、构建，生成dist文件
#RUN npm run build
#13、start
CMD ["npm","run","dev"]
#2、作者
MAINTAINER docker