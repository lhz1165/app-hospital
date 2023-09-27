package com.siro.yyds.hosp.controller.api;//package com.siro.yyds.hosp.controller.api;
//
//import com.alibaba.fastjson.JSONObject;
//import com.siro.yyds.common.exception.YydsException;
//import com.siro.yyds.common.result.Result;
//import com.siro.yyds.common.result.ResultCodeEnum;
//import com.siro.yyds.common.util.JwtHelper;
//import com.siro.yyds.model.user.UserInfo;
//import com.siro.yyds.user.service.UserInfoService;
//import com.siro.yyds.user.utils.ConstantWxPropertiesUtil;
//import com.siro.yyds.user.utils.HttpClientUtils;
//import io.swagger.annotations.Api;
//import io.swagger.annotations.ApiOperation;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.util.StringUtils;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import java.io.UnsupportedEncodingException;
//import java.net.URLEncoder;
//import java.util.HashMap;
//import java.util.Map;
//
///**
// * 微信登录官网说明：
// * https://developers.weixin.qq.com/doc/oplatform/Website_App/WeChat_Login/Wechat_Login.html
// *
// * @author docker
// * @date 2022-02-03
// */
//@Api(tags = "微信登录")
//@Controller
//@RequestMapping("/api/ucenter/wx")
//@Slf4j
//public class WeixinApiController {
//
//    @Autowired
//    private UserInfoService userInfoService;
//
//    /**
//     * 生成微信扫描二维码
//     * @return
//     */
//    @ApiOperation(value = "获取微信登录参数")
//    @GetMapping("/getLoginParam")
//    @ResponseBody
//    public Result genQrConnect() {
//        try {
//            Map<String, Object> map = new HashMap<>();
//            map.put("appid", ConstantWxPropertiesUtil.WX_OPEN_APP_ID);
//            map.put("scope", "snsapi_login");
//            String wxOpenRedirectUrl = ConstantWxPropertiesUtil.WX_OPEN_REDIRECT_URL;
//            String redirectUri = URLEncoder.encode(wxOpenRedirectUrl, "UTF-8");
//            map.put("redirect_uri", redirectUri);
//            map.put("state", System.currentTimeMillis()+"");
//            return Result.ok(map);
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//            return null;
//        }
//    }
//
//    /**
//     * 回调方法，得到扫描人信息
//     * @param code
//     * @param state
//     * @return
//     */
//    @ApiOperation(value = "微信登录后回调函数")
//    @RequestMapping("/callback")
//    public String callback(String code, String state) {
//        // 获取授权临时票据
//        System.out.println("微信授权服务器回调。。。。。。");
//        System.out.println("state = " + state);
//        System.out.println("code = " + code);
//
//        if (StringUtils.isEmpty(state) || StringUtils.isEmpty(code)) {
//            log.error("非法回调请求");
//            throw new YydsException(ResultCodeEnum.ILLEGAL_CALLBACK_REQUEST_ERROR);
//        }
//
//        // 使用code和appid以及appscrect换取access_token
//        StringBuffer baseAccessTokenUrl = new StringBuffer()
//                .append("https://api.weixin.qq.com/sns/oauth2/access_token")
//                .append("?appid=%s")
//                .append("&secret=%s")
//                .append("&code=%s")
//                .append("&grant_type=authorization_code");
//
//        String accessTokenUrl = String.format(baseAccessTokenUrl.toString(),
//                ConstantWxPropertiesUtil.WX_OPEN_APP_ID,
//                ConstantWxPropertiesUtil.WX_OPEN_APP_SECRET,
//                code);
//
//        String result = null;
//        try {
//            result = HttpClientUtils.get(accessTokenUrl);
//        } catch (Exception e) {
//            throw new YydsException(ResultCodeEnum.FETCH_ACCESSTOKEN_FAILD);
//        }
//
//        System.out.println("使用code换取的access_token结果 = " + result);
//
//        JSONObject resultJson = JSONObject.parseObject(result);
//        if(resultJson.getString("errcode") != null){
//            log.error("获取access_token失败：" + resultJson.getString("errcode") + resultJson.getString("errmsg"));
//            throw new YydsException(ResultCodeEnum.FETCH_ACCESSTOKEN_FAILD);
//        }
//
//        String accessToken = resultJson.getString("access_token");
//        String openId = resultJson.getString("openid");
//        log.info(accessToken);
//        log.info(openId);
//
//        // 根据access_token获取微信用户的基本信息
//        // 先根据openid进行数据库查询
//         UserInfo userInfo = userInfoService.getByOpenid(openId);
//        // 如果没有查到用户信息,那么调用微信个人信息获取的接口
//        if(null == userInfo){
//            //如果查询到个人信息，那么直接进行登录
//            //使用access_token换取受保护的资源：微信的个人信息
//            String baseUserInfoUrl = "https://api.weixin.qq.com/sns/userinfo" +
//                    "?access_token=%s" +
//                    "&openid=%s";
//            String userInfoUrl = String.format(baseUserInfoUrl, accessToken, openId);
//            String resultUserInfo = null;
//            try {
//                resultUserInfo = HttpClientUtils.get(userInfoUrl);
//            } catch (Exception e) {
//                throw new YydsException(ResultCodeEnum.FETCH_USERINFO_ERROR);
//            }
//            System.out.println("使用access_token获取用户信息的结果 = " + resultUserInfo);
//
//            JSONObject resultUserInfoJson = JSONObject.parseObject(resultUserInfo);
//            if(resultUserInfoJson.getString("errcode") != null){
//                log.error("获取用户信息失败：" + resultUserInfoJson.getString("errcode") + resultUserInfoJson.getString("errmsg"));
//                throw new YydsException(ResultCodeEnum.FETCH_USERINFO_ERROR);
//            }
//
//            //解析用户信息
//            String nickname = resultUserInfoJson.getString("nickname");//昵称
//            String headimgurl = resultUserInfoJson.getString("headimgurl");//头像
//
//            userInfo = new UserInfo();
//            userInfo.setOpenid(openId);
//            userInfo.setNickName(nickname);
//            userInfo.setStatus(1);
//            userInfoService.save(userInfo);
//        }
//
//        Map<String, Object> map = new HashMap<>();
//        String name = userInfo.getName();
//        if(StringUtils.isEmpty(name)) {
//            name = userInfo.getNickName();
//        }
//        if(StringUtils.isEmpty(name)) {
//            name = userInfo.getPhone();
//        }
//        map.put("name", name);
//        // 判断userInfo是否有手机号，如果手机号为空，返回openid
//        // 如果手机号不为空，返回openid值是空字符串
//        if(StringUtils.isEmpty(userInfo.getPhone())) {
//            map.put("openid", userInfo.getOpenid());
//        } else {
//            map.put("openid", "");
//        }
//        String token = JwtHelper.createToken(userInfo.getId(), name);
//        map.put("token", token);
//        return "redirect:" + ConstantWxPropertiesUtil.YYGH_BASE_URL + "/weixin/callback?token="+map.get("token")+"&openid="+map.get("openid")+"&name="+URLEncoder.encode((String)map.get("name"));
//    }
//}
