package com.sist.dao;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import java.util.*;
import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.*;
public class UserFindDAO {
	private static SqlSessionFactory ssf;
	   static
	   {
		   ssf=CreateSqlSessionFactory.getSsf();
	   }
	   
	   public static String userIdFindData_Email(UserVO vo)
	   {
		   String result="";
		   SqlSession session=ssf.openSession();
		   int count=session.selectOne("userIdFindCount_Email",vo);
		   if(count==0)
		   {
			  result="no";
		   }
		   else
		   {
			  result=session.selectOne("userIdFindData_Email",vo);
		   }
		   
		   session.close();
		   return result; 
	   }
	   public static String userIdFindData_Phone(UserVO vo)
	   {
		   String result="";
		   SqlSession session=ssf.openSession();
		   int count=session.selectOne("userIdFindCount_Phone",vo);
		   if(count==0)
		   {
			  result="no";
		   }
		   else
		   {
			  result=session.selectOne("userIdFindData_Phone",vo);
		   }
		   
		   session.close();
		   return result; 
	   }
}
