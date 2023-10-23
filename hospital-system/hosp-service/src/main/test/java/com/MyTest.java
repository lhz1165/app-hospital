package com;

import com.siro.yyds.hosp.ServiceHospApplication;
import com.siro.yyds.hosp.repository.DepartmentRepository;
import com.siro.yyds.hosp.repository.HospitalRepository;
import com.util.pojo.model.hosp.Department;
import com.util.pojo.model.hosp.Hospital;
import org.junit.jupiter.api.Test;
import org.springframework.beans.BeanUtils;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.*;

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
@SpringBootTest(classes = ServiceHospApplication.class,webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class MyTest {
    @Resource
    HospitalRepository hospitalRepository;
    @Test
    void test()  {
        Hospital hospital = new Hospital();
        hospital.setHosname("北京协和医院");
        Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
        Pageable pageable = PageRequest.of(0, 10, sort);
        //创建匹配器，即如何使用查询条件
        ExampleMatcher matcher = ExampleMatcher.matching() //构建对象
                .withStringMatcher(ExampleMatcher.StringMatcher.CONTAINING) //改变默认字符串匹配方式：模糊查询
                .withIgnoreCase(true); //改变默认大小写忽略方式：忽略大小写

        //创建实例
        Example<Hospital> example = Example.of(hospital,matcher);
        Page<Hospital> pages = hospitalRepository.findAll(example, pageable);
        System.out.println();
        List<Hospital> all2 = hospitalRepository.findAll(example);
        List<Hospital> all = hospitalRepository.findAll();
        System.out.println();

    }


}

