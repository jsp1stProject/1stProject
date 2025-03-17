package com.sist.vo;

import java.util.Date;

import lombok.Data;
@Data
public class NoticeVO {
	private int no, hit;
	private String title, subject, content, dbday, type;
	private Date date;
}
