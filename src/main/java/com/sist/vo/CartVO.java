package com.sist.vo;

import lombok.Data;

@Data
public class CartVO {
    private int cno,account,price,total_price;
    private String user_id;
    private ContentVO cvo;
}
