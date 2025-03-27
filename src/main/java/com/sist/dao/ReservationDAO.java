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
	/** 비회원 예약 시 예약 번호 부여*/
	public static int rsvGuestRsvId() {
		try(SqlSession session = ssf.openSession()) {
			int rsvId = session.selectOne("rsvGuestRsvId");
			return rsvId;
		}
	}
	/** 비회원 예약 조회 */
	public static ReservationVO rsvGuestSearch(Map<String, Object> map) {
		try(SqlSession session = ssf.openSession()) {
			ReservationVO vo = session.selectOne("rsvGuestSearch", map);
			return vo;
		}
	}
	/** 관리자용 예약 관리 조회*/
	public static List<ReservationVO> rsvAdminData() {
		try(SqlSession session = ssf.openSession()) {
			List<ReservationVO> list = session.selectList("rsvAdminData");
			return list;
		}
	}
	/** 관리자 예약 승인 */
	public static void rsvUpdateApprove(int reserve_id) {
		try(SqlSession session = ssf.openSession(true)) {
			session.update("rsvUpdateApprove", reserve_id);
		}
	}
	/** 관리자 예약 거부 */
	public static void rsvUpdateReject(int reserve_id) {
		try(SqlSession session = ssf.openSession(true)) {
			session.update("rsvUpdateReject", reserve_id);
		}
	}
	/** 비회원 예약 취소 */
	public static void rsvCancel(int reserve_id) {
		try(SqlSession session = ssf.openSession(true)) {
			session.update("rsvCancel", reserve_id);
		}
	}
	/** 비회원 예약 취소 완료 */
	public static void rsvCancelApprove(int reserve_id) {
		try(SqlSession session = ssf.openSession(true)) {
			session.update("rsvCancelApprove", reserve_id);
		}
	}
}
