package com.sist.dao;
import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sist.vo.*;
import com.sist.commons.*;
public class MemberDAO {
	private static SqlSessionFactory ssf;
	static {
		ssf=CreateSqlSessionFactory.getSsf();
	}
	/*
	 *  <select id="memberIdcheck" resultType="int" parameterType="">
    SELECT COUNT(*) FROM project_member
    WHERE id=#{id}
  </select>
	 */
	public static int memberIdcheck(String user_id) {
		SqlSession session=ssf.openSession();
		int count=session.selectOne("memberIdcheck", user_id);
		session.close();
		return count;
	}
	/*
	 *  	<insert id="memberInsert" parameterType="MemberVO">
    INSERT INTO project_member VALUES(
      #{id},#{pwd},#{name},#{sex},#{birthday},#{email},#{post},#{addr1},#{addr2},#{phone},#{content},'n'
    )
  </insert>
	 */
	public static void memberInsert(MemberVO vo) {
		SqlSession session=ssf.openSession(true);
		session.insert("memberInsert",vo);
		session.close();
	}
	// 123
	
	/*
	 * 		<select id="memberIdCheckCount" resultType="int" parameterType="string">
    SELECT COUNT(*) FROM project_member
    WHERE id=#{id}
  </select>
  
  <select id="memberGetPassword" resultType="MemberVO" parameterType="string">
    SELECT id,pwd,name,sex,admin
    FROM project_member
    WHERE id=#{id}
  </select>
	 *  	
	 */
	public static MemberVO memberLogin(String user_id,String pwd) {
		MemberVO vo=new MemberVO();
		SqlSession session=ssf.openSession();
		try {
			
		
		int count=session.selectOne("memberIdCheckCount",user_id);
		if(count==0) {
			vo.setMsg("NOID");
		}
		else {
			vo=session.selectOne("memberGetPassword", user_id);
			if(pwd.equals(vo.getPwd())) {
				vo.setMsg("OK");
			}
			
			else {
				vo.setMsg("NOPWD");
			}
		}
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		session.close();
		return vo;
	}
	/** 예약 결제 시 조회하는 user info */
	public static MemberVO memberInfoData(String user_id) {
		SqlSession session = ssf.openSession();
		MemberVO vo = session.selectOne("memberInfoData", user_id);
		session.close();
		return vo;
	}
}
