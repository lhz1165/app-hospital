package com.siro.yyds.hosp.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.siro.yyds.hosp.service.HospitalSetService;
import com.util.pojo.model.hosp.HospitalSet;
import com.util.pojo.vo.hosp.HospitalSetQueryVo;
import com.util.result.Result;
import com.util.util.MD5;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Random;

/**
 * @author starsea
 * @date 2022-01-21
 */
@Api(tags = "医院设置管理")
@RestController
@RequestMapping("/admin/hosp/hospitalSet")
//@CrossOrigin // 跨域注解
public class HospitalSetController {

    @Autowired
    private HospitalSetService hospitalSetService;

    /**
     * 查询医院设置表所有信息
     * @return
     */
    @ApiOperation(value = "查询所有医院设置")
    @GetMapping("/findAll")
    public Result findAllHospitalSet() {
        List<HospitalSet> list = hospitalSetService.list();
        return Result.ok(list);
    }

    /**
     * 条件查询带分页
     * @return
     */
    @ApiOperation(value = "条件查询带分页")
    @PostMapping("/findPageHospSet/{current}/{limit}")
    public Result findPageHospSet(@PathVariable("current") long current,
                                  @PathVariable("limit") long limit,
                                  @RequestBody(required = false) HospitalSetQueryVo hospitalSetQueryVo) {
        Page<HospitalSet> page = new Page<>(current,limit);
        QueryWrapper<HospitalSet> wrapper = new QueryWrapper<>();
        String hosname = hospitalSetQueryVo.getHosname();
        String hoscode = hospitalSetQueryVo.getHoscode();
        if (!StringUtils.isEmpty(hosname)) {
            wrapper.like("hosname",hosname);
        }
        if (!StringUtils.isEmpty(hoscode)) {
            wrapper.eq("hoscode",hoscode);
        }
        Page<HospitalSet> hospitalSetPage = hospitalSetService.page(page, wrapper);
        return Result.ok(hospitalSetPage);
    }

    /**
     * 添加医院设置
     * @param hospitalSet
     * @return
     */
    @ApiOperation(value = "添加医院设置")
    @PostMapping("/saveHospitalSet")
    public Result saveHospitalSet(@RequestBody HospitalSet hospitalSet) {
        // 设置状态 1使用 0不能使用
        hospitalSet.setStatus(1);
        // 设置签名密钥
        Random random = new Random();
        hospitalSet.setSignKey(MD5.encrypt(System.currentTimeMillis() + "" + random.nextInt(1000)));
        boolean save = hospitalSetService.save(hospitalSet);
        if (save) {
            return Result.ok();
        } else {
            return Result.fail();
        }
    }

    /**
     * 根据id获取医院设置
     * @param id
     * @return
     */
    @ApiOperation(value = "根据id获取医院设置")
    @GetMapping("/getHospSet/{id}")
    public Result getHospSet(@PathVariable("id") long id) {
        HospitalSet hospitalSet = hospitalSetService.getById(id);
        return Result.ok(hospitalSet);
    }

    /**
     * 修改医院设置
     * @param hospitalSet
     * @return
     */
    @ApiOperation(value = "修改医院设置")
    @PostMapping("/updateHospitalSet")
    public Result updateHospitalSet(@RequestBody HospitalSet hospitalSet) {
        boolean flag = hospitalSetService.updateById(hospitalSet);
        if (flag) {
            return Result.ok();
        } else {
            return Result.fail();
        }
    }

    /**
     * 逻辑删除医院设置
     * @return
     */
    @ApiOperation(value = "逻辑删除医院设置")
    @DeleteMapping("/{id}")
    public Result removeHospSet(@PathVariable("id") long id) {
        boolean flag = hospitalSetService.removeById(id);
        if (flag) {
            return Result.ok();
        } else {
            return Result.fail();
        }
    }

    /**
     * 批量删除医院设置
     * @param idList
     * @return
     */
    @ApiOperation(value = "批量删除医院设置")
    @DeleteMapping("/batchRemove")
    public Result batchRemove(@RequestBody List<Long> idList) {
        hospitalSetService.removeByIds(idList);
        return Result.ok();
    }

    /**
     * 医院设置锁定和解锁
     * @param id
     * @param status
     * @return
     */
    @ApiOperation(value = "医院设置锁定和解锁")
    @PutMapping("/lockHospitalSet/{id}/{status}")
    public Result lockHospitalSet(@PathVariable("id") Long id,
                                  @PathVariable("status") Integer status) {
        //根据id查询医院设置信息
        HospitalSet hospitalSet = hospitalSetService.getById(id);
        //设置状态
        hospitalSet.setStatus(status);
        //调用方法
        hospitalSetService.updateById(hospitalSet);
        return Result.ok();
    }

    /**
     * 发送签名秘钥
     * @param id
     * @return
     */
    @ApiOperation(value = "发送签名秘钥")
    @PutMapping("/sendKey/{id}")
    public Result sendKey(@PathVariable Long id) {
        HospitalSet hospitalSet = hospitalSetService.getById(id);
        String signKey = hospitalSet.getSignKey();
        String hoscode = hospitalSet.getHoscode();
        //TODO 发送短信

        return Result.ok();
    }
}
