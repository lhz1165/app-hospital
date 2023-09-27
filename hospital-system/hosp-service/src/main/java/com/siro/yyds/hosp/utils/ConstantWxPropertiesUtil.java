//package com.siro.yyds.hosp.utils;
//
//import org.springframework.beans.factory.InitializingBean;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.stereotype.Component;
//
///**
// * 微信登录参数类
// * @author docker
// * @date 2022-02-03
// */
//@Component
//public class ConstantWxPropertiesUtil implements InitializingBean {
//
//    @Value("${wx.open.app_id}")
//    private String appId;
//
//    @Value("${wx.open.app_secret}")
//    private String appSecret;
//
//    @Value("${wx.open.redirect_url}")
//    private String redirectUrl;
//
//    @Value("${yygh.baseUrl}")
//    private String yyghBaseUrl;
//
//    public static String WX_OPEN_APP_ID;
//    public static String WX_OPEN_APP_SECRET;
//    public static String WX_OPEN_REDIRECT_URL;
//    public static String YYGH_BASE_URL;
//
//    @Override
//    public void afterPropertiesSet() throws Exception {
//        WX_OPEN_APP_ID = appId;
//        WX_OPEN_APP_SECRET = appSecret;
//        WX_OPEN_REDIRECT_URL = redirectUrl;
//        YYGH_BASE_URL = yyghBaseUrl;
//    }
//}
