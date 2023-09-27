# 该镜像需要依赖的基础镜像
FROM openjdk:8-jre-slim
#时区设置
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /target/
ADD target/hosp-service-*.jar /target/hosp-service-0.0.1-SNAPSHOT.jar
EXPOSE 8201
EXPOSE 5005
ENTRYPOINT ["java", "-jar","-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005","/target/hosp-service-0.0.1-SNAPSHOT.jar"]

# 指定维护者的名字
MAINTAINER lhz