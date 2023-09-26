package jw.hmanage.hospitalmanage;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("jw.hmanage.hospitalmanage.mapper")
@SpringBootApplication
public class HospitalManageApplication {

    public static void main(String[] args) {
        SpringApplication.run(HospitalManageApplication.class, args);
    }

}
