<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <a href="../notice/notice_admin_list.do" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                공지사항관리
              </p>
            </a>
          </li>
          
          <li class="nav-item">
            <a href="../qna/qna_admin_list.do" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                QnA(1:1문의) 관리 
                <!-- <i class="fas fa-angle-left right"></i> -->
              </p>
            </a>
          </li>

          <li class="nav-item">
            <a href="../food/admin_food_list.do" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                맛집 게시물 관리
                <!-- <i class="fas fa-angle-left right"></i> -->
              </p>
            </a>
          </li>

          <li class="nav-item">
            <a href="../reservation/reservation_admin.do" class="nav-link">
              <i class="nav-icon fas fa-table"></i>
              <p>
                예약 관리
              </p>
            </a>
          </li>

        </ul>
</body>
</html>