package com.sist.dao;

import java.util.List;
import java.util.Map;

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
	/** 예약 결제 시 테이블 데이터 삽입 */
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
	
	/** 예약한 날짜 또는 예약 취소한 날짜 달력 반영*/
	public static List<Map<String, Object>> rsvCheckDate(int room_id) {
		SqlSession session = ssf.openSession();
		List<Map<String, Object>> list = session.selectList("rsvCheckDate", room_id);
		session.close();
		return list;
	}
	
	/** 비회원 예약 조회 */
	public static ReservationVO rsvGuestSearch(Map<String, Object> map) {
		try(SqlSession session = ssf.openSession()) {
			ReservationVO vo = session.selectOne("rsvGuestSearch", map);
			return vo;
		}
	}
}
