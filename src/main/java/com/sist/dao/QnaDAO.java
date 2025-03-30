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
	
	/*
	<select id="qnaDetailData" resultType="QnABoardVO" parameterType="int">
    SELECT no,name,user_id,subject,email,phone,type,type_detail,reserve_no,filename,filesize,content,hit,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,group_id
    FROM qna_board
    WHERE no=#{no}
	</select>
	*/
	public static QnaVO qnaDetailData(int no)
	{
		SqlSession session = ssf.openSession();
		session.update("qnaHitIncrement",no);
		session.commit();
		QnaVO vo = session.selectOne("qnaDetailData",no);
		session.close();
		return vo;
	}
	
	
	 public static void qnaUpdate(QnaVO vo)
	 {
		   // insert/update/delete => 가독성 
		   SqlSession session=ssf.openSession(true);
		   session.update("qnaUpdate",vo);
		   session.close();
	 }
	 
	 public static QnaVO qnaUpdateData(int no)
	 {
		 SqlSession session=ssf.openSession();
		 QnaVO vo=session.selectOne("qnaDetailData",no);
		 session.close();
		 return vo;
	 }
	 
	
	 
	 public static void qnaDelete(int group_id)
	 {
		   SqlSession session=ssf.openSession(true);
		   session.insert("qnaDelete",group_id);
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

	
	public static QnaVO qnaAdminDetailData(int group_id)
	{
		SqlSession session=ssf.openSession();
		QnaVO vo=session.selectOne("qnaAdminDetailData",group_id);
		session.close();
		return vo;
	}
	
	public static void qnaAdminInsert(QnaVO vo)
	{
		SqlSession session=null;
		try
		{
			session=ssf.openSession();
			System.out.println("그룹아이디 : "+vo.getGroup_id());
			session.update("qnaAdminAnOKChange",vo.getGroup_id());
			System.out.println("어드민오케이?");
			session.insert("qnaAdminInsert",vo);
			session.commit();// 동시에 저장 
		}catch(Exception ex){
			System.out.println("실패");
			session.rollback(); // 동시에 취소 
		}finally{
			if(session!=null)
				session.close();
		}
		   
	 }
	
	 public static void qnaAdminUpdate(QnaVO vo)
	 {
		   // insert/update/delete => 가독성 
		   SqlSession session=ssf.openSession(true);
		   session.update("qnaUpdate",vo);
		   session.close();
	 }
	 
	 public static QnaVO qnaAdminUpdateData(int no)
	 {
		 SqlSession session=ssf.openSession();
		 QnaVO vo=session.selectOne("qnaAdminDetailData",no);
		 session.close();
		 return vo;
	 }
	 
	public static void qnaAdminDelete(int group_id)
	{
		SqlSession session=null;
		try
		{
			session=ssf.openSession();
			System.out.println("qnaAdminDeleteOk");
			session.update("qnaAdminDeleteOk",group_id);
			System.out.println("qnaAdminDelete");
			session.delete("qnaAdminDelete",group_id);
			session.commit();// 동시에 저장 
		}catch(Exception ex){
			ex.printStackTrace();
			session.rollback(); // 동시에 취소 
		}finally{
			if(session!=null)
				session.close();
		}
	}
	   
}



