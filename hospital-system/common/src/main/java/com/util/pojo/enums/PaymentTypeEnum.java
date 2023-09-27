package com.util.pojo.enums;

/**
 * @author docker
 * @date 2023-10-05
 */
public enum PaymentTypeEnum {

    ALIPAY(1,"支付宝"),
    WEIXIN(2,"微信"),
    ;

    private Integer status ;
    private String comment ;

    PaymentTypeEnum(Integer status, String comment ){
        this.status = status;
        this.comment=comment;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
