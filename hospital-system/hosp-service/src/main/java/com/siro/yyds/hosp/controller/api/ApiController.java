package com.siro.yyds.hosp.controller.api;


import com.siro.yyds.hosp.service.DepartmentService;
import com.siro.yyds.hosp.service.HospitalService;
import com.siro.yyds.hosp.service.HospitalSetService;
import com.siro.yyds.hosp.service.ScheduleService;
import com.util.exception.YydsException;
import com.util.pojo.model.hosp.Department;
import com.util.pojo.model.hosp.Hospital;
import com.util.pojo.model.hosp.Schedule;
import com.util.pojo.vo.hosp.DepartmentQueryVo;
import com.util.pojo.vo.hosp.HospitalQueryVo;
import com.util.pojo.vo.hosp.ScheduleQueryVo;
import com.util.result.Result;
import com.util.result.ResultCodeEnum;
import com.util.util.HttpRequestHelper;
import com.util.util.MD5;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * @author docker
 * @date 2023-10-05
 */
@Api(tags = "医院管理API接口")
@RestController
@RequestMapping("/api/hosp")
public class ApiController {

    @Autowired
    private HospitalService hospitalService;

    @Autowired
    private HospitalSetService hospitalSetService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private ScheduleService scheduleService;

    /**
     * 上传医院的基本信息与规则信息
     * @return
     */
    @ApiOperation(value = "上传医院的基本信息与规则信息")
    @PostMapping("/saveHospital")
    public Result saveHospital(HttpServletRequest request) {
        // 获取传递过来的医院信息
        Map<String, String[]> map = request.getParameterMap();
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(map);
        // 获取医院系统传递过来的签名
        String sign = (String) paramMap.get("sign");
        // 获取医院传递过来的医院编码，查询数据库的签名
        String hoscode = (String)paramMap.get("hoscode");
        if(StringUtils.isEmpty(hoscode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }
        String signKey = hospitalSetService.getSignKey(hoscode);
        // 把数据库查询的签名进行MD5加密
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }
        // 传输过程中“+”转换为了“ ”，因此我们要转换回来
        String logoData = (String)paramMap.get("logoData");
        logoData = logoData.replaceAll(" ","+");
        paramMap.put("logoData",logoData);
        hospitalService.save(paramMap);
        return Result.ok();
    }

