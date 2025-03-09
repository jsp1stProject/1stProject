package com.sist.dao;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.io.*;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.*;

public class HotelDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	public static List<ContentVO> hotelListData(Map map) {
		SqlSession session = ssf.openSession();
		List<ContentVO> list = session.selectList("hotelListData", map);
		session.close();
		return list;
	}
	public static int hotelTotalPage(String search) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("hotelTotalPage", search);
		session.close();
		return total;
	}
	public static HotelVO hotelDetailData(int content_id) {
		SqlSession session = ssf.openSession();
		HotelVO vo = session.selectOne("hotelDetailData", content_id);
		session.close();
		return vo;
	}
	public static List<HotelVO> hotelRoomData(int content_id) {
		SqlSession session = ssf.openSession();
		List<HotelVO> list = session.selectList("hotelRoomData", content_id);
		session.close();
		return list;
	}
}
