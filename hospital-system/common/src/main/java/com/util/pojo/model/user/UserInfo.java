package com.util.pojo.model.user;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * UserInfo
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "UserInfo")
@TableName("user_info")
public class UserInfo extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	@ApiModelProperty(value = "微信openid",example = "1")
	@TableField("openid")
	private String openid;

	@ApiModelProperty(value = "昵称",example = "1")
	@TableField("nick_name")
	private String nickName;

	@ApiModelProperty(value = "手机号",example = "1")
	@TableField("phone")
	private String phone;

	@ApiModelProperty(value = "用户姓名",example = "1")
	@TableField("name")
	private String name;

	@ApiModelProperty(value = "证件类型",example = "1")
	@TableField("certificates_type")
	private String certificatesType;

	@ApiModelProperty(value = "证件编号",example = "1")
	@TableField("certificates_no")
	private String certificatesNo;

	@ApiModelProperty(value = "证件路径",example = "1")
	@TableField("certificates_url")
	private String certificatesUrl;

	@ApiModelProperty(value = "认证状态（0：未认证 1：认证中 2：认证成功 -1：认证失败）",example = "1")
	@TableField("auth_status")
	private Integer authStatus;

	@ApiModelProperty(value = "状态（0：锁定 1：正常）",example = "1")
	@TableField("status")
	private Integer status;

}

