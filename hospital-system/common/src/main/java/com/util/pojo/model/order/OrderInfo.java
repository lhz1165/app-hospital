package com.util.pojo.model.order;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

/**
 * <p>
 * Order
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "订单表")
@TableName("order_info")
public class OrderInfo extends BaseEntity {
	
	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "userId",example = "1")
	@TableField("user_id")
	private Long userId;

	@ApiModelProperty(value = "订单交易号",example = "1")
	@TableField("out_trade_no")
	private String outTradeNo;

	@ApiModelProperty(value = "医院编号",example = "1")
	@TableField("hoscode")
	private String hoscode;

	@ApiModelProperty(value = "医院名称",example = "1")
	@TableField("hosname")
	private String hosname;

	@ApiModelProperty(value = "科室编号",example = "1")
	@TableField("depcode")
	private String depcode;

	@ApiModelProperty(value = "科室名称",example = "1")
	@TableField("depname")
	private String depname;

	@ApiModelProperty(value = "排班id",example = "1")
	@TableField("hos_schedule_id")
	private String scheduleId;

	@ApiModelProperty(value = "医生职称",example = "1")
	@TableField("title")
	private String title;

	@ApiModelProperty(value = "安排日期",example = "1")
	@JsonFormat(pattern = "yyyy-MM-dd")
	@TableField("reserve_date")
	private Date reserveDate;

	@ApiModelProperty(value = "安排时间（0：上午 1：下午）",example = "1")
	@TableField("reserve_time")
	private Integer reserveTime;

	@ApiModelProperty(value = "就诊人id",example = "1")
	@TableField("patient_id")
	private Long patientId;

	@ApiModelProperty(value = "就诊人名称",example = "1")
	@TableField("patient_name")
	private String patientName;

	@ApiModelProperty(value = "就诊人手机",example = "1")
	@TableField("patient_phone")
	private String patientPhone;

	@ApiModelProperty(value = "预约记录唯一标识（医院预约记录主键）",example = "1")
	@TableField("hos_record_id")
	private String hosRecordId;

	@ApiModelProperty(value = "预约号序",example = "1")
	@TableField("number")
	private Integer number;

	@ApiModelProperty(value = "建议取号时间",example = "1")
	@TableField("fetch_time")
	private String fetchTime;

	@ApiModelProperty(value = "取号地点",example = "1")
	@TableField("fetch_address")
	private String fetchAddress;

	@ApiModelProperty(value = "医事服务费",example = "1")
	@TableField("amount")
	private BigDecimal amount;

	@ApiModelProperty(value = "退号时间",example = "1")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	@TableField("quit_time")
	private Date quitTime;

	@ApiModelProperty(value = "订单状态",example = "1")
	@TableField("order_status")
	private Integer orderStatus;

}

