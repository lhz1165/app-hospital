# 该镜像需要依赖的基础镜像
FROM openjdk:8-jre-slim
#时区设置
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN mkdir /target/
ADD target/hospital.jar /target/hospital.jar
EXPOSE 8088
EXPOSE 5005
ENTRYPOINT ["java", "-jar","-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005","/target/hospital.jar"]

# 指定维护者的名字
MAINTAINER lhz