package com.siro.yyds.hosp;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.BeansException;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationStartedEvent;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.ComponentScan;

/**
 * 医院api接口服务
 *
 * @author docker
 * @date 2023-10-05
 */
@SpringBootApplication
@ComponentScan(basePackages = "com.siro.yyds")
@MapperScan("com.siro.yyds.hosp.mapper")
@Slf4j
public class ServiceHospApplication implements ApplicationListener<ApplicationStartedEvent> {
    @Override
    public void onApplicationEvent(ApplicationStartedEvent event) {
        log.info("start success,{}","http://localhost:8088/swagger-ui.html");
    }

    public static void main(String[] args) {
        SpringApplication.run(ServiceHospApplication.class, args);
    }


}
