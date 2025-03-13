package com.sist.vo;
/*
USER_ID     NOT NULL VARCHAR2(50)  
PWD         NOT NULL VARCHAR2(50)  
NAME        NOT NULL VARCHAR2(50)  
NICKNAME    NOT NULL VARCHAR2(50)  
PROFILE_IMG          VARCHAR2(300) 
SEX         NOT NULL VARCHAR2(10)  
BIRTHDAY    NOT NULL DATE          
EMAIL       NOT NULL VARCHAR2(100) 
POST        NOT NULL VARCHAR2(7)   
ADDR1       NOT NULL VARCHAR2(100) 
ADDR2                VARCHAR2(100) 
PHONE       NOT NULL VARCHAR2(14)  
ADMIN                CHAR(1)
 */

import java.util.Date;

import lombok.Data;
@Data
public class UserVO {
	private String user_id, pwd, name, nickname, profile_img, sex, email, post, addr1, addr2, phone, admin;
	private Date birthday;
}
