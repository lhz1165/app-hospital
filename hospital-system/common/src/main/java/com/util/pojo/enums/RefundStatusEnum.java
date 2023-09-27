package com.util.pojo.enums;

/**
 * @author docker
 * @date 2023-10-05
 */
public enum RefundStatusEnum {

    UNREFUND(1,"退款中"),
    REFUND(2,"已退款"),
    ;

    private Integer status ;
    private String name ;

    RefundStatusEnum(Integer status, String name) {
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
