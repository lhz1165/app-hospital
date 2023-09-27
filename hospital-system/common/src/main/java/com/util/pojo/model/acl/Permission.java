package com.util.pojo.model.acl;

/**
 * @author docker
 * @date 2022-01-20
 */

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * <p>
 * 权限
 * </p>
 *
 * @author qy
 * @since 2019-11-08
 */
@Data
@ApiModel(description = "权限")
@TableName("acl_permission")
public class Permission extends BaseEntity {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "所属上级",example = "1")
    @TableField("pid")
    private Long pid;

    @ApiModelProperty(value = "名称",example = "1")
    @TableField("name")
    private String name;

    @ApiModelProperty(value = "类型(1:菜单,2:按钮)",example = "1")
    @TableField("type")
    private Integer type;

    @ApiModelProperty(value = "权限值",example = "1")
    @TableField("permission_value")
    private String permissionValue;

    @ApiModelProperty(value = "路径",example = "1")
    @TableField("path")
    private String path;

    @ApiModelProperty(value = "component",example = "1")
    @TableField("component")
    private String component;

    @ApiModelProperty(value = "图标",example = "1")
    @TableField("icon")
    private String icon;

    @ApiModelProperty(value = "状态(0:禁止,1:正常)",example = "1")
    @TableField("status")
    private Integer status;

    @ApiModelProperty(value = "层级",example = "1")
    @TableField(exist = false)
    private Integer level;

    @ApiModelProperty(value = "下级",example = "1")
    @TableField(exist = false)
    private List<Permission> children;

    @ApiModelProperty(value = "是否选中",example = "1")
    @TableField(exist = false)
    private boolean isSelect;
}
