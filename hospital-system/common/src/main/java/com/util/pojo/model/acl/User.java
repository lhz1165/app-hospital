package com.util.pojo.model.acl;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * 用户
 * </p>
 *
 * @author qy
 * @since 2019-11-08
 */
@Data
@ApiModel(description = "用户")
@TableName("acl_user")
public class User extends BaseEntity {

	private static final long serialVersionUID = 1L;

	@ApiModelProperty(value = "用户名",example = "1")
	@TableField("username")
	private String username;

	@ApiModelProperty(value = "密码",example = "1")
	@TableField("password")
	private String password;

	@ApiModelProperty(value = "昵称",example = "1")
	@TableField("nick_name")
	private String nickName;

	@ApiModelProperty(value = "用户头像",example = "1")
	@TableField("salt")
	private String salt;

	@ApiModelProperty(value = "用户签名",example = "1")
	@TableField("token")
	private String token;

}



