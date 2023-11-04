package cn.yujian95.hospital.dto.param;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * @author docker-compose
 * @date 2023/11/1
 */
@ApiModel(value = "HospitalSpecialRelationParam", description = "医院专科关系参数")
@Data
public class HospitalSpecialRelationParam implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 医院编号
     *
     * @mbg.generated
     */
    @ApiModelProperty(value = "医院编号")
    private Long hospitalId;

    /**
     * 专科编号
     *
     * @mbg.generated
     */
    @ApiModelProperty(value = "专科编号")
    private Long specialId;
}
