package com.sist.vo;

import lombok.Data;

@Data
public class ContentVO {
	private int content_id;
	private String title, addr1, addr2, zipcode, first_image, first_image2, tel, cat1, cat2, cat3, overview;
	private int content_type_id, sigungucode, areacode, review_count, review_total;
	private double mapx, mapy; 
	
}
