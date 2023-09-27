package com.siro.yyds.hosp.service;


import com.util.pojo.model.hosp.Department;
import com.util.pojo.vo.hosp.DepartmentQueryVo;
import com.util.pojo.vo.hosp.DepartmentVo;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Map;

/**
 * @author docker
 * @date 2023-10-05
 */
public interface DepartmentService {

    /**
     * 保存科室信息
     * @param paramMap
     */
    void save(Map<String, Object> paramMap);

    /**
     * 分页查询科室信息
     * @param page
     * @param limit
     * @param departmentQueryVo
     * @return
     */
    Page<Department> findPageDepartment(int page, int limit, DepartmentQueryVo departmentQueryVo);

    /**
     * 删除科室信息
     * @param hoscode
     * @param depcode
     */
    void removeDepartment(String hoscode, String depcode);

    /**
     * 根据医院编号，查询医院所有科室列表
     * @param hoscode
     * @return
     */
    List<DepartmentVo> findDeptTree(String hoscode);

    /**
     * 根据医院编号 和 科室编号，查询科室名称
     * @param hoscode
     * @param depcode
     * @return
     */
    String getDepName(String hoscode, String depcode);

    /**
     * 根据医院编号 和 科室编号，查询科室对象
     * @param hoscode
     * @param depcode
     * @return
     */
    Department getDepartment(String hoscode, String depcode);
}
