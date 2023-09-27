package com.siro.yyds.hosp.controller.api;

import com.siro.yyds.hosp.service.PatientService;
import com.util.pojo.model.user.Patient;
import com.util.result.Result;
import com.util.util.AuthContextHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author docker
 * @date 2022-02-05
 */
@Api(tags = "就诊人管理接口")
@RestController
@RequestMapping("/api/user/patient")
public class PatientApiController {

    @Autowired
    private PatientService patientService;

    /**
     * 获取就诊人列表
     * @param request
     * @return
     */
    @ApiOperation(value = "获取就诊人列表")
    @GetMapping("/auth/findAll")
    public Result findAll(HttpServletRequest request) {
        //获取当前登录用户id
        Long userId = AuthContextHolder.getUserId(request);
        List<Patient> list = patientService.findAllUserId(userId);
        return Result.ok(list);
    }

    /**
     * 添加就诊人
     * @param patient
     * @param request
     * @return
     */
    @ApiOperation(value = "添加就诊人")
    @PostMapping("/auth/save")
    public Result savePatient(@RequestBody Patient patient, HttpServletRequest request) {
        //获取当前登录用户id
        Long userId = AuthContextHolder.getUserId(request);
        patient.setUserId(userId);
        patientService.save(patient);
        return Result.ok();
    }

    /**
     * 根据id获取就诊人信息
     * @param id
     * @return
     */
    @ApiOperation(value = "根据id获取就诊人信息")
    @GetMapping("/auth/get/{id}")
    public Result getPatient(@PathVariable Long id) {
        Patient patient = patientService.getPatientId(id);
        return Result.ok(patient);
    }

    /**
     * 修改就诊人
     * @param patient
     * @return
     */
    @ApiOperation(value = "修改就诊人")
    @PostMapping("/auth/update")
    public Result updatePatient(@RequestBody Patient patient) {
        patientService.updateById(patient);
        return Result.ok();
    }

    /**
     * 删除就诊人
     * @param id
     * @return
     */
    @ApiOperation(value = "删除就诊人")
    @DeleteMapping("/auth/remove/{id}")
    public Result removePatient(@PathVariable Long id) {
        patientService.removeById(id);
        return Result.ok();
    }

    /**
     * 根据就诊人id获取就诊人信息
     * @param id
     * @return
     */
    @ApiOperation(value = "获取就诊人")
    @GetMapping("/inner/get/{id}")
    public Patient getPatientOrder(
            @ApiParam(name = "id", value = "就诊人id", required = true)
            @PathVariable("id") Long id) {
        Patient patient = patientService.getPatientId(id);
        return patient;
    }
}
