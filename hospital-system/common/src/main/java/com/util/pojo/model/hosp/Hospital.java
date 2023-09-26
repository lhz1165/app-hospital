package com.util.pojo.model.hosp;

import com.alibaba.fastjson.JSONObject;
import com.util.pojo.model.base.BaseMongoEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * <p>
 * Hospital
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "医院")
@Document("Hospital")
public class Hospital extends BaseMongoEntity {
	
	private static final long serialVersionUID = 1L;
	
	@ApiModelProperty(value = "医院编号",example = "1")
	@Indexed(unique = true) //唯一索引
	private String hoscode;

	@ApiModelProperty(value = "医院名称",example = "1")
	@Indexed //普通索引
	private String hosname;

	@ApiModelProperty(value = "医院类型",example = "1")
	private String hostype;

	@ApiModelProperty(value = "省code",example = "1")
	private String provinceCode;

	@ApiModelProperty(value = "市code",example = "1")
	private String cityCode;

	@ApiModelProperty(value = "区code",example = "1")
	private String districtCode;

	@ApiModelProperty(value = "详情地址",example = "1")
	private String address;

	@ApiModelProperty(value = "医院logo",example = "1")
	private String logoData;

	@ApiModelProperty(value = "医院简介",example = "1")
	private String intro;

	@ApiModelProperty(value = "坐车路线",example = "1")
	private String route;

	@ApiModelProperty(value = "状态 0：未上线 1：已上线",example = "1")
	private Integer status;

	//预约规则
	@ApiModelProperty(value = "预约规则",example = "1")
	private BookingRule bookingRule;

	public void setBookingRule(String bookingRule) {
		this.bookingRule = JSONObject.parseObject(bookingRule, BookingRule.class);
	}

}

