package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;
public class FesDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf=CreateSqlSessionFactory.getSsf();
	}
	
	
	public static List<FesVO> fesHomeData()
	{
		List<FesVO> list=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  list=session.selectList("fesHomeData");
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return list;
	}
	
	public static List<FesVO> fesHomeData_DATE()
	{
		List<FesVO> list=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  list=session.selectList("fesHomeData_DATE");
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return list;
	}
	
	public static List<NoticeVO> fesHomeNotice()
	{
		List<NoticeVO> list=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  list=session.selectList("fesHomeNotice");
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return list;
	}
	
	/*
	<select id="fesHomeFindData" resultType="FesVO" parameterType="hashmap">
	SELECT content_id, title, addr1, addr2,first_image, review_count, event_startdate, event_enddate, charge, agelimit, price, num
	FROM (SELECT content_id, title, addr1, addr2, first_image, review_count, event_startdate, event_enddate, charge, agelimit, price, rownum as num
	FROM (SELECT content.content_id, title, addr1, addr2, first_image, review_count, event_startdate, event_enddate, charge, agelimit, price
	FROM content, event
	WHERE content.content_id=event.content_id AND content.cat2='A0207' 
		 AND title LIKE '%'||#{search}||'%' ORDER BY content_id
	))
	WHERE WHERE num BETWEEN #{start} AND #{end}	 

	</select>
	*/
	public static List<FesVO> fesHomeFindData(Map map)
	{
		List<FesVO> list=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  list=session.selectList("fesHomeFindData",map);
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return list;
	}
	
	/*
	<select id="fesHomeTotalPage" resultType="int" parameterType="string"> 
	  SELECT CEIL(COUNT(*)/12.0) 
	  FROM content,event 
	  WHERE content.content_id=event.content_id 
	  AND content.cat2='A0207'
	  AND  title||addr1 LIKE '%'||#{search}||'%' 
	</select>
	
	 */
	
	public static int fesHomeTotalCount(String search)
	{
		int total=0;
		SqlSession session=null;
		try
		{
		 session=ssf.openSession();
		 total=session.selectOne("fesHomeTotalCount", search);
		}
		catch (Exception e) 
		{
		// TODO: handle exception
		 e.printStackTrace();
		}
		finally
		{
		 if(session!=null)
		  session.close();
		}
		  
		return total;
	}
	
	public static FesVO fesMainHouseData()
	{
		System.out.println("DAO진입");
		SqlSession session = ssf.openSession();
		System.out.println("vo값 받아오기");
		FesVO vo = session.selectOne("fesMainHouseData");
		System.out.println("vo값 받아오기완료");
		session.close();
		return vo;
	}
	
	public static List<FesVO> fesMainHouseData8()
	{
		SqlSession session=ssf.openSession();
		List<FesVO> list=session.selectList("fesMainHouseData8");
		session.close();
		return list;
	}
	
	/*
	 <select id="fesListData" resultType="FesVO" parameterType="hashmap">

   SELECT content_id, title, contenttype_id, addr1, tel, event_startdate, event_enddate,agelimit, num
	FROM (SELECT content_id, title, contenttype_id, addr1, tel, event_startdate, event_enddate,agelimit, rownum as num
	FROM (SELECT content.content_id, title, contenttype_id, addr1, tel, event_startdate, event_enddate,agelimit 
	FROM content, event
	WHERE content.content_id=event.content_id))
	WHERE num BETWEEN #{start} AND #{end}  
   
</select>

<select id="fesTotalPage" resultType="int">
  SELECT CEIL(COUNT(*)/12.0) 
  FROM content,event 
  WHERE content.content_id=event.content_id
  
</select>
		 
	 */
	
	public static List<FesVO> fesListData(Map map)
	{
		List<FesVO> list=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  list=session.selectList("fesListData",map);
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return list;
		
	}
	
	public static int fesTotalPage()
	{
		int total=0;
		SqlSession session=null;
		try
		{
		 session=ssf.openSession();
		 total=session.selectOne("fesTotalPage");
		}
		catch (Exception e) 
		{
		// TODO: handle exception
		 e.printStackTrace();
		}
		finally
		{
		 if(session!=null)
		  session.close();
		}
		  
		return total;
	}
	
	/*
	 <select id="fesDetailData" resultType="FesVO" parameterType="int">
	  SELECT * 
	  FROM content,event,event_detail
	  WHERE content.content_id=event.content_id 
	  	AND content.content_id=event_detail.content_id 
	  	AND content.cat2='A0207'


	 */
	
	public static FesVO fesDetailData(int content_id)
	{
		FesVO vo=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  vo=session.selectOne("fesDetailData",content_id);
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return vo;
	}
	
	/*
	<select id="fesInfoData" resultType="FesVO" parameterType="int">
	  SELECT * 
	  FROM event_detail
	  WHERE content_id=#{content_id}
	</select>
	
	<select id="fesPosterData" resultType="FesVO" parameterType="int">
	  SELECT * 
	  FROM detail_image
	  WHERE content_id=#{content_id}
	</select> 	
	
	*/
	public static List<FesVO> fesInfoData(int content_id)
	{
		List<FesVO> ilist=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  ilist=session.selectList("fesInfoData",content_id);
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return ilist;
	}
	
	public static List<FesVO> fesPosterData(int content_id)
	{
		List<FesVO> plist=null;
		SqlSession session=null;
		try
		{
		  session=ssf.openSession();
		  plist=session.selectList("fesPosterData",content_id);
		  
		}
		catch (Exception e) 
		{
			// TODO: handle exception
		  e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return plist;
	}
	
	public static List<FesVO> fesFindData(Map map)
	{
		  SqlSession session=ssf.openSession();
		  List<FesVO> list = session.selectList("fesFindData", map);
		  session.close();
		  return list;
	 }
	
	public static int fesFindTotalPage(Map map)
	{
		SqlSession session=ssf.openSession();
		int totalpage=session.selectOne("fesFindTotalPage",map);
		session.close();
		return totalpage;
		
	}
	public static void fesCartInsert(FesCartVO vo)
	{
		SqlSession session=null;
		int count=0;
		try {
			session=ssf.openSession(true);
			count=session.selectOne("fesCartCount",vo);
			if(count==0)
		    {
				session.insert("fesCartInsert",vo);
		    }
		    else
		    {
		    	session.update("fesCartUpdate",vo);
		    }
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
	}
	
	public static void fesCartListUpdate(Map map)
	{
		SqlSession session=null;
		try {
			session=ssf.openSession(true);
			session.update("fesCartListUpdate",map);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}	
		
	}
	
	
	
	
	public static List<FesCartVO> fesCartListData(String user_id)
	{
		SqlSession session=null;
		List<FesCartVO> list = null;
		try {
			session=ssf.openSession();
			System.out.println(user_id);
			list = session.selectList("fesCartListData",user_id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		finally
		{
		  if(session!=null)
			  session.close();
		}
		return list;
	}
	
	public static void fesCartCancel(int fno)
	{
		SqlSession session=ssf.openSession(true);
		session.update("fesCartCancel",fno);
		session.close();
	}

	public static void buyInsert(FesCartVO vo)
	{
		   SqlSession session=ssf.openSession(true);
		   session.insert("buyInsert",vo);
		   session.close();
	}
	
	
	
	
	
	
	
	
	
	
	
	public static void reviewInsert(ReviewVO vo)
	{
		  SqlSession session=ssf.openSession(true);
		  session.insert("reviewInsert",vo);
		  session.close();
	}
	public static List<ReviewVO> reviewListData(ReviewVO vo)
	{
		  SqlSession session=ssf.openSession();
		  List<ReviewVO> list=session.selectList("reviewListData",vo);
		  session.close();
		  return list;
	}
	
	 public static int reviewCount(ReviewVO vo)
	  {
		  SqlSession session=ssf.openSession();
		  int count=session.selectOne("reviewCount",vo);
		  session.close();
		  return count;
		  
	  }
	 public static void reviewDelete(int cno)
	  {
		  SqlSession session=ssf.openSession(true);
		  session.delete("reviewDelete",cno);
		  session.close();
	  }
	
	 public static void reviewUpdate(ReviewVO vo)
	  {
		  SqlSession session=ssf.openSession(true);
		  session.update("reviewUpdate",vo);
		  session.close();
	  }
	 
	 public static List<UserCouponsVO> couponList(String user_id)
	 {
		 SqlSession session=ssf.openSession();
		 List<UserCouponsVO> list=session.selectList("couponList",user_id);
		 session.close();
		 return list;
	 }
	

}










