package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;
public class FoodDAO {
	private static SqlSessionFactory ssf;
	static
	{
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 * <select id="foodDetailData" resultType="FoodVO" parameterType="int">
    SELECT * FROM food
    WHERE fno=#{fno}
	 */
	public static FoodVO foodDetailData(int fno)
	{
		SqlSession session=ssf.openSession();
		FoodVO vo=session.selectOne("foodDetailData",fno);
		session.close();
		return vo;
	}
	/*
	 * <select id="foodFindData" resultType="FoodVO" parameterType="hashmap">
   SELECT fno,name,poster,score,type,address,price,likecount,replycount,num
   FROM (SELECT fno,name,poster,score,type,address,price,likecount,replycount,rownum as num 
   FROM (SELECT  INDEX_ASC(food food_fno_pk)fno,name,poster,score,type,address,price,likecount,replycount
   FROM food WHERE address LIKE '%'||#{ss}||'%'))
   WHERE num BETWEEN #{start} AND #{end}
  </select>
  <select id="foodFindTotalPage" resultType="int" parameterType="hashmap">
    SELECT CEIL(COUNT(*)/12.0) 
    FROM food
    WHERE address LIKE '%'||#{ss}||'%'
	 */
	public static List<FoodVO> foodFindData(Map map)
	{
		SqlSession session=ssf.openSession();
		List<FoodVO> list=session.selectList("foodFindData",map);
		return list;
	}
	public static int foodFindTotalPage(Map map)
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("foodFindTotalPage",map);
		session.close();
		return total;
	}
	public static int foodFindTotalCount(Map map)
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("foodFindTotalCount",map);
		session.close();
		return total;
	}

}
