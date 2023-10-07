package com.siro.yyds.hosp.controller;

import com.siro.yyds.hosp.service.HospitalService;
import com.util.pojo.model.hosp.Hospital;
import com.util.pojo.vo.hosp.HospitalQueryVo;
import com.util.result.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @author docker
 * @date 2023-10-05
 */
@Api(tags = "医院管理")
@RestController
@RequestMapping("/admin/hosp/hospital")
//@CrossOrigin
public class HospitalController {

    @Autowired
    private HospitalService hospitalService;

    /**
     * 条件查询带分页
     * @param page 当前页数
     * @param limit 每页记录数
     * @param hospitalQueryVo 查询条件
     * @return
     */
    @ApiOperation(value = "条件查询带分页")
    @GetMapping("/findPageHospital/{page}/{limit}")
    public Result findPageHospital(@PathVariable("page") Integer page,
                                   @PathVariable("limit") Integer limit,
                                   @RequestBody(required = false) HospitalQueryVo hospitalQueryVo) {
        Page<Hospital> hospitalPage = hospitalService.selectHospPage(page, limit, hospitalQueryVo);
        return Result.ok(hospitalPage);
    }
    @ApiOperation(value = "条件查询带分页")
    @GetMapping("/list/{page}/{limit}")
    public Result list(@PathVariable("page") Integer page,
                                   @PathVariable("limit") Integer limit,
                                   @RequestBody(required = false) HospitalQueryVo hospitalQueryVo) {
        Page<Hospital> hospitalPage = hospitalService.selectHospPage(page, limit, hospitalQueryVo);
        return Result.ok(hospitalPage);
    }


    /**
     * 更新上线状态
     * @param id
     * @param status
     * @return
     */
    @ApiOperation(value = "更新上线状态")
    @GetMapping("/updateHospStatus/{id}/{status}")
    public Result updateHospStatus(@PathVariable("id") String id, @PathVariable("status") Integer status){
        hospitalService.updateHospStatus(id, status);
        return Result.ok();
    }

    /**
     * 获取医院详情
     * @param id
     * @return
     */
    @ApiOperation(value = "获取医院详情")
    @GetMapping("/showHospDetail/{id}")
    public Result showHospDetail(@PathVariable("id") String id) {
        Map<String, Object> map = hospitalService.showHospDetail(id);
        return Result.ok(map);
    }
}
