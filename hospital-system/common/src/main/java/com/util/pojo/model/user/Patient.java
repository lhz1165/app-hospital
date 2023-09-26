package com.util.pojo.model.user;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

/**
 * <p>
 * Patient
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "Patient")
@TableName("patient")
public class Patient extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	@ApiModelProperty(value = "用户id",example = "1")
	@TableField("user_id")
	private Long userId;

	@ApiModelProperty(value = "姓名",example = "1")
	@TableField("name")
	private String name;

	@ApiModelProperty(value = "证件类型",example = "1")
	@TableField("certificates_type")
	private String certificatesType;

	@ApiModelProperty(value = "证件编号",example = "1")
	@TableField("certificates_no")
	private String certificatesNo;

	@ApiModelProperty(value = "性别",example = "1")
	@TableField("sex")
	private Integer sex;

	@ApiModelProperty(value = "出生年月",example = "1")
	@JsonFormat(pattern = "yyyy-MM-dd")
	@TableField("birthdate")
	private Date birthdate;

	@ApiModelProperty(value = "手机",example = "1")
	@TableField("phone")
	private String phone;

	@ApiModelProperty(value = "是否结婚",example = "1")
	@TableField("is_marry")
	private Integer isMarry;

	@ApiModelProperty(value = "省code",example = "1")
	@TableField("province_code")
	private String provinceCode;

	@ApiModelProperty(value = "市code",example = "1")
	@TableField("city_code")
	private String cityCode;

	@ApiModelProperty(value = "区code",example = "1")
	@TableField("district_code")
	private String districtCode;

	@ApiModelProperty(value = "详情地址",example = "1")
	@TableField("address")
	private String address;

	@ApiModelProperty(value = "联系人姓名",example = "1")
	@TableField("contacts_name")
	private String contactsName;

	@ApiModelProperty(value = "联系人证件类型",example = "1")
	@TableField("contacts_certificates_type")
	private String contactsCertificatesType;

	@ApiModelProperty(value = "联系人证件号",example = "1")
	@TableField("contacts_certificates_no")
	private String contactsCertificatesNo;

	@ApiModelProperty(value = "联系人手机",example = "1")
	@TableField("contacts_phone")
	private String contactsPhone;

	@ApiModelProperty(value = "是否有医保",example = "1")
	@TableField("is_insure")
	private Integer isInsure;

	@ApiModelProperty(value = "就诊卡",example = "1")
	@TableField("card_no")
	private String cardNo;

	@ApiModelProperty(value = "状态（0：默认 1：已认证）",example = "1")
	@TableField("status")
	private String status;
}

