package com.util.pojo.model.hosp;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * HospitalSet
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "医院设置")
@TableName("hospital_set")
public class HospitalSet extends BaseEntity {

	@ApiModelProperty(value = "医院名称",example = "1")
	@TableField("hosname")
	private String hosname;

	@ApiModelProperty(value = "医院编号",example = "1")
	@TableField("hoscode")
	private String hoscode;

	@ApiModelProperty(value = "api基础路径",example = "1")
	@TableField("api_url")
	private String apiUrl;

	@ApiModelProperty(value = "签名秘钥",example = "1")
	@TableField("sign_key")
	private String signKey;

	@ApiModelProperty(value = "联系人姓名",example = "1")
	@TableField("contacts_name")
	private String contactsName;

	@ApiModelProperty(value = "联系人手机",example = "1")
	@TableField("contacts_phone")
	private String contactsPhone;

	/**
	 * 状态 1:可用 0：不可用
	 */
	@ApiModelProperty(value = "状态",example = "1")
	@TableField("status")
	private Integer status;

}

