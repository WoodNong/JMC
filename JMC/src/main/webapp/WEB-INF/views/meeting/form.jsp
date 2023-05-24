<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<c:import url="../layout/header.jsp" />


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>


 <style type="text/css">

 
	
 .div1 {
	background-color: #E2E2E2;
	height: 600px;
	width: 600px;
	margin: 0 auto;
	}
 


 
 
 </style>


	
	<h1>모임 등록</h1>
	
	
	<div class="div1"> 
	
	<h4>모임의 정보를 등록해 주세요</h4>
	
	
	<form action="/meeting/form" method="post">
	
	<label>모임 명<input type="text" id="mname" name="mname" placeholder="모임 이름"></label><br>
	<label>모임 지역
	<input type="text" id="sample6_postcode" name="loc"  placeholder="우편번호">
	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
	<input type="text" id="sample6_address" name="loc1" placeholder="주소"><br>
	<input type="text" id="sample6_extraAddress" name="loc2" placeholder="참고항목">
	<input type="text" id="sample6_detailAddress" name="loc3" placeholder="상세주소"></label><br><br>
	<label>모임 날짜<input type="datetime-local" id="meetingDate" name="meetingDate"></label><br><br>
	<label>참가비<input type="text" id="fee" name="fee" placeholder="원"></label><br><br>
	<label>인원 수<input type="number" id="headCount" name="headCount" min="2"  max="10"></label><br><br>
	<label>모임 소개<input type="text" id="introduce" name="introduce" placeholder="모임 소개 및 주의 사항"></label><br><br>
	
	
	<label>친구 목록</label>
	<select>
	<c:forEach var = "friendlist" items="${friendList }">
	<option value="${ friend_userno}">${friendlist.userName }</option>
	
	</c:forEach>
	</select>
	
	
	<button>등록</button>
	<button>취소</button>    
	
	<h4>선호하는 친구 타입(선택)</h4>
	
		
	
	
	</form>		
	
	</div>

<c:import url="../layout/footer.jsp" />
