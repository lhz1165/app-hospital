package com.siro.yyds.hosp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.util.pojo.model.order.OrderInfo;
import com.util.pojo.model.order.PaymentInfo;

import java.util.Map;

/**
 * @author docker
 * @date 2023-10-05
 */
public interface PaymentInfoService extends IService<PaymentInfo> {

    /**
     * 保存交易记录
     * @param orderInfo
     * @param paymentType 支付类型（1：微信 2：支付宝）
     */
    void savePaymentInfo(OrderInfo orderInfo, Integer paymentType);

    /**
     * 支付成功
     * @param outTradeNo
     * @param paymentType
     * @param paramMap
     */
    void paySuccess(String outTradeNo, Integer paymentType, Map<String, String> paramMap);

    /**
     * 获取支付记录
     * @param orderId
     * @param paymentType
     * @return
     */
    PaymentInfo getPaymentInfo(Long orderId, Integer paymentType);
}
