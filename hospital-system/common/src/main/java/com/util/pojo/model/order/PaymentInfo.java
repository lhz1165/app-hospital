package com.util.pojo.model.order;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * <p>
 * PaymentInfo
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "支付记录表")
@TableName("payment_info")
public class PaymentInfo extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	@ApiModelProperty(value = "对外业务编号",example = "1")
	@TableField("out_trade_no")
	private String outTradeNo;

	@ApiModelProperty(value = "订单编号",example = "1")
	@TableField("order_id")
	private Long orderId;

	@ApiModelProperty(value = "支付类型（微信 支付宝）",example = "1")
	@TableField("payment_type")
	private Integer paymentType;

	@ApiModelProperty(value = "交易编号",example = "1")
	@TableField("trade_no")
	private String tradeNo;

	@ApiModelProperty(value = "支付金额",example = "1")
	@TableField("total_amount")
	private BigDecimal totalAmount;

	@ApiModelProperty(value = "交易内容",example = "1")
	@TableField("subject")
	private String subject;

	@ApiModelProperty(value = "支付状态",example = "1")
	@TableField("payment_status")
	private Integer paymentStatus;

	@ApiModelProperty(value = "回调时间",example = "1")
	@TableField("callback_time")
	private Date callbackTime;

	@ApiModelProperty(value = "回调信息",example = "1")
	@TableField("callback_content")
	private String callbackContent;

}