    /**
     * 查询医院信息
     * @param request
     * @return
     */
    @ApiOperation(value = "查询医院")
    @PostMapping("/hospital/show")
    public Result hospitalList(HttpServletRequest request) {
        Map<String, String[]> map = request.getParameterMap();
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(map);
        String hoscode = (String) paramMap.get("hoscode");
        String sign = (String) paramMap.get("sign");
        String signKey = hospitalSetService.getSignKey(hoscode);
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }
        Hospital hospital = hospitalService.getByHoscode(hoscode);
        return Result.ok(hospital);
    }

    /**
     * 上传医院科室
     * @param request
     * @return
     */
    @ApiOperation(value = "上传医院科室")
    @PostMapping("/saveDepartment")
    public Result saveDepartment(HttpServletRequest request) {
        Map<String, String[]> map = request.getParameterMap();
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(map);

        // 获取医院系统传递过来的签名
        String sign = (String) paramMap.get("sign");
        // 获取医院传递过来的医院编码，查询数据库的签名
        String hoscode = (String)paramMap.get("hoscode");
        if(StringUtils.isEmpty(hoscode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }
        String signKey = hospitalSetService.getSignKey(hoscode);
        // 把数据库查询的签名进行MD5加密
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }

        departmentService.save(paramMap);
        return Result.ok();
    }
    @ApiOperation(value = "条件查询带分页")
    @GetMapping("hospital/{page}/{limit}")
    public Result<Page<Hospital>> list(@PathVariable("page") Integer page,
                       @PathVariable("limit") Integer limit,
                       @RequestBody(required = false) HospitalQueryVo hospitalQueryVo) {
        Page<Hospital> hospitalPage = hospitalService.selectHospPage(page, limit, hospitalQueryVo);
        return Result.ok(hospitalPage);
    }
    /**
     * 查询科室信息（带分页）
     * @param request
     * @return
     */
    @ApiOperation(value = "查询科室信息")
    @PostMapping("/department/list")
    public Result departmentList(HttpServletRequest request) {
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(request.getParameterMap());

        // 获取医院系统传递过来的签名
        String sign = (String) paramMap.get("sign");
        // 获取医院传递过来的医院编码，查询数据库的签名
        String hoscode = (String)paramMap.get("hoscode");
        if(StringUtils.isEmpty(hoscode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }
        String signKey = hospitalSetService.getSignKey(hoscode);
        // 把数据库查询的签名进行MD5加密
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }

        // 当前页 和 每页记录数
        int page = StringUtils.isEmpty((String) paramMap.get("page")) ? 1 : Integer.parseInt((String) paramMap.get("page"));
        int limit = StringUtils.isEmpty((String) paramMap.get("limit")) ? 1 : Integer.parseInt((String) paramMap.get("limit"));

        DepartmentQueryVo departmentQueryVo = new DepartmentQueryVo();
        departmentQueryVo.setHoscode(hoscode);

        Page<Department> departmentPage =  departmentService.findPageDepartment(page, limit, departmentQueryVo);
        return Result.ok(departmentPage);
    }

    /**
     * 删除科室信息
     * @param request
     * @return
     */
    @ApiOperation(value = "删除科室信息")
    @PostMapping("/department/remove")
    public Result removeDepartment(HttpServletRequest request) {
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(request.getParameterMap());

        // 获取医院系统传递过来的签名
        String sign = (String) paramMap.get("sign");
        // 获取医院传递过来的医院编码，查询数据库的签名
        String hoscode = (String)paramMap.get("hoscode");
        if(StringUtils.isEmpty(hoscode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }
        String signKey = hospitalSetService.getSignKey(hoscode);
        // 把数据库查询的签名进行MD5加密
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }

        String depcode = (String) paramMap.get("depcode");
        if (StringUtils.isEmpty(depcode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }

        departmentService.removeDepartment(hoscode, depcode);
        return Result.ok();
    }

    /**
     * 添加排班信息
     * @param request
     * @return
     */
    @ApiOperation(value = "添加排班信息")
    @PostMapping("/saveSchedule")
    public Result saveSchedule(HttpServletRequest request) {
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(request.getParameterMap());

        // 获取医院系统传递过来的签名
        String sign = (String) paramMap.get("sign");
        // 获取医院传递过来的医院编码，查询数据库的签名
        String hoscode = (String)paramMap.get("hoscode");
        if(StringUtils.isEmpty(hoscode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }
        String signKey = hospitalSetService.getSignKey(hoscode);
        // 把数据库查询的签名进行MD5加密
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }

        scheduleService.save(paramMap);
        return Result.ok();
    }

    /**
     * 查询排班信息（带分页）
     * @param request
     * @return
     */
    @ApiOperation(value = "查询排班信息")
    @PostMapping("/schedule/list")
    public Result scheduleList(HttpServletRequest request) {
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(request.getParameterMap());

        // 获取医院系统传递过来的签名
        String sign = (String) paramMap.get("sign");
        // 获取医院传递过来的医院编码，查询数据库的签名
        String hoscode = (String)paramMap.get("hoscode");
        if(StringUtils.isEmpty(hoscode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }
        String signKey = hospitalSetService.getSignKey(hoscode);
        // 把数据库查询的签名进行MD5加密
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }

        // 当前页 和 每页记录数
        int page = StringUtils.isEmpty((String) paramMap.get("page")) ? 1 : Integer.parseInt((String) paramMap.get("page"));
        int limit = StringUtils.isEmpty((String) paramMap.get("limit")) ? 1 : Integer.parseInt((String) paramMap.get("limit"));

        ScheduleQueryVo scheduleQueryVo = new ScheduleQueryVo();
        scheduleQueryVo.setHoscode(hoscode);

        Page<Schedule> schedulePage =  scheduleService.findPageSchedule(page, limit, scheduleQueryVo);
        return Result.ok(schedulePage);
    }


    /**
     * 删除排班信息
     * @param request
     * @return
     */
    @ApiOperation(value = "删除排班信息")
    @PostMapping("/schedule/remove")
    public Result removeSchedule(HttpServletRequest request) {
        Map<String, Object> paramMap = HttpRequestHelper.switchMap(request.getParameterMap());

        // 获取医院系统传递过来的签名
        String sign = (String) paramMap.get("sign");
        // 获取医院传递过来的医院编码，查询数据库的签名
        String hoscode = (String)paramMap.get("hoscode");
        if(StringUtils.isEmpty(hoscode)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }
        String signKey = hospitalSetService.getSignKey(hoscode);
        // 把数据库查询的签名进行MD5加密
        String signMd5 = MD5.encrypt(signKey);
        if (!sign.equals(signMd5)) {
            throw new YydsException(ResultCodeEnum.SIGN_ERROR);
        }

        String hosScheduleId = (String) paramMap.get("hosScheduleId");
        if (StringUtils.isEmpty(hosScheduleId)) {
            throw new YydsException(ResultCodeEnum.PARAM_ERROR);
        }

        scheduleService.removeSchedule(hoscode, hosScheduleId);
        return Result.ok();
    }

}
