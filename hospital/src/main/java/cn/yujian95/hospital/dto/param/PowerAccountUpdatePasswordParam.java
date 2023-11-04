package cn.yujian95.hospital.dto.param;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * @author docker-compose
 * @date 2023/11/1
 */
@ApiModel(value = "PowerAccountUpdatePasswordParam", description = "权限账号修改密码参数")
@Data
public class PowerAccountUpdatePasswordParam implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "账号编号")
    private Long accountId;

    @ApiModelProperty(value = "旧密码 必须加密")
    private String password;

    @ApiModelProperty(value = "新密码 必须加密")
    private String newPassword;
}
