package com.siro.yyds.hosp.controller.api;

import com.siro.yyds.hosp.service.DepartmentService;
import com.siro.yyds.hosp.service.HospitalService;
import com.siro.yyds.hosp.service.HospitalSetService;
import com.siro.yyds.hosp.service.ScheduleService;
import com.util.pojo.model.hosp.Hospital;
import com.util.pojo.model.hosp.Schedule;
import com.util.pojo.vo.hosp.DepartmentVo;
import com.util.pojo.vo.hosp.HospitalQueryVo;
import com.util.pojo.vo.hosp.ScheduleOrderVo;
import com.util.pojo.vo.order.SignInfoVo;
import com.util.result.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * @author docker
 * @date 2022-02-02
 */
@Api(tags = "医院管理接口")
@RestController
@RequestMapping("/api/hosp/hospital")
public class HospitalApiController {

    @Autowired
    private HospitalService hospitalService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private ScheduleService scheduleService;

    @Autowired
    private HospitalSetService hospitalSetService;

    /**
     * 分页查询医院列表
     * @param page
     * @param limit
     * @param hospitalQueryVo
     * @return
     */
    @ApiOperation(value = "分页查询医院列表")
    @GetMapping("/findHospList/{page}/{limit}")
    public Result findHospList(@PathVariable("page") Integer page, @PathVariable("limit") Integer limit,
                        HospitalQueryVo hospitalQueryVo) {
        // 显示上线的医院
//        hospitalQueryVo.setStatus(1);
        Page<Hospital> pageModel = hospitalService.selectHospPage(page, limit, hospitalQueryVo);
        return Result.ok(pageModel);
    }

    /**
     * 根据医院名称获取医院列表
     * @param hosname
     * @return
     */
    @ApiOperation(value = "根据医院名称获取医院列表")
    @GetMapping("/findByHosname/{hosname}")
    public Result findByHosname(@PathVariable("hosname") String hosname) {
        List<Hospital> list = hospitalService.findByHosname(hosname);
        return Result.ok(list);
    }

    /**
     * 根据医院编号，查询医院所有科室列表
     * @param hoscode
     * @return
     */
    @ApiOperation(value = "获取科室列表")
    @GetMapping("/department/{hoscode}")
    public Result index(@PathVariable("hoscode") String hoscode) {
        List<DepartmentVo> voList = departmentService.findDeptTree(hoscode);
        return Result.ok(voList);
    }

    /**
     * 根据医院编号，查询医院预约挂号详情
     * @param hoscode
     * @return
     */
    @ApiOperation(value = "医院预约挂号详情")
    @GetMapping("/findHospDetail/{hoscode}")
    public Result item(@PathVariable("hoscode") String hoscode) {
        Map<String, Object> map = hospitalService.item(hoscode);
        return Result.ok(map);
    }

    /**
     * 获取可预约排班分页数据
     * @param page 当前页码
     * @param limit 每页记录数
     * @param hoscode 医院code
     * @param depcode 科室code
     * @return
     */
    @ApiOperation(value = "获取可预约排班数据")
    @GetMapping("/auth/getBookingScheduleRule/{page}/{limit}/{hoscode}/{depcode}")
    public Result getBookingSchedule(
            @ApiParam(name = "page", value = "当前页码", required = true)
            @PathVariable Integer page,
            @ApiParam(name = "limit", value = "每页记录数", required = true)
            @PathVariable Integer limit,
            @ApiParam(name = "hoscode", value = "医院code", required = true)
            @PathVariable String hoscode,
            @ApiParam(name = "depcode", value = "科室code", required = true)
            @PathVariable String depcode) {
        Map<String, Object> map = scheduleService.getBookingScheduleRule(page, limit, hoscode, depcode);
        return Result.ok(map);
    }

    /**
     * 获取排班数据
     * @param hoscode 医院code
     * @param depcode 科室code
     * @param workDate 排班日期
     * @return
     */
    @ApiOperation(value = "获取排班数据")
    @GetMapping("/auth/findScheduleList/{hoscode}/{depcode}/{workDate}")
    public Result findScheduleList(
            @ApiParam(name = "hoscode", value = "医院code", required = true)
            @PathVariable String hoscode,
            @ApiParam(name = "depcode", value = "科室code", required = true)
            @PathVariable String depcode,
            @ApiParam(name = "workDate", value = "排班日期", required = true)
            @PathVariable String workDate) {
        List<Schedule> list = scheduleService.getDetailSchedule(hoscode, depcode, workDate);
        return Result.ok(list);
    }

    /**
     * 根据排班id获取排班数据
     * @param scheduleId
     * @return
     */
    @ApiOperation(value = "根据排班id获取排班数据")
    @GetMapping("/getSchedule/{scheduleId}")
    public Result getSchedule(
            @ApiParam(name = "scheduleId", value = "排班id", required = true)
            @PathVariable String scheduleId) {
        Schedule schedule = scheduleService.getScheduleId(scheduleId);
        return Result.ok(schedule);
    }

    /**
     * 根据排班id获取预约下单数据
     * @param scheduleId
     * @return
     */
    @ApiOperation(value = "根据排班id获取预约下单数据")
    @GetMapping("/inner/getScheduleOrderVo/{scheduleId}")
    public ScheduleOrderVo getScheduleOrderVo(
            @ApiParam(name = "scheduleId", value = "排班id", required = true)
            @PathVariable("scheduleId") String scheduleId) {
        return scheduleService.getScheduleOrderVo(scheduleId);
    }

    /**
     * 获取医院签名信息
     * @param hoscode
     * @return
     */
    @ApiOperation(value = "获取医院签名信息")
    @GetMapping("/inner/getSignInfoVo/{hoscode}")
    public SignInfoVo getSignInfoVo(
            @ApiParam(name = "hoscode", value = "医院code", required = true)
            @PathVariable("hoscode") String hoscode) {
        return hospitalSetService.getSignInfoVo(hoscode);
    }
}
