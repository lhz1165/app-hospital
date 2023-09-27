package com.siro.yyds.hosp.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.siro.yyds.hosp.mapper.UserInfoMapper;
import com.siro.yyds.hosp.service.PatientService;
import com.siro.yyds.hosp.service.UserInfoService;
import com.util.exception.YydsException;
import com.util.pojo.enums.AuthStatusEnum;
import com.util.pojo.model.user.Patient;
import com.util.pojo.model.user.UserInfo;
import com.util.pojo.vo.user.LoginVo;
import com.util.pojo.vo.user.UserAuthVo;
import com.util.pojo.vo.user.UserInfoQueryVo;
import com.util.result.ResultCodeEnum;
import com.util.util.JwtHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author docker
 * @date 2023-10-05
 */
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements UserInfoService {

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private HttpServletRequest httpServletRequest;
    @Autowired
    private PatientService patientService;

    /**
     * 用户手机号验证码登录
     * @param loginVo
     * @return
     */
    @Override
    public Map<String, Object> loginUser(LoginVo loginVo) {
        String phone = loginVo.getPhone();
        String code = loginVo.getCode();
        // 判断手机号和验证码是否为空
        if(StringUtils.isEmpty(phone) || StringUtils.isEmpty(code)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }

        // TODO 判断手机验证码和输入的验证码是否一致
        //String mobleCode = redisTemplate.opsForValue().get(phone);
        String mobleCode =(String) httpServletRequest.getSession().getAttribute(phone);
        if(!code.equals(mobleCode)) {
            throw new YydsException(ResultCodeEnum.CODE_ERROR);
        }

        //绑定手机号码
        UserInfo userInfo = null;
        if(!StringUtils.isEmpty(loginVo.getOpenid())) {
            userInfo = this.getByOpenid(loginVo.getOpenid());
            if(null != userInfo) {
                userInfo.setPhone(loginVo.getPhone());
                this.updateById(userInfo);
            } else {
                throw new YydsException(ResultCodeEnum.DATA_ERROR);
            }
        }

        // 如果userInfo 为空，则进行手机登录
        if(null == userInfo) {
            // 判断是否第一次登录，根据手机号查询数据库，如果不存在相同的手机号就是第一次登录
            QueryWrapper<UserInfo> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("phone", phone);
            userInfo = baseMapper.selectOne(queryWrapper);
            if(null == userInfo) {
                // 注册信息到数据库
                userInfo = new UserInfo();
                userInfo.setName("");
                userInfo.setPhone(phone);
                userInfo.setStatus(1);
                this.save(userInfo);
            }
        }

        // 校验是否被禁用
        if(userInfo.getStatus() == 0) {
            throw new YydsException(ResultCodeEnum.LOGIN_DISABLED_ERROR);
        }

        // 返回登录信息
        Map<String, Object> map = new HashMap<>();
        String name = userInfo.getName();
        if(StringUtils.isEmpty(name)) {
            name = userInfo.getNickName();
        }
        if(StringUtils.isEmpty(name)) {
            name = userInfo.getPhone();
        }
        // 返回登录用户名
        map.put("name", name);
        // TODO 返回token信息，jwt生成token字符串
        String token = JwtHelper.createToken(userInfo.getId(), name);
        map.put("token",token);

        return map;
    }

    /**
     * 根据微信openid获取用户信息
     * @param openid
     * @return
     */
    @Override
    public UserInfo getByOpenid(String openid) {
        return userInfoMapper.selectOne(new QueryWrapper<UserInfo>().eq("openid", openid));
    }

    /**
     * 用户认证
     * @param userId
     * @param userAuthVo
     */
    @Override
    public void userAuth(Long userId, UserAuthVo userAuthVo) {
        // 根据用户id查询用户信息
        UserInfo userInfo = baseMapper.selectById(userId);
        // 设置认证信息
        // 认证人姓名
        userInfo.setName(userAuthVo.getName());
        // 其他认证信息
        userInfo.setCertificatesType(userAuthVo.getCertificatesType());
        userInfo.setCertificatesNo(userAuthVo.getCertificatesNo());
        userInfo.setCertificatesUrl(userAuthVo.getCertificatesUrl());
        userInfo.setAuthStatus(AuthStatusEnum.AUTH_RUN.getStatus());
        // 进行信息更新
        baseMapper.updateById(userInfo);
    }

    /**
     * 用户列表（条件查询带分页）
     * @param pageParam
     * @param userInfoQueryVo
     * @return
     */
    @Override
    public IPage<UserInfo> selectPage(Page<UserInfo> pageParam, UserInfoQueryVo userInfoQueryVo) {
        // UserInfoQueryVo获取条件值
        String name = userInfoQueryVo.getKeyword(); //用户名称
        Integer status = userInfoQueryVo.getStatus();//用户状态
        Integer authStatus = userInfoQueryVo.getAuthStatus(); //认证状态
        String createTimeBegin = userInfoQueryVo.getCreateTimeBegin(); //开始时间
        String createTimeEnd = userInfoQueryVo.getCreateTimeEnd(); //结束时间

        // 对条件值进行非空判断
        QueryWrapper<UserInfo> wrapper = new QueryWrapper<>();
        if(!StringUtils.isEmpty(name)) {
            wrapper.like("name", name);
        }
        if(!StringUtils.isEmpty(status)) {
            wrapper.eq("status", status);
        }
        if(!StringUtils.isEmpty(authStatus)) {
            wrapper.eq("auth_status", authStatus);
        }
        if(!StringUtils.isEmpty(createTimeBegin)) {
            wrapper.ge("create_time", createTimeBegin);
        }
        if(!StringUtils.isEmpty(createTimeEnd)) {
            wrapper.le("create_time", createTimeEnd);
        }
        // 调用mapper的方法
        IPage<UserInfo> pages = baseMapper.selectPage(pageParam, wrapper);
        // 编号变成对应值封装
        pages.getRecords().stream().forEach(item -> {
            this.packageUserInfo(item);
        });
        return pages;
    }

    /**
     * 用户锁定
     * @param userId
     * @param status 0：锁定 1：正常
     */
    @Override
    public void lock(Long userId, Integer status) {
        if (status.intValue() ==0 || status.intValue() == 1) {
            UserInfo userInfo = baseMapper.selectById(userId);
            userInfo.setStatus(status);
            baseMapper.updateById(userInfo);
        }
    }

    /**
     * 详情
     * @param userId
     * @return
     */
    @Override
    public Map<String, Object> show(Long userId) {
        Map<String,Object> map = new HashMap<>();
        // 根据userid查询用户信息
        UserInfo userInfo = this.packageUserInfo(baseMapper.selectById(userId));
        map.put("userInfo",userInfo);
        // 根据userid查询就诊人信息
        List<Patient> patientList = patientService.findAllUserId(userId);
        map.put("patientList", patientList);
        return map;
    }

    /**
     * 认证审批
     * @param userId
     * @param authStatus 2：通过 -1：不通过
     */
    @Override
    public void approval(Long userId, Integer authStatus) {
        if(authStatus.intValue()==2 || authStatus.intValue()==-1) {
            UserInfo userInfo = baseMapper.selectById(userId);
            userInfo.setAuthStatus(authStatus);
            baseMapper.updateById(userInfo);
        }
    }

    // 编号变成对应值封装
    private UserInfo packageUserInfo(UserInfo userInfo) {
        // 处理认证状态编码
        userInfo.getParam().put("authStatusString",AuthStatusEnum.getStatusNameByStatus(userInfo.getAuthStatus()));
        // 处理用户状态 0  1
        String statusString = userInfo.getStatus().intValue()==0 ? "锁定" : "正常";
        userInfo.getParam().put("statusString",statusString);
        return userInfo;
    }
}
