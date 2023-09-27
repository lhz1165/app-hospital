package com.siro.yyds.hosp.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.util.pojo.model.order.OrderInfo;
import com.util.pojo.vo.order.OrderCountQueryVo;
import com.util.pojo.vo.order.OrderCountVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author starsea
 * @date 2022-02-06
 */
public interface OrderInfoMapper extends BaseMapper<OrderInfo> {

    /**
     * 查询预约统计的数据
     * @param orderCountQueryVo
     * @return
     */
    List<OrderCountVo> selectOrderCount(@Param("vo") OrderCountQueryVo orderCountQueryVo);
}
