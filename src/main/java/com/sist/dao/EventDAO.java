package com.sist.dao;

import com.sist.commons.CreateSqlSessionFactory;
import com.sist.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;


public class EventDAO {
	private static SqlSessionFactory ssf;
	public static LinkedHashMap catemap = new LinkedHashMap();

	static {
		ssf = CreateSqlSessionFactory.getSsf();
		catemap.put("A02080100", "전통공연");
		catemap.put("A02080200", "연극");
		catemap.put("A02080300", "뮤지컬");
		catemap.put("A02080400", "오페라");
		catemap.put("A02080500", "전시회");
		catemap.put("A02080600", "박람회");
		catemap.put("A02080800", "무용");
		catemap.put("A02080900", "클래식");
		catemap.put("A02081000", "콘서트");
		catemap.put("A02081100", "영화");
		catemap.put("A02081200", "스포츠");
		catemap.put("A02081300", "기타행사");
	}
	public static void categorySet(EventVO vo) {
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
	public static void categorySet(List<EventVO> list){
		for(EventVO vo:list){
			categorySet(vo);
		}
	}
	public static void areaSet(List<EventVO> list){
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
	}
	public static JSONObject jsonParse(HttpServletRequest request, HttpServletResponse response) {
		BufferedReader reader= null;
		StringBuilder sb=new StringBuilder();
		JSONParser jsonparse=new JSONParser();
		JSONObject json;
		try {
			reader = request.getReader();
			String line;
			while((line=reader.readLine())!=null) {
				sb.append(line);
			}
			json=(JSONObject)jsonparse.parse(sb.toString());
		} catch (IOException | ParseException e) {
			throw new RuntimeException(e);
		}
		return json;
	}

	//sql start
	public static List<EventVO> mainEventList() {
		SqlSession session = null;
		List<EventVO> list = null;
		try{
			session = ssf.openSession();
			list = session.selectList("mainEventList");
			categorySet(list);
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
			areaSet(list);
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			if(session != null){
				session.close();
			}
		}
		return list;
	}

	public static List<HotelVO> mainHotelList(int areacode) {
		SqlSession session = ssf.openSession();
		List<HotelVO> list = session.selectList("mainHotelList", areacode);
		session.close();
		return list;

	}

	public static List<EventVO> eventAreaList(HashMap map){
		SqlSession session = ssf.openSession();
		List<EventVO> list= session.selectList("eventAreaList", map);
		categorySet(list);
		session.close();
		return list;
	}

	public static List<EventVO> eventSearchList(HashMap map){
		SqlSession session = ssf.openSession();
		List<EventVO> list= session.selectList("eventSearchList", map);
		categorySet(list);
		session.close();
		return list;
	}
	public static EventVO eventSearchDefault(HashMap map){
		SqlSession session = ssf.openSession();
		EventVO vo= session.selectOne("eventSearchPrice", map);
		session.close();
		return vo;
	}
	public static EventVO eventDetailData(int contid){
		SqlSession session = ssf.openSession();
		EventVO vo= session.selectOne("eventDetailData", contid);
		categorySet(vo);
		session.close();
		return vo;
	}
	public static List<EventVO> eventDetailInfo(int contid){
		SqlSession session = ssf.openSession();
		List<EventVO> list= session.selectList("eventDetailInfo", contid);
		session.close();
		return list;
	}
	public static List<EventVO> eventDetailImg(int contid){
		SqlSession session = ssf.openSession();
		List<EventVO> list= session.selectList("eventDetailImg", contid);
		session.close();
		return list;
	}
	public static List<ContentVO> eventDetailHotel(int areacode){
		SqlSession session = ssf.openSession();
		List<ContentVO> list= session.selectList("eventDetailHotel", areacode);
		session.close();
		return list;
	}

//	mypage
	public static MemberVO memberDetail(String id){
		SqlSession session = ssf.openSession();
		MemberVO vo= session.selectOne("memberDetail", id);
		session.close();
		return vo;
	}

	public static boolean memberUpdate(HashMap map, String pwd_before){
		SqlSession session = ssf.openSession(true);
		boolean result=false;
		String pwd=session.selectOne("memberPwdCheck", map.get("user_id"));
		if(pwd.equals(pwd_before)){
			session.update("memberUpdate", map);
			session.commit();
			result=true;
		}
		session.close();
		return result;
	}

	public static boolean memberPwdCheck(HashMap map){
		SqlSession session = ssf.openSession();
		boolean result=false;
		String pwd=session.selectOne("memberPwdCheck", map.get("user_id"));
		if(pwd.equals(map.get("pwd"))){
			result=true;
		}
		session.close();
		return result;
	}
	public static void memberDelete(String user_id){
		SqlSession session = ssf.openSession(true);
		session.delete("memberDelete", user_id);
		session.close();
	}

//	장바구니 cart
	public static List<CartVO> cartList(HashMap map){
		SqlSession session = ssf.openSession();
		List<CartVO> list= session.selectList("cartList", map);
		session.close();
		return list;
	}
	public static void cartInsert(HashMap map){
		SqlSession session = ssf.openSession(true);
		session.insert("cartInsert", map);
		session.close();
	}
	public static void cartUpdate(HashMap map){
		SqlSession session = ssf.openSession(true);
		session.update("cartUpdate", map);
		session.close();
	}
	public static boolean cartDelete(String cno){
		boolean result=true;
		SqlSession session = ssf.openSession(true);
		session.delete("cartDelete", cno);
		session.close();
		return result;
	}
	public static boolean cartDeleteAll(String user_id){
		SqlSession session = ssf.openSession(true);
		session.delete("cartDeleteAll", user_id);
		session.close();
		return true;
	}
	public static int eventCartCount(String user_id){
		SqlSession session = ssf.openSession();
		int count=session.selectOne("eventCartCount", user_id);
		session.close();
		return count;
	}
	//주문 생성
	public static void eventOrderInsert(HashMap map){
		SqlSession session = ssf.openSession(true);
		session.insert("eventOrderInsert", map);
		session.close();
	}
	//주문 리스트
	public static List<EventOrderVO> eventOrderList(String user_id){
		SqlSession session = ssf.openSession();
		List<EventOrderVO> list=session.selectList("eventOrderList", user_id);
		session.close();
		return list;
	}
	public static EventOrderVO eventOrderDetail(HashMap map){
		SqlSession session = ssf.openSession();
		EventOrderVO vo=session.selectOne("eventOrderDetail", map);
		session.close();
		return vo;
	}
	public static List<ReviewVO> eventReviewList(String content_id){
		SqlSession session = ssf.openSession();
		List<ReviewVO> list=session.selectList("eventReviewList", content_id);
		session.close();
		return list;
	}
	/*
	가격 정규화
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

