package com.siro.yyds.hosp.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.util.pojo.model.hosp.HospitalSet;
import com.util.pojo.vo.order.SignInfoVo;

/**
 * @author starsea
 * @date 2022-01-21
 */
public interface HospitalSetService extends IService<HospitalSet> {

    /**
     * 获取签名key
     * @param hoscode
     * @return
     */
    String getSignKey(String hoscode);

    /**
     * 获取医院签名信息
     * @param hoscode
     * @return
     */
    SignInfoVo getSignInfoVo(String hoscode);
}
