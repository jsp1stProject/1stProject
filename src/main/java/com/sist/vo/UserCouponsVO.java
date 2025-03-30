package com.sist.vo;

import lombok.Data;
import java.util.*;
@Data
public class UserCouponsVO {
	int no,user_coupon;
	String name, user_id, serial_number, status,info, dbday;
	String issued_at2, expired_at2;
	Date issued_at, expired_at,regdate;
}
