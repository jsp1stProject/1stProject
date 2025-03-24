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
}
