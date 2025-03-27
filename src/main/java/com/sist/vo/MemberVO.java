package com.sist.vo;

import lombok.Data;

/*
 *  이름       널?       유형            
-------- -------- ------------- 
USER_ID       NOT NULL VARCHAR2(20)  
PWD      NOT NULL VARCHAR2(10)  
NAME     NOT NULL VARCHAR2(51)  
SEX               VARCHAR2(20)  
BIRTHDAY NOT NULL VARCHAR2(30)  
EMAIL             VARCHAR2(100) 
POST     NOT NULL VARCHAR2(20)  
ADDR1    NOT NULL VARCHAR2(200) 
ADDR2             VARCHAR2(200) 
PHONE             VARCHAR2(20)  
CONTENT           CLOB          
ADMIN             CHAR(1)  
 * 
 */
@Data
public class MemberVO {
	private String user_id,pwd,name,nickname,profile_img,sex,birthday,email,post,addr1,addr2,phone,admin,msg;
	private int eventcart_count; //행사 장바구니 수량
}