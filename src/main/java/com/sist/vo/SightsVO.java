package com.sist.vo;
/*
 * -------------- -------- -------------- 
CONTENT_ID     NOT NULL NUMBER         
TITLE                   VARCHAR2(150)  
CONTENTTYPE_ID          NUMBER         
ADDR1                   VARCHAR2(500)  
ADDR2                   VARCHAR2(500)  
ZIPCODE                 VARCHAR2(10)   
SIGUNGUCODE             NUMBER         
AREACODE                NUMBER         
FIRST_IMAGE             VARCHAR2(1000) 
FIRST_IMAGE2            VARCHAR2(1000) 
MAPX                    NUMBER(15,10)  
MAPY                    NUMBER(15,10)  
TEL                     VARCHAR2(400)  
CAT1                    VARCHAR2(50)   
CAT2                    VARCHAR2(50)   
CAT3                    VARCHAR2(50)   
OVERVIEW                CLOB           
REVIEW_COUNT            NUMBER      
 */

import lombok.Data;

@Data
public class SightsVO {
	private int content_id,contenttype_id, sigungucode, areacode, mapx, mapy;
	private String title,addr1,addr2,zipcode, first_image,first_image2,cat1,cat2,cat3;
	private ContentVO cvo = new ContentVO();
	private MemberVO mvo = new MemberVO();
}
