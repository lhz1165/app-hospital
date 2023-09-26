package com.siro.yyds.hosp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.siro.yyds.hosp.mapper.HospitalSetMapper;
import com.siro.yyds.hosp.service.HospitalSetService;

import com.util.exception.YydsException;
import com.util.pojo.model.hosp.HospitalSet;
import com.util.pojo.vo.order.SignInfoVo;
import com.util.result.ResultCodeEnum;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author starsea
 * @date 2022-01-21
 */
@Service
public class HospitalSetServiceImpl extends ServiceImpl<HospitalSetMapper, HospitalSet> implements HospitalSetService {

    @Autowired
    private HospitalSetMapper hospitalSetMapper;

    /**
     * 获取签名key
     * @param hoscode
     * @return
     */
    @Override
    public String getSignKey(String hoscode) {
        // 根据hoscode获取医院设置
        HospitalSet hospitalSet = hospitalSetMapper.selectOne(new QueryWrapper<HospitalSet>().eq("hoscode", hoscode));
        if(null == hospitalSet) {
            throw new YydsException(ResultCodeEnum.HOSPITAL_OPEN);
        }
        if(hospitalSet.getStatus().intValue() == 0) {
            throw new YydsException(ResultCodeEnum.HOSPITAL_LOCK);
        }
        return hospitalSet.getSignKey();
    }

    /**
     * 获取医院签名信息
     * @param hoscode
     * @return
     */
    @Override
    public SignInfoVo getSignInfoVo(String hoscode) {
        QueryWrapper<HospitalSet> wrapper = new QueryWrapper<>();
        wrapper.eq("hoscode",hoscode);
        HospitalSet hospitalSet = baseMapper.selectOne(wrapper);
        if(null == hospitalSet) {
            throw new YydsException(ResultCodeEnum.HOSPITAL_OPEN);
        }
        SignInfoVo signInfoVo = new SignInfoVo();
        signInfoVo.setApiUrl(hospitalSet.getApiUrl());
        signInfoVo.setSignKey(hospitalSet.getSignKey());
        return signInfoVo;
    }

}
