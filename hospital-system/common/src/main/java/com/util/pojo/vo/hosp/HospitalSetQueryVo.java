package com.util.pojo.vo.hosp;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 医院设置 条件查询vo
 */
@Data
public class HospitalSetQueryVo {

    @ApiModelProperty(value = "医院名称")
    private String hosname;

    @ApiModelProperty(value = "医院编号")
    private String hoscode;
}
