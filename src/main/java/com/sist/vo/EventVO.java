package com.sist.vo;

import lombok.Data;

import java.util.Date;
@Data
public class EventVO {
    private int content_id;
    private String sponsor1,sponsor2,playtime,charge,spendtime,agelimit,dbstart,dbend,dbcate,dbarea;
    private Date event_startdate, event_enddate;
    private ContentVO cvo=new ContentVO();
}
