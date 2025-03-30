package com.sist.vo;
/*

이름      널?       유형           
------- -------- ------------ 
CNO     NOT NULL NUMBER       
GNO              NUMBER       
ID               VARCHAR2(20) 
ACCOUNT          NUMBER       
PRICE            NUMBER       
ISBUY            CHAR(1)      
REGDATE          DATE      

 */
import java.util.*;

import lombok.Data;

@Data
public class FesCartVO {
	private int cno,fno,account,cart_price;
	private String user_id,isbuy;
	private Date regdate;
	private FesVO fvo=new FesVO();
	private UserVO uvo=new UserVO();
}
