package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.commons.CreateSqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;

public class QnaDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	/*
	<select id="qnaListData" resultType="QnaVO" parameterType="hashmap">
	 SELECT no,subject,name,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,group_tab,num
	 FROM (SELECT no,subject,name,regdate,hit,group_tab,rownum as num 
	 FROM (SELECT no,subject,name,regdate,hit,group_tab
	 FROM qna_board ORDER BY group_id DESC,group_step ASC))
	 WHERE num BETWEEN #{start} AND #{end}
	</select>
	<select id="qnaRowCount" resultType="int">
	 SELECT COUNT(*) 
	 FROM qna_Board
	</select>


	*/
	public static List<QnaDAO> qnaListData(Map map)
	{
		SqlSession session = ssf.openSession();
		List<QnaDAO> list = session.selectList("qnaListData",map);
		session.close();
		return list;
	}
	
	public static int qnaRowCount()
	{
		SqlSession session = ssf.openSession();
		int count = session.selectOne("qnaRowCount");
		session.close();
		return count;
	}
	
	public static void qnaInsert(QnaVO vo)
	{
		SqlSession session = ssf.openSession(true);
		session.insert("qnaInsert",vo);
		session.close();
	}
	
	public static List<QnaVO> qnaAdminListData(Map map)
	{
		SqlSession session = ssf.openSession();
		List<QnaVO> list = session.selectList("qnaAdminListData",map);
		session.close();
		return list;
	}
	
	public static int qnaAdminRowCount()
	{
		SqlSession session = ssf.openSession();
		int count = session.selectOne("qnaAdminRowCount");
		session.close();
		return count;
	}
	
	
}



