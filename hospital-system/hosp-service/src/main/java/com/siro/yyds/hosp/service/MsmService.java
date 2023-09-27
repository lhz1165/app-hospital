package com.siro.yyds.hosp.service;


/**
 * @author docker
 * @date 2022-02-03
 */
public interface MsmService {

    /**
     * 发送手机号验证码
     * @param phone
     * @param code
     * @return
     */
    boolean send(String phone, String code);

}
