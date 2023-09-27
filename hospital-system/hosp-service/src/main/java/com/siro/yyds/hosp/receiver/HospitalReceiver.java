package com.siro.yyds.hosp.receiver;//package com.siro.yyds.hosp.receiver;
//
//import com.rabbitmq.client.Channel;
//import com.siro.yyds.hosp.service.ScheduleService;
//import com.siro.yyds.model.hosp.Schedule;
//import com.siro.yyds.rabbit.constant.MqConst;
//import com.siro.yyds.rabbit.service.RabbitService;
//import com.siro.yyds.vo.msm.MsmVo;
//import com.siro.yyds.vo.order.OrderMqVo;
//import org.springframework.amqp.core.Message;
//import org.springframework.amqp.rabbit.annotation.Exchange;
//import org.springframework.amqp.rabbit.annotation.Queue;
//import org.springframework.amqp.rabbit.annotation.QueueBinding;
//import org.springframework.amqp.rabbit.annotation.RabbitListener;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//
//import java.io.IOException;
//
///**
// * mq监听器
// * @author docker
// * @date 2022-02-06
// */
//@Component
//public class HospitalReceiver {
//
//    @Autowired
//    private ScheduleService scheduleService;
//
//    @Autowired
//    private RabbitService rabbitService;
//
//    @RabbitListener(bindings = @QueueBinding(
//            value = @Queue(value = MqConst.QUEUE_ORDER, durable = "true"),
//            exchange = @Exchange(value = MqConst.EXCHANGE_DIRECT_ORDER),
//            key = {MqConst.ROUTING_ORDER}
//    ))
//    public void receiver(OrderMqVo orderMqVo, Message message, Channel channel) throws IOException {
//        if (null != orderMqVo.getAvailableNumber()) {
//            // 下单成功更新预约数
//            Schedule schedule = scheduleService.getScheduleId(orderMqVo.getScheduleId());
//            schedule.setReservedNumber(orderMqVo.getReservedNumber());
//            schedule.setAvailableNumber(orderMqVo.getAvailableNumber());
//            scheduleService.update(schedule);
//        } else {
//            //取消预约更新预约数
//            Schedule schedule = scheduleService.getScheduleId(orderMqVo.getScheduleId());
//            int availableNumber = schedule.getAvailableNumber().intValue() + 1;
//            schedule.setAvailableNumber(availableNumber);
//            scheduleService.update(schedule);
//        }
//        // 发送短信
//        MsmVo msmVo = orderMqVo.getMsmVo();
//        if(null != msmVo) {
//            rabbitService.sendMessage(MqConst.EXCHANGE_DIRECT_MSM, MqConst.ROUTING_MSM_ITEM, msmVo);
//        }
//    }
//}
