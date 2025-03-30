package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;
public class SightsDAO {
	private static SqlSessionFactory ssf;
	  static
	  {
		  ssf=CreateSqlSessionFactory.getSsf();
	  }
	


	  public static SightsVO sightsMainData()
	  {
		  SqlSession session=ssf.openSession();
		  SightsVO vo=session.selectOne("sightsMainData");
		  session.close();
		  return vo;
	  }
	  
	  public static List<SightsVO> sightsMainData8()
	  {
		  SqlSession session=ssf.openSession();
		  List<SightsVO> list=session.selectList("sightsMainData8");
		  session.close();
		  return list;
	  }
	  
	  public static List<SightsVO> sightsListData(Map map){
			SqlSession session=ssf.openSession();
			List<SightsVO> list=session.selectList("sightsListData",map);
			session.close();
			return list;
		}
		public static int sightsTotalPage() {
			SqlSession session=ssf.openSession();
			int total=session.selectOne("sightsTotalPage");
			session.close();
			return total;
		}
		public static SightsVO sightsDetailData(int content_id) {
			SightsVO vo=null;
			SqlSession session=null;
			try
			{
			  session=ssf.openSession();
			  vo=session.selectOne("sightsDetailData",content_id);
			}
			catch (Exception ex) 
			{
			  ex.printStackTrace();
			}
			finally
			{
			  if(session!=null)
				  session.close();
			}
			return vo;
			/*SqlSession session=ssf.openSession(true);
			SightsVO vo=session.selectOne("sightsDetailData",content_id);
			session.close();
			return vo;*/
		}
		public static void sightsReviewInsert(ReviewVO vo) {
			SqlSession session=ssf.openSession();
			session.insert("sightsReviewInsert", vo);
			session.commit();
			session.close();
		}
		public static List<ReviewVO> sightsReviewList(int content_id) {
			try(SqlSession session = ssf.openSession(true)) {
				List<ReviewVO> list = session.selectList("sightsReviewList", content_id);
				return list;
			}
		}
}
