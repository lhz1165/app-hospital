package com.siro.yyds.hosp.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import com.siro.yyds.hosp.service.UserInfoService;
import com.util.pojo.model.user.UserInfo;
import com.util.pojo.vo.user.UserInfoQueryVo;
import com.util.result.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author starsea
 * @date 2022-02-05
 */
@Api(tags = "用户模块")
@RestController
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserInfoService userInfoService;

    /**
     * 用户列表（条件查询带分页）
     * @param page
     * @param limit
     * @param userInfoQueryVo
     * @return
     */
    @ApiOperation(value = "用户列表（条件查询带分页）")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable("page") Long page,
                       @PathVariable("limit") Long limit,
                       UserInfoQueryVo userInfoQueryVo) {
        Page<UserInfo> pageParam = new Page<>(page,limit);
        IPage<UserInfo> pageModel = userInfoService.selectPage(pageParam, userInfoQueryVo);
        return Result.ok(pageModel);
    }

    /**
     * 锁定用户状态
     * @param userId
     * @param status
     * @return
     */
    @ApiOperation(value = "锁定用户状态")
    @GetMapping("/lock/{userId}/{status}")
    public Result lock(@PathVariable("userId") Long userId, @PathVariable("status") Integer status){
        userInfoService.lock(userId, status);
        return Result.ok();
    }

    /**
     * 用户详情
     * @param userId
     * @return
     */
    @ApiOperation(value = "用户详情")
    @GetMapping("/show/{userId}")
    public Result show(@PathVariable("userId") Long userId) {
        Map<String, Object> map = userInfoService.show(userId);
        return Result.ok(map);
    }

    /**
     * 认证审批
     * @param userId
     * @param authStatus
     * @return
     */
    @ApiOperation(value = "认证审批")
    @GetMapping("/approval/{userId}/{authStatus}")
    public Result approval(@PathVariable("userId") Long userId,@PathVariable("authStatus") Integer authStatus) {
        userInfoService.approval(userId, authStatus);
        return Result.ok();
    }
}
