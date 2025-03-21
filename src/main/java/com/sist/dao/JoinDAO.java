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
	/** 회원가입 성공 시 데이터 삽입 */
	public static void userIdInsert(UserVO vo) {
		SqlSession session = ssf.openSession();
		session.insert("userInsert", vo);
		session.commit();
		session.close();
	}
	/** 회원가입 시 아이디 중복 검사 */
	public static int userIdCheck(String user_id) {
		SqlSession session = ssf.openSession();
		int idCount = session.selectOne("userIdCheck", user_id);
		session.close();
		return idCount;
	}
}
