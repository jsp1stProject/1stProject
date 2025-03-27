package com.sist.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
@Getter @Setter
public class ReviewVO {
	private int no, content_id, rate, type;
	private String user_id, message, dbday;
	private Date regdate;
}
