package com.util.pojo.vo.hosp;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 医院 条件查询vo
 */
@Data
@ApiModel(description = "Hospital")
public class HospitalQueryVo implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@ApiModelProperty(value = "医院编号")
	private String hoscode;

	@ApiModelProperty(value = "医院名称")
	private String hosname;

	@ApiModelProperty(value = "医院类型")
	private String hostype;

	@ApiModelProperty(value = "省code")
	private String provinceCode;

	@ApiModelProperty(value = "市code")
	private String cityCode;

	@ApiModelProperty(value = "区code")
	private String districtCode;

	@ApiModelProperty(value = "状态",example = "1")
	private Integer status;
}

