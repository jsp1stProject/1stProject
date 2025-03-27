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
	
	// 상세보기
	/*
	 * <select id="foodDetailData" resultType="FoodVO" parameterType="int">
    SELECT * FROM food
    WHERE fno=#{fno}
	 */
	public static FoodVO foodDetailData(int fno)
	{
		SqlSession session=ssf.openSession(true);
		session.update("foodHitIncrement",fno);
		FoodVO vo=session.selectOne("foodDetailData",fno);
		session.close();
		return vo;
	}
	public static FoodVO foodCookieData(int fno)
	  {
		  SqlSession session=ssf.openSession();
		  FoodVO vo=session.selectOne("foodDetailData",fno);
		  session.close();
		  return vo;
	  }
	// 검색
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
		session.close();
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
	// 홈화면
	public static List<FoodVO> foodMainHouseData5()
	  {
		  SqlSession session=ssf.openSession();
		  List<FoodVO> list=session.selectList("foodMainHouseData5");
		  session.close();
		  return list;
	  }
	/*
	 *  <select id="adminFoodListData" resultType="FoodVO">
    SELECT * FROM food
    ORDER BY fno ASC
  </select>
	 */
	// 관리자페이지
	public static List<FoodVO> adminFoodListData(Map map)
	{
		SqlSession session=ssf.openSession();
		  List<FoodVO> list=session.selectList("adminFoodListData",map);
		  session.close();
		  return list;
	}
	/*
	 * <select id="adminFoodTotalPage">
    SELECT CEIL(COUNT(*) / 12.0)
    FROM food
	 */
	public static int adminFoodTotalPage(Map map)
	{
		SqlSession session=ssf.openSession();
		int total=session.selectOne("adminFoodTotalPage");
		session.close();
		return total;
	}
	
	/*
	 * <select id="adminFoodDetailData" resultType="FoodVO" parameterType="int">
   SELECT fno,name,poster,type,content,theme,phone,address
   FROM food
   WHERE fno=#{fno}
 </select>
	 */
	public static FoodVO adminFoodDetailData(int fno)
	{
		SqlSession session=ssf.openSession();
		FoodVO vo=session.selectOne("adminFoodDetailData",fno);
		session.close();
		return vo;
	}
	/*
	 * <insert id="adminFoodInsert" parameterType="FoodVO">
   <selectKey keyProperty="no" resultType="int" order="BEFORE">
     SELECT NVL(MAX(fno)+1,1) as fno FROM food
   </selectKey>
   INSERT INTO food(fno,name,type,phone,address,theme,poster,time,content) VALUES(
     #{fno},#{name},#{type},#{phone},#{address},#{theme},#{poster},#{time},#{content}
   )
 </insert>
	 */
	public static void adminFoodInsert(FoodVO vo)
	  {
		  SqlSession session=ssf.openSession(true);
		  session.insert("adminFoodInsert",vo);
		  session.close();
	  }
	/*
	 * <update id="adminFoodUpdate" parameterType="FoodVO">
   UPDATE food SET
   name=#{name},poster=#{poster},type=#{type},content=#{content},theme=#{theme},phone=#{phone},address=#{address}
   WHERE fno=#{fno}
 </update>
	 */
	public static FoodVO adminFoodUpdateData(int fno)
	  {
		  SqlSession session=ssf.openSession();
		  FoodVO vo=session.selectOne("adminFoodDetailData",fno);
		  session.close();
		  return vo;
	  }
	 public static void adminFoodUpdate(FoodVO vo)
	  {
		  SqlSession session=ssf.openSession(true);
		  session.update("adminFoodUpdate",vo);
		  session.close();
	  }
	 
	 public static void adminFoodDelete(int fno)
	  {
		  SqlSession session=ssf.openSession(true);
		  session.delete("adminFoodDelete",fno);
		  session.close();
	  }
	

}
