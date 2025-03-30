<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../food/map.css">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=56b06fde10080b6a8a785311ba6b68d3&libraries=services"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script type="text/javascript">
let bClick=false
$(function(){
	$('.updates').click(function(){
		let rno=$(this).attr("data-rno")
		$('.ups').hide()
		$(".updates").text("수정")
		if(bClick===false)
		{
			$(this).text("취소")
			$('#up'+rno).show()
			bClick=true
		}
		else
		{
			$(this).text("수정")
			$('#up'+rno).hide()
			bClick=false
		}
	})
})
<%-- 필터창 스크롤 라이브러리 --%>
$(function(){
	$('#filter').slimScroll({
		height: 'auto',
		railVisible: false,
		railColor: '#222',
		railOpacity: 0.3,
		wheelStep: 10,
		allowPageScroll: false,
		disableFadeOut: false
	})
});
</script>
<style type="text/css">
img{
	weight:200px;
	height:200px;
}
  .carousel-inner {
    height: 700px; /* 🔹 캐러셀 높이를 크게 설정 */
    min-height: 700px; /* 🔹 최소 높이 보장 */
  }

  .carousel-inner img {
    width: 80%; /* 🔹 가로 크기를 100%로 */
    height: 60%; /* 🔹 세로 크기를 부모에 맞춤 */
    object-fit: cover; /* 🔹 꽉 차게 설정 (잘릴 수도 있음) */
  }
</style>
</head>
<body>         

			<div class="container">
            <div class="row">
                <div class="col-sm-2 py-3 px-0" style="position:relative">
				<div class="filter-container">
					
					<div class="filter-inner">
						<div class="filter-wrap" id="filter">
							<div class="filter-item col-lg-12 col-md-4 col-sm-12"> <!-- range 타입 -->
					
				</div>
			</div>
			</div>
			
				</div>
				</div>
			
		
				

<div class="col-lg-10 px-0">
				<div class="container-xxl py-3 px-0">
					<div class="container">
							<div class="sch_wrap page">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><i class="fa fa-home" aria-hidden="true"></i> 맛집</li>
                            <li class="breadcrumb-item"><a href="#">${vo.type }</a></li>
                            <li class="breadcrumb-item active" aria-current="page">${vo.name }</li>
                        </ol>
                    </nav>
                </div>
            </div>
			<h2 id="topTitle" class="text-center">${vo.name }</h2>
			<div class="address text-center" id="topAddr">
				<span>${vo.address }</span>
			</div>
		</div>
		<div id="galleryGo">
			<div class="photo_gallery">
				<div class="container">

           
                              
                              <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
  <div class="carousel-inner">
    <c:forTokens items="${vo.images}" delims="," var="img" varStatus="status">
      <div class="carousel-item ${status.first ? 'active' : ''}">
        <img src="http://www.menupan.com${img}" class="d-block w-100" alt="맛집 이미지">
      </div>
    </c:forTokens>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>
                            </div>
