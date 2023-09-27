package com.siro.yyds.hosp.controller.api;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.siro.yyds.hosp.service.OrderInfoService;
import com.util.pojo.enums.OrderStatusEnum;
import com.util.pojo.model.order.OrderInfo;
import com.util.pojo.vo.order.OrderQueryVo;
import com.util.result.Result;
import com.util.util.AuthContextHolder;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * @author starsea
 * @date 2022-02-06
 */
@Api(tags = "订单api接口")
@RestController
@RequestMapping("/api/order/orderInfo")
public class OrderApiController {

    @Autowired
    private OrderInfoService orderInfoService;

    /**
     * 创建订单
     * @param scheduleId
     * @param patientId
     * @return
     */
    @ApiOperation(value = "创建订单")
    @PostMapping("/auth/submitOrder/{scheduleId}/{patientId}")
    public Result submitOrder(
            @ApiParam(name = "scheduleId", value = "排班id", required = true)
            @PathVariable String scheduleId,
            @ApiParam(name = "patientId", value = "就诊人id", required = true)
            @PathVariable Long patientId) {
        Long order = orderInfoService.saveOrder(scheduleId, patientId);
        return Result.ok(order);
    }

    /**
     * 根据订单id查询订单详情
     * @param orderId
     * @return
     */
    @ApiOperation(value = "根据订单id查询订单详情")
    @GetMapping("/auth/getOrders/{orderId}")
    public Result getOrders(@PathVariable("orderId") String orderId) {
        OrderInfo orderInfo = orderInfoService.getOrder(orderId);
        return Result.ok(orderInfo);
    }

    /**
     * 订单列表（条件查询带分页）
     * @param page
     * @param limit
     * @param orderQueryVo
     * @return
     */
    @ApiOperation(value = "订单列表（条件查询带分页）")
    @GetMapping("/{page}/{limit}")
    public Result list(@PathVariable("page") Long page,
                       @PathVariable("limit") Long limit,
                       OrderQueryVo orderQueryVo, HttpServletRequest request) {
        // 设置当前用户id
        orderQueryVo.setUserId(AuthContextHolder.getUserId(request));
        Page<OrderInfo> pageParam = new Page<>(page,limit);
        IPage<OrderInfo> pageModel = orderInfoService.selectPage(pageParam, orderQueryVo);
        return Result.ok(pageModel);
    }

    /**
     * 获取订单状态
     * @return
     */
    @ApiOperation(value = "获取订单状态")
    @GetMapping("/getStatusList")
    public Result getStatusList() {
        return Result.ok(OrderStatusEnum.getStatusList());
    }

    /**
     * 取消预约  分两种情况：
     *   1、未支付取消订单，直接通知医院更新取消预约状态
     *   2、已支付取消订单，先退款给用户，然后通知医院更新取消预约状态
     * @param orderId
     * @return
     */
    @ApiOperation(value = "取消预约")
    @GetMapping("/auth/cancelOrder/{orderId}")
    public Result cancelOrder(
            @ApiParam(name = "orderId", value = "订单id", required = true)
            @PathVariable("orderId") Long orderId) {
        return Result.ok(orderInfoService.cancelOrder(orderId));
    }
}
