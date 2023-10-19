package com;

import com.siro.yyds.hosp.ServiceHospApplication;
import com.siro.yyds.hosp.repository.DepartmentRepository;
import com.util.pojo.model.hosp.Department;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;

import javax.annotation.Resource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

/**
 * @author laihz
 * @date 2023/9/27 16:35
 */
//@SpringBootTest(classes = ServiceHospApplication.class,webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class MyTest {
    @Test
    void test() throws SQLException, ClassNotFoundException {


    }


}

