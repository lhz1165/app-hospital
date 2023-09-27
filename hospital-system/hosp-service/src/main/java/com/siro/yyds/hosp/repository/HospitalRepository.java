package com.siro.yyds.hosp.repository;


import com.util.pojo.model.hosp.Hospital;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 医院管理 保存到 mongodb中
 * @author starsea
 * @date 2022-01-26
 */
@Repository
public interface HospitalRepository extends MongoRepository<Hospital, String> {

    /**
     * 判断是否存在数据
     * @param hoscode
     * @return
     */
    Hospital getHospitalByHoscode(String hoscode);

    /**
     * 根据医院名称 查询医院列表
     * @param hosname
     * @return
     */
    List<Hospital> findHospitalByHosnameLike(String hosname);
}
