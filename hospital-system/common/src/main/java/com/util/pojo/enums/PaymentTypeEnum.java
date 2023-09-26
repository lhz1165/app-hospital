package com.util.pojo.enums;

/**
 * @author starsea
 * @date 2022-02-08
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
