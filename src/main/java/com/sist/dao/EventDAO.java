package com.sist.dao;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.EventVO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
					case 1:vo.setDbarea("서울");break; //146
					case 2:vo.setDbarea("인천");break; //22
					case 3:vo.setDbarea("대전");break; //6
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
	public static List<EventVO> eventAreaList(HashMap map){
		SqlSession session = ssf.openSession();
		List<EventVO> list= session.selectList("eventAreaList", map);
		session.close();
		return list;
	}

	public static List<EventVO> eventSearchList(HashMap map){
		SqlSession session = ssf.openSession();
		List<EventVO> list= session.selectList("eventSearchList", map);
		
		for(EventVO vo:list){
			String cat3=vo.getCvo().getCat3().substring(5,7);
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
		session.close();
		return list;
	}
	public static EventVO eventSearchDefault(HashMap map){
		SqlSession session = ssf.openSession();
		EventVO vo= session.selectOne("eventSearchPrice", map);
		session.close();
		return vo;
	}

	/*
	public static void test(){
		SqlSession session = ssf.openSession();
		List<EventVO> list= session.selectList("replace_data");
		for(EventVO vo:list){
			System.out.println("id:"+vo.getContent_id());
			// 정규표현식 패턴: 숫자가 아닌 문자 뒤에 오면서 '원' 앞에 있는 숫자 및 쉼표 추출
			String ch= vo.getCharge();
			Pattern pattern = Pattern.compile("(?<=^|[^\\d])([\\d,]+)(?=원)");
			Matcher matcher = pattern.matcher(ch);

			List<String> extractedNumbers = new ArrayList<>();
			if(!ch.matches(".*\\d.*") && ch.matches(".*무료.*") && ch.matches(".*유료.*") || ch.matches(".*무료.*\\d.*") && !ch.matches(".*\\d.*무료.*")){
				vo.setPrice(0);
				vo.setPrice_info("해당 행사는 현장 추가 결제가 필요할 수 있습니다.");
				
				HashMap map=new HashMap();
				map.put("price", 0);
				map.put("info", "해당 행사는 현장 추가 결제가 필요할 수 있습니다.");
				map.put("id", vo.getContent_id());
				session.update("replace_execute",map);
			}else if(!ch.matches(".*\\d.*") && ch.matches(".*유료.*") && !ch.matches(".*무료.*")){
				vo.setPrice(0);
				vo.setPrice_info("해당 행사는 현장 결제 행사입니다.");

				HashMap map=new HashMap();
				map.put("price", 0);
				map.put("info", "해당 행사는 현장 결제 행사입니다.");
				map.put("id", vo.getContent_id());
				session.update("replace_execute",map);
			}else if(!ch.matches(".*\\d.*") && ch.matches(".*무료.*")){
				vo.setPrice(0);

				HashMap map=new HashMap();
				map.put("price", 0);
				map.put("id", vo.getContent_id());
				session.update("replace_execute",map);
			}else{
				while (matcher.find()) {
					String number = matcher.group().replace(",", ""); // 쉼표 제거
					vo.setPrice(Integer.parseInt(number));

					HashMap map=new HashMap();
					map.put("price", Integer.parseInt(number));
					map.put("id", vo.getContent_id());
					session.update("replace_execute",map);
					break;
				}
			}
			if(!Objects.nonNull(vo.getPrice())){
				vo.setPrice(0);

				HashMap map=new HashMap();
				map.put("price", 0);
				map.put("id", vo.getContent_id());
				session.update("replace_execute",map);
			}
			session.commit();


			// 결과 출력
			//System.out.println(vo.getCharge()+"\n추출: " + extractedNumbers);
			System.out.println("price:"+vo.getPrice());
			System.out.println("info:"+vo.getPrice_info());
		}
	}
	*/

}

