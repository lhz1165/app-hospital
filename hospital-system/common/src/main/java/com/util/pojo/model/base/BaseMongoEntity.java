package com.util.pojo.model.base;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author starsea
 * @date 2022-01-20
 */
@Data
public class BaseMongoEntity implements Serializable {

    @ApiModelProperty(value = "id",example = "1")
    @Id
    private String id;

    @ApiModelProperty(value = "创建时间",example = "1")
    private Date createTime;

    @ApiModelProperty(value = "更新时间",example = "1")
    private Date updateTime;

    @ApiModelProperty(value = "逻辑删除(1:已删除，0:未删除)",example = "1")
    private Integer isDeleted;

    @ApiModelProperty(value = "其他参数",example = "1")
    @Transient //被该注解标注的，将不会被录入到数据库中。只作为普通的javaBean属性
    private Map<String,Object> param = new HashMap<>();
}
