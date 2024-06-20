package cn.yujian95.hospital.dto;

import cn.yujian95.hospital.entity.PowerAccount;
import cn.yujian95.hospital.entity.UserBasicInfo;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * @author docker-compose
 * @date 2023/11/1
 */

@ApiModel(value = "UserInfoDTO2", description = "用户信息封装对象")
@Data
public class UserInfoDTO2 implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "编号")
    private Long id;

    /**
     * 登录账号 唯一
     *
     * @mbg.generated
     */
    @ApiModelProperty(value = "登录账号 唯一")
    private String name;

    /**
     * 登录密码 使用md5加密
     *
     * @mbg.generated
     */
    @ApiModelProperty(value = "登录密码 使用md5加密")
    private String password;


    @ApiModelProperty(value = "手机号")
    private String phone;

}
