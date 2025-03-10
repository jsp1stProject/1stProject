package com.sist.vo;

import lombok.Data;

@Data
public class HotelVO {
	private int content_id;
	private String check_in_time, check_out_time, accom_count, chk_cooking, info_center, parking, room_count, subfacility, refund_regulation;
	private int barbecue, beauty, beverage, bicycle, campfire, karaoke, fitness, publicbath, sauna, sports, seminar;
	private ContentVO cvo = new ContentVO();
	private HotelRoomVO hrvo = new HotelRoomVO();
	
}
