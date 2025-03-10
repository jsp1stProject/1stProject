package com.sist.vo;

import lombok.Data;

@Data
public class ContentVO {
	private int content_id;
	private String title, addr1, addr2, zipcode, first_image, first_image2, tel, cat1, cat2, cat3;
	private int content_type_id, sigungucode, areacode;
	private double mapx, mapy; 
	
}
