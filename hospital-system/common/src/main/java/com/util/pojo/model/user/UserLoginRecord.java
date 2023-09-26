package com.util.pojo.model.user;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * UserLoginRecord
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "用户登录日志")
@TableName("user_login_record")
public class UserLoginRecord extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	@ApiModelProperty(value = "用户id",example = "1")
	@TableField("user_id")
	private Long userId;

	@ApiModelProperty(value = "ip",example = "1")
	@TableField("ip")
	private String ip;

}

