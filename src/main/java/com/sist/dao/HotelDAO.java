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
	
	public static List<ContentVO> hotelListData() {
		SqlSession session = ssf.openSession();
		List<ContentVO> list = session.selectList("hotelListData");
		session.close();
		return list;
	}
	public static int hotelTotalPage() {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("hotelTotalPage");
		session.close();
		return total;
	}
}
