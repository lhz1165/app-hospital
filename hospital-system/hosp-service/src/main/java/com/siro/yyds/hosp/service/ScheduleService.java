package com.siro.yyds.hosp.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.util.pojo.model.hosp.Schedule;
import com.util.pojo.vo.hosp.ScheduleOrderVo;
import com.util.pojo.vo.hosp.ScheduleQueryVo;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.Map;

/**
 * @author docker
 * @date 2022-01-27
 */
public interface ScheduleService extends IService<Schedule> {

    /**
     * 上传排班信息
     * @param paramMap
     */
    void save(Map<String, Object> paramMap);

    /**
     * 分页查询排班信息
     * @param page
     * @param limit
     * @param scheduleQueryVo
     * @return
     */
    Page<Schedule> findPageSchedule(int page, int limit, ScheduleQueryVo scheduleQueryVo);

    /**
     * 删除排班信息
     * @param hoscode
     * @param hosScheduleId
     */
    void removeSchedule(String hoscode, String hosScheduleId);

    /**
     * 根据医院编号 和 科室编号，查询排班规则数据
     * @param page
     * @param limit
     * @param hoscode
     * @param depcode
     * @return
     */
    Map<String, Object> getRuleSchedule(long page, long limit, String hoscode, String depcode);

    /**
     * 根据医院编号、科室编号和工作日期，查询排班详细信息
     * @param hoscode 医院code
     * @param depcode 科室code
     * @param workDate 排班日期
     * @return
     */
    List<Schedule> getDetailSchedule(String hoscode, String depcode, String workDate);

    /**
     * 获取可预约排班数据
     * @param page 当前页码
     * @param limit 每页记录数
     * @param hoscode 医院code
     * @param depcode 科室code
     * @return
     */
    Map<String, Object> getBookingScheduleRule(int page, int limit, String hoscode, String depcode);

    /**
     * 根据id获取排班信息
     * @param scheduleId
     * @return
     */
    Schedule getScheduleId(String scheduleId);

    /**
     * 根据排班id获取预约下单数据
     * @param scheduleId
     * @return
     */
    ScheduleOrderVo getScheduleOrderVo(String scheduleId);

    /**
     * 修改排班数据
     * @param schedule
     */
    void update(Schedule schedule);
}
