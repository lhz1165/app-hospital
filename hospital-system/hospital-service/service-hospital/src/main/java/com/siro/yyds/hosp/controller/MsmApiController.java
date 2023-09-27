package com.siro.yyds.hosp.controller;


import com.siro.yyds.hosp.service.MsmService;
import com.util.result.Result;
import com.util.util.RandomUtil;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.concurrent.TimeUnit;

/**
 * @author starsea
 * @date 2022-02-03
 */
@Api(tags = "短信服务")
@RestController
@RequestMapping("/api/msm")
public class MsmApiController {

    @Autowired
    private MsmService msmService;

    @Autowired
    private HttpServletRequest request;

    /**
     * 发送手机验证码
     * @param phone
     * @return
     */
    @GetMapping("/send/{phone}")
    public Result sendCode(@PathVariable("phone") String phone) {
        // 从redis获取验证码，如果获取获取到，返回ok
        // key 手机号  value 验证码
        String code = (String) request.getSession().getAttribute(phone);
        if(!StringUtils.isEmpty(code)) {
            return Result.ok();
        }
        // 如果从redis获取不到，成验证码
        code = RandomUtil.getSixBitRandom();
        // 通过整合阿里云服务进行发送，调用service方法
        msmService.send(phone,code);
        // 生成验证码放到redis里面，设置有效时间
        //redisTemplate.opsForValue().set(phone, code,2, TimeUnit.MINUTES);
        return Result.ok();

    }
}
