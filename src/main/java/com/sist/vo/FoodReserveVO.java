package com.sist.vo;

import java.util.Date;

import lombok.Data;
import com.sist.vo.*;
/*
 * RES_ID   NOT NULL NUMBER       
RES_DATE NOT NULL DATE         
RES_TIME NOT NULL VARCHAR2(10) 
PEOPLE   NOT NULL NUMBER       
STATUS            VARCHAR2(20)
 */
@Data
public class FoodReserveVO {
	private int res_id,people;
	private String res_time,status,dbday;
	private Date res_date;
	private UserVO uvo=new UserVO();
	private FoodVO fvo=new FoodVO();
}
