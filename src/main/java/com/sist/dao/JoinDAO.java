package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.UserVO;

public class JoinDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	public static void userIdInsert(UserVO vo) {
		SqlSession session = ssf.openSession();
		session.insert("userIdInsert", vo);
		session.commit();
		session.close();
	}
	public static int userIdCheck(String user_id) {
		SqlSession session = ssf.openSession();
		int idCount = session.selectOne("userIdCheck", user_id);
		session.close();
		return idCount;
	}
}
