<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="../layout/header.jsp" />
<style type="text/css">
div.body{
	
}
div.left {
	width: 880px;
	height :800px;
	box-sizing: border-box;
	display: inline-block;

}



div.right {
	width: 880px;
	height :800px;
	box-sizing: border-box;
	display: inline-block;
	position: absolute;
}

div.storetext{
	text-align: center;
	font-size: 50px;
	position: relative;
    top: 80px;
}

#goods{
    position: relative;
    top: 30px;
    left: 210px;
    cursor: pointer;
}
#material{
    position: relative;
    top: 30px;
    left: 210px;
    cursor: pointer;
 
}
#materialspan{
   cursor: pointer;
}
#goodsspan{
  cursor: pointer;
}
</style>
<body>
<h1>판매 사이트 메인</h1>
<hr>
<div class="body">
		<div class="left">
			<div class="minileft">
				<a href="/store/goodsAll"><img id="goods" src="/resources/image/goods2.jpg" width="500"
					height="500px"></a>
				<div class="storetext">
				<span id="goodsspan"><a href="/store/goodsAll">칵테일 용품</a></span>
				</div>
			</div>
		</div>

		<div class="right">
    <img id="material" src="/resources/image/material2.jpg" width="500" height="500px" >
        <div class="storetext">
        <span id="materialspan">칵테일 재료</span>
        </div>
   </div>
</div>


<c:import url="../layout/footer.jsp" />