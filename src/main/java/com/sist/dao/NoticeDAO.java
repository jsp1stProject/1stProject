package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.NoticeVO;

public class NoticeDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	/** 공지사항 목록 출력(제목 검색 필터 적용) */
	public static List<NoticeVO> noticeListData(Map<String, Object> map) {
		SqlSession session = ssf.openSession();
		List<NoticeVO> list = session.selectList("noticeListData", map);
		session.close();
		return list;
	}
	/** 공지사항 총 페이지 수(제목 검색 필터 적용) */
	public static int noticeTotalPage(Map<String, Object> map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("noticeTotalPage", map);
		session.close();
		return total;
	}
	/** 공지사항 상세보기 */
	public static NoticeVO noticeDetailData(int no) {
		SqlSession session = ssf.openSession();
		session.update("noticeHitIncrement", no);
		session.commit();
		NoticeVO vo = session.selectOne("noticeDetailData", no);
		session.close();
		return vo;
	}
	/** 공지사항 작성 */
	public static void noticeInsert(NoticeVO vo) {
		SqlSession session = ssf.openSession();
		session.insert("noticeInsert", vo);
		session.commit();
		session.close();
	}
	/** 공지사항 수정 */
	public static void noticeUpdate(NoticeVO vo) {
		System.out.println("no: " + vo.getNo());
		System.out.println("sub: " + vo.getSubject());
		System.out.println("con: " + vo.getContent());
		System.out.println("type: " + vo.getType());
		SqlSession session = ssf.openSession();
		session.update("noticeUpdate", vo);
		session.commit();
		session.close();
	}
	/*
	 	 <select id="noticePopUp" resultType="NoticeVO">
		SELECT * FROM notice_board
		ORDER BY regdate DESC
		FETCH FIRST 1 ROW ONLY;
	</select>
	 */
	public static NoticeVO noticePopUp() {
		SqlSession session = ssf.openSession();
		NoticeVO vo = session.selectOne("noticePopUp");
		session.close();
		return vo;
	}
}
