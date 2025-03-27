package com.sist.vo;

import lombok.Data;

import java.util.Date;

@Data
public class EventOrderVO {
    private String payment_id, order_id, user_id, dbday, used; //paymentid=pk,seq   order_id=결제 시 생성되는 uuid 주문아이디
    private int account, total_price;
    private Date order_date;
    private ContentVO cvo;
    private EventVO evo;
}
