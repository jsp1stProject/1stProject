package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.HotelVO;
import com.sist.vo.ReservationVO;

public class ReservationDAO {
private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	public static void rsvInsert(ReservationVO vo) {
		SqlSession session = ssf.openSession();
		session.insert("rsvInsert", vo);
		session.commit();
		session.close();
	}
	
	/** 예약 페이지 데이터 출력 */
	public static HotelVO rsvHotelData(int room_id) {
		SqlSession session = ssf.openSession();
		HotelVO vo = session.selectOne("rsvHotelData", room_id);
		session.close();
		return vo;
	}
}
