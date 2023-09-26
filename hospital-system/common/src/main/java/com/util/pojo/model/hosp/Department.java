package com.util.pojo.model.hosp;

import com.util.pojo.model.base.BaseMongoEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * <p>
 * Department
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "科室")
@Document("Department")
public class Department extends BaseMongoEntity {
	
	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "医院编号",example = "1")
	@Indexed //普通索引
	private String hoscode;

	@ApiModelProperty(value = "科室编号",example = "1")
	@Indexed(unique = true) //唯一索引
	private String depcode;

	@ApiModelProperty(value = "科室名称",example = "1")
	private String depname;

	@ApiModelProperty(value = "科室描述",example = "1")
	private String intro;

	@ApiModelProperty(value = "大科室编号",example = "1")
	private String bigcode;

	@ApiModelProperty(value = "大科室名称",example = "1")
	private String bigname;

}

