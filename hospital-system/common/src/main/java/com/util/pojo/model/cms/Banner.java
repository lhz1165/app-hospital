package com.util.pojo.model.cms;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.util.pojo.model.base.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * 首页Banner实体
 * </p>
 *
 * @author qy
 * @since 2019-11-08
 */
@Data
@ApiModel(description = "首页Banner实体")
@TableName("banner")
public class Banner extends BaseEntity {
	
	private static final long serialVersionUID = 1L;
	
	@ApiModelProperty(value = "标题",example = "1")
	@TableField("title")
	private String title;

	@ApiModelProperty(value = "图片地址",example = "1")
	@TableField("image_url")
	private String imageUrl;

	@ApiModelProperty(value = "链接地址",example = "1")
	@TableField("link_url")
	private String linkUrl;

	@ApiModelProperty(value = "排序",example = "1")
	@TableField("sort")
	private Integer sort;

}

