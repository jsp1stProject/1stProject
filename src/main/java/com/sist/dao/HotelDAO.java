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
	/** 호텔 목록 출력 (숙박 종류, 지역 필터 적용) */
	public static List<HotelVO> hotelListData(Map map) {
		SqlSession session = ssf.openSession();
		List<HotelVO> list = session.selectList("hotelListData", map);
		session.close();
		return list;
	}
	/** 숙박 종류, 지역 필터 동적 적용 된 총 페이지 수 */
	public static int hotelTotalPage(Map map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("hotelTotalPage", map);
		session.close();
		return total;
	}
	/** 숙박 상세보기 - 업소 정보 */
	public static HotelVO hotelDetailData(int content_id) {
		SqlSession session = ssf.openSession();
		HotelVO vo = session.selectOne("hotelDetailData", content_id);
		session.close();
		return vo;
	}
	/** 숙박 상세보기 - 객실 정보 */
	public static List<HotelVO> hotelRoomData(int content_id) {
		SqlSession session = ssf.openSession();
		List<HotelVO> list = session.selectList("hotelRoomData", content_id);
		session.close();
		return list;
	}
	/** 숙박 종류, 지역 필터 동적 적용 된 총 검색 건수 */
	public static int hotelTotalCount(Map map) {
		SqlSession session = ssf.openSession();
		int totalCount = session.selectOne("hotelTotalCount", map);
		session.close();
		return totalCount;
	}
	/** 숙박 상세보기 - 호텔, 객실 이미지 */
	public static List<HotelVO> hotelDetailImg(int content_id) {
		SqlSession session = ssf.openSession();
		List<HotelVO> list = session.selectList("hotelDetailImg", content_id);
		session.close();
		return list;
	}
	/** 호텔 리뷰 삽입 */
	public static void hotelReviewInsert(ReviewVO vo) {
		try(SqlSession session = ssf.openSession(true)) {
			session.insert("hotelReviewInsert", vo);
		}
	}
	/** 호텔 리뷰 수정 */
	public static void hotelReviewUpdate(Map<String, Object> map) {
		try(SqlSession session = ssf.openSession(true)) {
			session.update("hotelReviewUpdate", map);
		}
	}
	/** 호텔 리뷰 삭제 */
	public static void hotelReviewDelete(int no) {
		try(SqlSession session = ssf.openSession(true)) {
			session.delete("hotelReviewDelete", no);
		}
	}
	/** 호텔 리뷰 조회 */
	public static List<ReviewVO> hotelReviewList(int content_id) {
		try(SqlSession session = ssf.openSession(true)) {
			List<ReviewVO> list = session.selectList("hotelReviewList", content_id);
			return list;
		}
	}
}
