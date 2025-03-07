package com.sist.vo;

import lombok.Data;

@Data
public class HotelVO {
	private int contentId;
	private String checkInTime, checkOutTime, accomCount, chkCooking, infoCenter, parking, roomCount, subfacility, refundRegulation;
	private int barbecue, beauty, beverage, bicycle, campfire, karaoke, fitness, publicbath, sauna, sports;
	private ContentVO cvo = new ContentVO();
	
}
