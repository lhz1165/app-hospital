# 该镜像需要依赖的基础镜像
FROM openjdk:8-jre-slim
#时区设置
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /target/
# 将当前目录下的jar包复制到docker容器的/目录下  改成自己项目的名字
ADD target/hosp-service-*.jar /target/hosp-service-0.0.1-SNAPSHOT.jar
# 容器暴露13333和5005端口
EXPOSE 8201
EXPOSE 5005
# 指定docker容器启动时运行jar包  同时开启5005用来idea远程debug
ENTRYPOINT ["java", "-jar","-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005","/target/hosp-service-0.0.1-SNAPSHOT.jar"]

# 指定维护者的名字
MAINTAINER lhz