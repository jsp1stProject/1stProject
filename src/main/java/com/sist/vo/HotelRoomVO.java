package com.sist.vo;

import lombok.Data;

/*
ROOM_ID            NOT NULL NUMBER         
CONTENT_ID         NOT NULL NUMBER         
ROOMTITLE          NOT NULL VARCHAR2(200)  
ROOMSIZE1                   NUMBER         
ROOMSIZE2                   NUMBER         
ROOMBASECOUNT               NUMBER         
OFFSEASON_MINFEE1           NUMBER         
OFFSEASON_MINFEE2           NUMBER         
PEAKSEASON_MINFEE1          NUMBER         
PEAKSEASON_MINFEE2          NUMBER         
ROOMINTRO                   CLOB           
BATHFACILITY                VARCHAR2(10)   
BATH                        VARCHAR2(10)   
AIRCONDITION                VARCHAR2(10)   
TV                          VARCHAR2(10)   
PC                          VARCHAR2(10)   
INTERNET                    VARCHAR2(10)   
REFRIGERATOR                VARCHAR2(10)   
HAIRDRYER                   VARCHAR2(10)   
IMG1                        VARCHAR2(1000) 
IMG1ALT                     VARCHAR2(1000) 
IMG2                        VARCHAR2(1000) 
IMG2ALT                     VARCHAR2(1000) 
IMG3                        VARCHAR2(1000)  
IMG3ALT                     VARCHAR2(1000) 
 */
@Data
public class HotelRoomVO {
	private int room_id, content_id, roomsize1, roomsize2, roombasecount, offseason_minfee1, peakseason_minfee1;
	private String roomtitle, roomintro, bathfacility, bath, aircondition, tv, pc, internet, refrigerator, hairdryer, img1, img2, img3;
}
