package com;

import com.siro.yyds.hosp.ServiceHospApplication;
import com.siro.yyds.hosp.repository.DepartmentRepository;
import com.util.pojo.model.hosp.Department;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author laihz
 * @date 2023/9/27 16:35
 */
@SpringBootTest(classes = ServiceHospApplication.class,webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class MyTest {
    @Resource
    private DepartmentRepository departmentRepository;
    @Test
    void test(){
        Department d = new Department();
        d.setHoscode("1000_0");


        Example<Department> of = Example.of(d);
        List<Department> all = departmentRepository.findAll(of);
        System.out.println(all.size());

    }

}

