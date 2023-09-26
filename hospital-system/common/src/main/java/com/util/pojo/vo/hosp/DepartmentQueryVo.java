package com.util.pojo.vo.hosp;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(description = "Department")
public class DepartmentQueryVo {
	
	@ApiModelProperty(value = "医院编号",example = "1")
	private String hoscode;

	@ApiModelProperty(value = "科室编号",example = "1")
	private String depcode;

	@ApiModelProperty(value = "科室名称",example = "1")
	private String depname;

	@ApiModelProperty(value = "大科室编号",example = "1")
	private String bigcode;

	@ApiModelProperty(value = "大科室名称",example = "1")
	private String bigname;

}

