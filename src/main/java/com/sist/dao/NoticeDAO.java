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
	
	public static List<NoticeVO> noticeListData(Map<String, Object> map) {
		SqlSession session = ssf.openSession();
		List<NoticeVO> list = session.selectList("noticeListData", map);
		session.close();
		return list;
	}
	public static int noticeTotalPage(Map<String, Object> map) {
		SqlSession session = ssf.openSession();
		int total = session.selectOne("noticeTotalPage", map);
		session.close();
		return total;
	}
	public static NoticeVO noticeDetailData(int no) {
		SqlSession session = ssf.openSession();
		session.update("noticeHitIncrement", no);
		session.commit();
		NoticeVO vo = session.selectOne("noticeDetailData", no);
		session.close();
		return vo;
	}
	public static void noticeInsert(NoticeVO vo) {
		SqlSession session = ssf.openSession();
		session.insert("noticeInsert", vo);
		session.commit();
		session.close();
	}
}
