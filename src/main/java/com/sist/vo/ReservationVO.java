package com.sist.vo;

import java.util.*;
import lombok.Data;

@Data
public class ReservationVO {
	private int reserve_id, content_id, room_id, offseason_minfee1, people_count, pay_amount, user_coupon;
	private String guest_name, guest_phone, arrival_type, user_id, status, regdate, checkIn, checkOut;
	private Date reserve_date, check_in_date, check_out_date;
	private boolean isCouponApplied, isMember;
	private ContentVO cvo = new ContentVO();
	private HotelRoomVO hrvo = new HotelRoomVO();
}
