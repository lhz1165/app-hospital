package com.siro.yyds.hosp.service.impl;


import com.siro.yyds.hosp.service.MsmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;


/**
 * @author docker
 * @date 2022-02-03
 */
@Service
public class MsmServiceImpl implements MsmService {

    @Autowired
    private HttpServletRequest request;
    /**
     * 发送手机号验证码
     * @param phone
     * @param code
     * @return
     */
    @Override
    public boolean send(String phone, String code) {
        //判断手机号是否为空
        if(StringUtils.isEmpty(phone)) {
            return false;
        }
        System.out.println("phone: " +phone +", code :"+code);
        request.getSession().setAttribute(phone,code);
        return true;
    }



}
