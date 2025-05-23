package com.sist.vo;

import lombok.Data;

import java.util.Date;
@Data
public class EventVO {
    private int content_id,price;
    private String sponsor1,sponsor2,playtime,charge,spendtime,agelimit,dbstart,dbend,dbcate,dbarea,price_info,maxprice,minprice,count;
    private Date event_startdate, event_enddate;
    private ContentVO cvo=new ContentVO();
    private EventDetailVO dvo=new EventDetailVO();
    private DetailImgVO divo=new DetailImgVO();
}
