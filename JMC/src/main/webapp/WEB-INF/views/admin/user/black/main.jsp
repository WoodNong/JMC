<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
table {
    margin-left:auto; 
    margin-right:auto;
}

table, td, th {
    border-collapse : collapse;
    border : 1px solid black;
    text-align: center; 
}
</style>
<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>


<script type="text/javascript">
$(function() {
	$("#searchBtn").click(function() {
		
			 $.ajax({
			type: "post"
			, url: "./filter"
			, data:  {filter : $("#filter").val(), content : $("#content").val(), curPage: ${paging.curPage}}
			, dataType: "html" 
			, success: function( res ) {
				console.log("AJAX 성공")
				$("#result").html(res)
			}
			, error: function() {
				console.log("AJAX 실패")
			}
		}) 
	})
})
</script>


</head>
<body>
<h1>블랙리스트 관리 페이지</h1>

<select name ="filter" id="filter">
   <option value = "user_id" selected>아이디</option>
   <option value = "user_name">이름</option>
   <option value = "grade">등급</option>
</select>

검색 : <input type="text" name="content" id="content">
<button id="searchBtn">검색하기</button>
<div id="result">
<table>
<tr>
	<th>회원번호</th>
	<th>아이디</th>
	<th>이름</th>
	<th>등급</th>
	<th>상태</th>
	<th>신고 누적수</th>
	<th>가입일</th>
	<th>관리</th>
</tr>
<c:forEach var="users" items="${users }">
<tr>
	<th>${users.userno }</th>
	<th>${users.userId }</th>
	<th>${users.userName }</th>
	<th><c:choose>
		<c:when test="${users.status eq 'blacklist'}">블랙리스트</c:when>
		<c:when test="${users.status eq	'block'}">정지</c:when>
		<c:when test="${users.status eq 'active'}">활동중</c:when>
		<c:when test="${users.status eq 'unactive'}">휴먼</c:when>
		<c:when test="${users.status eq 'leave'}">탈퇴</c:when>
	</c:choose> </th>
	<th><c:choose>
		<c:when test="${users.grade eq '1'}">차가움</c:when>
		<c:when test="${users.grade eq	'2'}">보통</c:when>
		<c:when test="${users.grade eq '3'}">따듯함</c:when>
	</c:choose>  </th>
	<th>${users.warnCount }</th>
	<th>${users.joinDate }</th>
	<th><a href="./update?userno=${users.userno }&curPage=${paging.curPage}"><button>블랙리스트</button></a>
	<a href="./stop?userno=${users.userno }&curPage=${paging.curPage}"><button>회원정지</button></a></th>
</tr>
</c:forEach>
</table>
<br><br><br>
<c:import url="./paging.jsp" />
</div>
<br><br><br>
<a href="<%=request.getContextPath() %>/admin/report/post/list"><button>신고 게시글 페이지</button></a>
<a href="<%=request.getContextPath() %>/admin/report/user/list"><button>신고 계정 페이지</button></a>
<a href="<%=request.getContextPath() %>/admin/user/black/list"><button>블랙리스트 페이지</button></a>
<a href="<%=request.getContextPath() %>/admin/user/mg/list"><button>유저수정 페이지</button></a>