</div>



		<div id="detail_info">
			<div class="wrap_conview">
				<h3>상세정보</h3>
				 <table class="table">
       <tr>
         <th width=10%>음식종류</th>
         <td width=40%>${vo.type }</td>
         <th width=10%>주소</th>
         <td width=40%>${vo.address }</td>
       </tr>
       <tr>
         <th width=10%>주소</th>
         <td width=40%>${vo.address }</td>
         <th width=10%>전화</th>
         <td width=40%>${vo.phone }</td>
       </tr>
       <tr>
         <th width=10%>가격대</th>
         <td width=40%>${vo.price }</td>
         <th width=10%>주차</th>
         <td width=40%>${vo.parking }</td>
       </tr>
       <tr>
         <th width=10%>영업시간</th>
         <td width=40%>${vo.time }</td>
         <th width=10%>테마</th>
         <td width=40%>${vo.theme }</td>
       </tr>
      </table>
      
      <h3>맛집 소개</h3>
       <table class="table">
       
        <tr>
         <td>${vo.content }</td>
        </tr>
        <tr>
         <td class="text-end">
         <a href="#" 
             class="btn btn-sm btn-success">좋아요</a>
             <a href="../jjim/jjim_insert.do?fno=${vo.fno }&type=1" 
	             class="btn btn-sm btn-info">찜하기</a>
	             <a href="#" 
             class="btn btn-sm btn-danger">예약하기</a>
          <!--<c:if test="${sessionScope.id!=null }">-->
          
	        <!--<c:if test="${rcount==0 }">-->
	          
	       <!--   </c:if> -->
	        <!--<c:if test="${rcount!=0 }">
	          <span 
	             class="btn btn-sm btn-default">찜하기</span>
	        </c:if>-->
          
         <!--  </c:if>-->
          <a href="javascript:history.back()" 
             class="btn btn-sm btn-primary">목록</a>
         </td>
        </tr>
      </table>  
      </div>
      </div>
     
      <%-- 지도 위치 --%>
      <div class="map_wrap">
			    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div>
			                <form onsubmit="searchPlaces(); return false;">
			                    키워드 : <input type="text" value="${addr } 맛집" id="keyword" size="15" readonly> 
			                 
			                </form>
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
			</div>
			
			
			<script>
			// 마커를 담을 배열입니다
			var markers = [];
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			        level: 3 // 지도의 확대 레벨
			    };  
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();  
			
			// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			
			// 키워드로 장소를 검색합니다
			searchPlaces();
			
			// 키워드 검색을 요청하는 함수입니다
			function searchPlaces() {
			
			    var keyword = document.getElementById('keyword').value;
			
			    if (!keyword.replace(/^\s+|\s+$/g, '')) {
			        alert('키워드를 입력해주세요!');
			        return false;
			    }
			
			    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			    ps.keywordSearch( keyword, placesSearchCB); 
			}
			
			// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
			    if (status === kakao.maps.services.Status.OK) {
			
			        // 정상적으로 검색이 완료됐으면
			        // 검색 목록과 마커를 표출합니다
			        displayPlaces(data);
			
			        // 페이지 번호를 표출합니다
			        displayPagination(pagination);
			
			    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
			
			        alert('검색 결과가 존재하지 않습니다.');
			        return;
			
			    } else if (status === kakao.maps.services.Status.ERROR) {
			
			        alert('검색 결과 중 오류가 발생했습니다.');
			        return;
			
			    }
			}
			
			// 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) {
			
			    var listEl = document.getElementById('placesList'), 
			    menuEl = document.getElementById('menu_wrap'),
			    fragment = document.createDocumentFragment(), 
			    bounds = new kakao.maps.LatLngBounds(), 
			    listStr = '';
			    
			    // 검색 결과 목록에 추가된 항목들을 제거합니다
			    removeAllChildNods(listEl);
			
			    // 지도에 표시되고 있는 마커를 제거합니다
			    removeMarker();
			    
			    for ( var i=0; i<places.length; i++ ) {
			
			        // 마커를 생성하고 지도에 표시합니다
			        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
			            marker = addMarker(placePosition, i), 
			            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
			
			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			        // LatLngBounds 객체에 좌표를 추가합니다
			        bounds.extend(placePosition);
			
			        // 마커와 검색결과 항목에 mouseover 했을때
			        // 해당 장소에 인포윈도우에 장소명을 표시합니다
			        // mouseout 했을 때는 인포윈도우를 닫습니다
			        (function(marker, title) {
			            kakao.maps.event.addListener(marker, 'mouseover', function() {
			                displayInfowindow(marker, title);
			            });
			
			            kakao.maps.event.addListener(marker, 'mouseout', function() {
			                infowindow.close();
			            });
			
			            itemEl.onmouseover =  function () {
			                displayInfowindow(marker, title);
			            };
			
			            itemEl.onmouseout =  function () {
			                infowindow.close();
			            };
			        })(marker, places[i].place_name);
			
			        fragment.appendChild(itemEl);
			    }
			
			    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			    listEl.appendChild(fragment);
			    menuEl.scrollTop = 0;
			
			    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			    map.setBounds(bounds);
			}
			
			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {
			
			    var el = document.createElement('li'),
			    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
			                '<div class="info">' +
			                '   <h5>' + places.place_name + '</h5>';
			
			    if (places.road_address_name) {
			        itemStr += '    <span>' + places.road_address_name + '</span>' +
			                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
			    } else {
			        itemStr += '    <span>' +  places.address_name  + '</span>'; 
			    }
			                 
			      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
			                '</div>';           
			
			    el.innerHTML = itemStr;
			    el.className = 'item';
			
			    return el;
			}
			
			// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
			function addMarker(position, idx, title) {
			    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
			        imgOptions =  {
			            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
			        },
			        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
			            marker = new kakao.maps.Marker({
			            position: position, // 마커의 위치
			            image: markerImage 
			        });
			
			    marker.setMap(map); // 지도 위에 마커를 표출합니다
			    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
			
			    return marker;
			}
			
			// 지도 위에 표시되고 있는 마커를 모두 제거합니다
			function removeMarker() {
			    for ( var i = 0; i < markers.length; i++ ) {
			        markers[i].setMap(null);
			    }   
			    markers = [];
			}
			
			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
			    var paginationEl = document.getElementById('pagination'),
			        fragment = document.createDocumentFragment(),
			        i; 
			
			    // 기존에 추가된 페이지번호를 삭제합니다
			    while (paginationEl.hasChildNodes()) {
			        paginationEl.removeChild (paginationEl.lastChild);
			    }
			
			    for (i=1; i<=pagination.last; i++) {
			        var el = document.createElement('a');
			        el.href = "#";
			        el.innerHTML = i;
			
			        if (i===pagination.current) {
			            el.className = 'on';
			        } else {
			            el.onclick = (function(i) {
			                return function() {
			                    pagination.gotoPage(i);
			                }
			            })(i);
			        }
			
			        fragment.appendChild(el);
			    }
			    paginationEl.appendChild(fragment);
			}
			
			// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
			// 인포윈도우에 장소명을 표시합니다
			function displayInfowindow(marker, title) {
			    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
			
			    infowindow.setContent(content);
			    infowindow.open(map, marker);
			}
			
			 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
			function removeAllChildNods(el) {   
			    while (el.hasChildNodes()) {
			        el.removeChild (el.lastChild);
			    }
			}
			</script>
			<div class="comment_area section_padding_50 clearfix">
                                <h4 class="mb-30">댓글(${count })</h4>

                                <ol>
                                   <c:forEach var="rvo" items="${rList }">
                                    <li class="single_comment_area">
                                        <div class="comment-wrapper d-flex">
                                            <!-- Comment Meta -->
                                            <div class="comment-author">
                                                <c:if test="${rvo.sex=='남자' }">
                                                 <img src="../img/images/man.png" alt="">
                                                </c:if>
                                                <c:if test="${rvo.sex=='여자' }">
                                                 <img src="../img/images/woman.png" alt="">
                                                </c:if>
                                            </div>
                                            <!-- Comment Content -->
                                            <div class="comment-content">
                                                <span class="comment-date text-muted">${rvo.dbday}</span>
                                                <h5>${rvo.name }</h5>
                                                <p>${rvo.msg }</p>
                                                <c:if test="${sessionScope.id!=null }">
                                                   <a href="#" class="active">좋아요</a>
                                                   <a href="#" class="active">댓글</a>
                                                   <c:if test="${sessionScope.id==rvo.id }">
                                                     <a class="active updates" data-rno="${rvo.cno }">수정</a>
                                                     <a href="../reply/reply_delete.do?cno=${rvo.cno }&rno=${rvo.rno}&type=1" class="active">삭제</a>
                                                   </c:if>
                                                </c:if>
                                                
                                                <div class="comment-form ups" style="display:none" id="up${rvo.cno }">
                                  
				                                    <form action="../reply/reply_update.do" method="post">
				                                        
				                                        <div class="form-group">
				                                            <textarea name="msg" id="msg" cols="50" rows="3" placeholder="Message" style="float: left" required>${rvo.msg }</textarea>
				                                            <input type=hidden name="type" value="1">
				                                            <input type=hidden name="rno" value="${vo.fno }">
				                                            <input type=hidden name="cno" value="${rvo.cno }">
				                                            <button type="submit" class="btn btn-primary" style="width:100px;height: 85px;float: left">댓글수정</button>
				                                        </div>
				                                        
				                                    </form>
				                                </div>
                                            </div>
                                            
                                        </div>
                                    </li>
                                    </c:forEach>
                                </ol>
                            </div>
                            </div>

                            <!-- Leave A Comment -->
                            <c:if test="${sessionScope.id!=null }">
                            <div class="leave-comment-area section_padding_50 clearfix">
                                <div class="comment-form">
                                  
                                    <form action="../reply/reply_insert.do" method="post">
                                        
                                        <div class="form-group">
                                            <textarea name="msg" id="msg" cols="70" rows="4" placeholder="Message" style="float: left" required></textarea>
                                            <input type=hidden name="type" value="1">
                                            <input type=hidden name="rno" value="${vo.fno }">
                                            <button type="submit" class="btn btn-primary" style="width:100px;height: 95px;float: left">댓글쓰기</button>
                                        </div>
                                        
                                    </form>
                                </div>
                                </div>
                            </div>
                            
                            </c:if>   
                            </div>
                            </div>            
</body>
</html>