package com.siro.yyds.hosp.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.siro.yyds.hosp.repository.HospitalRepository;
import com.siro.yyds.hosp.service.HospitalService;
import com.util.pojo.model.hosp.Hospital;
import com.util.pojo.vo.hosp.HospitalQueryVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author docker
 * @date 2022-01-26
 */
@Slf4j
@Service
public class HospitalServiceImpl implements HospitalService {

    @Autowired
    private HospitalRepository hospitalRepository;

//    @Autowired
//    private DictFeignClient dictFeignClient;

    /**
     * 保存医院的基本信息
     * @param paramMap
     */
    @Override
    public void save(Map<String, Object> paramMap) {
        log.info(JSONObject.toJSONString(paramMap));
        Hospital hospital = JSONObject.parseObject(JSONObject.toJSONString(paramMap),Hospital.class);
        //判断是否存在
        Hospital targetHospital = hospitalRepository.getHospitalByHoscode(hospital.getHoscode());
        if(null != targetHospital) {
            hospital.setStatus(targetHospital.getStatus());
            hospital.setCreateTime(targetHospital.getCreateTime());
            hospital.setUpdateTime(new Date());
            hospital.setIsDeleted(0);
            hospitalRepository.save(hospital);
        } else {
            //0：未上线 1：已上线
            hospital.setStatus(0);
            hospital.setCreateTime(new Date());
            hospital.setUpdateTime(new Date());
            hospital.setIsDeleted(0);
            hospitalRepository.save(hospital);
        }
    }

    /**
     * 查询医院信息
     * @param hoscode
     * @return
     */
    @Override
    public Hospital getByHoscode(String hoscode) {
        return hospitalRepository.getHospitalByHoscode(hoscode);
    }

    /**
     * 条件查询带分页
     * @param page 当前页数
     * @param limit 每页记录数
     * @param hospitalQueryVo 查询条件
     * @return
     */
    @Override
    public Page<Hospital> selectHospPage(Integer page, Integer limit, HospitalQueryVo hospitalQueryVo) {
        Sort sort = Sort.by(Sort.Direction.DESC, "createTime");
        Pageable pageable = PageRequest.of(page-1, limit, sort);

        Hospital hospital = new Hospital();
        if (null != hospitalQueryVo) {
            BeanUtils.copyProperties(hospitalQueryVo, hospital);
        }

        //创建匹配器，即如何使用查询条件
        ExampleMatcher matcher = ExampleMatcher.matching() //构建对象
                .withStringMatcher(ExampleMatcher.StringMatcher.CONTAINING) //改变默认字符串匹配方式：模糊查询
                .withIgnoreCase(true); //改变默认大小写忽略方式：忽略大小写

        //创建实例
        Example<Hospital> example = Example.of(hospital, matcher);
        Page<Hospital> pages = hospitalRepository.findAll(example, pageable);

        // 封装远程数据
        pages.getContent().stream().forEach(item -> {
            this.packHospital(item);
        });
        return pages;
    }

    /**
     * 更新上线状态
     * @param id
     * @param status
     */
    @Override
    public void updateHospStatus(String id, Integer status) {
        Hospital hospital = hospitalRepository.findById(id).get();
        hospital.setStatus(status);
        hospital.setUpdateTime(new Date());
        hospitalRepository.save(hospital);
    }

    /**
     * 医院详情
     * @param id
     * @return
     */
    @Override
    public Map<String, Object> showHospDetail(String id) {
        Map<String, Object> resultMap = new HashMap<>();
        // 查询医院信息(包含医院等级)
        Hospital hospital = this.packHospital(hospitalRepository.findById(id).get());
        resultMap.put("hospital", hospital);
        //单独处理更直观
        resultMap.put("bookingRule", hospital.getBookingRule());
        //不需要重复返回
        hospital.setBookingRule(null);
        return resultMap;
    }

    /**
     * 获取医院名称
     * @param hoscode
     * @return
     */
    @Override
    public String getHospName(String hoscode) {
        Hospital hospital = hospitalRepository.getHospitalByHoscode(hoscode);
        if (hospital != null) {
            return hospital.getHosname();
        }
        return null;
    }

    /**
     * 根据医院名称 查询医院列表
     * @param hosname
     * @return
     */
    @Override
    public List<Hospital> findByHosname(String hosname) {
        return hospitalRepository.findHospitalByHosnameLike(hosname);
    }

    /**
     * 医院预约挂号详情
     * @param hoscode
     * @return
     */
    @Override
    public Map<String, Object> item(String hoscode) {
        Map<String, Object> result = new HashMap<>();
        //医院详情
        Hospital hospital = this.packHospital(this.getByHoscode(hoscode));
        result.put("hospital", hospital);
        //预约规则
        result.put("bookingRule", hospital.getBookingRule());
        //不需要重复返回
        hospital.setBookingRule(null);
        return result;
    }

    // 封装远程数据字典数据
    private Hospital packHospital(Hospital hospital) {
//        String hostypeString = dictFeignClient.getName(DictEnum.HOSTYPE.getDictCode(),hospital.getHostype());
//        String provinceString = dictFeignClient.getName(hospital.getProvinceCode());
//        String cityString = dictFeignClient.getName(hospital.getCityCode());
//        String districtString = dictFeignClient.getName(hospital.getDistrictCode());
//
//        hospital.getParam().put("hostypeString", hostypeString);
//        hospital.getParam().put("fullAddress", provinceString + cityString + districtString + hospital.getAddress());
        return hospital;
    }
}
