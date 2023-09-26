package com.util.pojo.enums;

/**
 * @author starsea
 * @date 2022-02-08
 */
public enum PaymentStatusEnum {

    UNPAID(1,"支付中"),
    PAID(2,"已支付"),
    ;

    private Integer status ;
    private String name ;

    PaymentStatusEnum(Integer status, String name) {
        this.status = status;
        this.name=name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
