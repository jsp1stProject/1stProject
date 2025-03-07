package com.sist.vo;

import lombok.Data;

@Data
public class ContentVO {
	private int contentId;
	private String title, addr1, addr2, zipcode, firstImage, firstImage2, tel, cat1, cat2, cat3;
	private int contentTypeId, sigunguCode, areaCode;
	private double mapX, mapY;
	
}
