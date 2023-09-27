package com.siro.yyds.hosp.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.util.pojo.model.order.OrderInfo;
import com.util.pojo.vo.order.OrderCountQueryVo;
import com.util.pojo.vo.order.OrderQueryVo;

import java.util.Map;

/**
 * @author starsea
 * @date 2022-02-06
 */
public interface OrderInfoService extends IService<OrderInfo> {

    /**
     * 保存订单
     * @param scheduleId
     * @param patientId
     * @return
     */
    Long saveOrder(String scheduleId, Long patientId);

    /**
     * 根据订单id查询订单详情
     * @param orderId
     * @return
     */
    OrderInfo getOrder(String orderId);

    /**
     * 订单列表（条件查询带分页）
     * @param pageParam
     * @param orderQueryVo
     * @return
     */
    IPage<OrderInfo> selectPage(Page<OrderInfo> pageParam, OrderQueryVo orderQueryVo);

    /**
     * 订单详情
     * @param orderId
     * @return
     */
    Map<String,Object> showDetail(Long orderId);

    /**
     * 取消订单
     * @param orderId
     */
    Boolean cancelOrder(Long orderId);

    /**
     * 就诊提醒
     */
    void patientTips();

    /**
     * 订单统计
     * @param orderCountQueryVo
     * @return
     */
    Map<String, Object> getCountMap(OrderCountQueryVo orderCountQueryVo);
}
