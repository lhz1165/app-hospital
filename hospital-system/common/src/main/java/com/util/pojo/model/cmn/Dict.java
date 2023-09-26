package com.util.pojo.model.cmn;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * Dict
 * </p>
 *
 * @author qy
 */
@Data
@ApiModel(description = "数据字典")
@TableName("dict")
public class Dict {

    @ApiModelProperty(value = "id",example = "1")
    private Long id;

    @ApiModelProperty(value = "上级id",example = "1")
    @TableField("parent_id")
    private Long parentId;

    @ApiModelProperty(value = "名称",example = "1")
    @TableField("name")
    private String name;

    @ApiModelProperty(value = "值",example = "1")
    @TableField("value")
    private String value;

    @ApiModelProperty(value = "编码",example = "1")
    @TableField("dict_code")
    private String dictCode;

    @ApiModelProperty(value = "创建时间",example = "1")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField("create_time")
    private Date createTime;

    @ApiModelProperty(value = "更新时间",example = "1")
    @TableField("update_time")
    private Date updateTime;

    @ApiModelProperty(value = "逻辑删除(1:已删除，0:未删除)",example = "1")
    @TableLogic
    @TableField("is_deleted")
    private Integer isDeleted;

    @ApiModelProperty(value = "是否包含子节点",example = "1")
    @TableField(exist = false)
    private boolean hasChildren;

    @ApiModelProperty(value = "其他参数",example = "1")
    @TableField(exist = false)
    private Map<String,Object> param = new HashMap<>();

}