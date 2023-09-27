package com.siro.yyds.hosp.repository;


import com.util.pojo.model.hosp.Department;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

/**
 * @author docker
 * @date 2022-01-27
 */
@Repository
public interface DepartmentRepository extends MongoRepository<Department, String> {

    Department getDepartmentByHoscodeAndDepcode(String hoscode, String depcode);
}
