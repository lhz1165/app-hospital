package com.siro.yyds.hosp.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.util.pojo.model.order.PaymentInfo;
import com.util.pojo.model.order.RefundInfo;

/**
 * @author docker
 * @date 2023-10-05
 */
public interface RefundInfoService extends IService<RefundInfo> {

    /**
     * 保存退款记录
     * @param paymentInfo
     */
    RefundInfo saveRefundInfo(PaymentInfo paymentInfo);
}
