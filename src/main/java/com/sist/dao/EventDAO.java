package com.sist.dao;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.EventVO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.List;

public class EventDAO {
	private static SqlSessionFactory ssf;
	
	static {
		ssf = CreateSqlSessionFactory.getSsf();
	}
	
	public static List<EventVO> mainEventList() {
		SqlSession session = null;
		List<EventVO> list = null;
		try{
			session = ssf.openSession();
			list = session.selectList("mainEventList");
			for(EventVO vo:list){
				String cat3=vo.getCvo().getCat3().substring(5,7);
				System.out.println(cat3);
				switch (cat3){
					case "01":vo.setDbcate("전통공연");break;
					case "02":vo.setDbcate("연극");break;
					case "03":vo.setDbcate("뮤지컬");break;
					case "04":vo.setDbcate("오페라");break;
					case "05":vo.setDbcate("전시회");break;
					case "06":vo.setDbcate("박람회");break;
					case "08":vo.setDbcate("무용");break;
					case "09":vo.setDbcate("클래식");break;
					case "10":vo.setDbcate("콘서트");break;
					case "11":vo.setDbcate("영화");break;
					case "12":vo.setDbcate("스포츠");break;
					case "13":vo.setDbcate("기타행사");break;
				}
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			if(session != null){
				session.close();
			}
		}
		return list;
	}

	public static List<EventVO> mainFesList() {
		SqlSession session = null;
		List<EventVO> list = new ArrayList<EventVO>();
		try{
			session = ssf.openSession();
			list= session.selectList("mainFesList");
			for(EventVO vo:list){
				int areaCode = vo.getCvo().getAreacode();
				System.out.println(areaCode);
				switch (areaCode){
					case 1:vo.setDbarea("서울");break;
					case 2:vo.setDbarea("인천");break;
					case 3:vo.setDbarea("대전");break;
					case 4:vo.setDbarea("대구");break;
					case 5:vo.setDbarea("광주");break;
					case 6:vo.setDbarea("부산");break;
					case 7:vo.setDbarea("울산");break;
					case 8:vo.setDbarea("세종");break;
					case 31:vo.setDbarea("경기");break;
					case 32:vo.setDbarea("강원");break;
					case 33:vo.setDbarea("충북");break;
					case 34:vo.setDbarea("충남");break;
					case 35:vo.setDbarea("경북");break;
					case 36:vo.setDbarea("경남");break;
					case 37:vo.setDbarea("전북");break;
					case 38:vo.setDbarea("전남");break;
					case 39:vo.setDbarea("제주");break;
				}
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			if(session != null){
				session.close();
			}
		}
		return list;
	}

}
