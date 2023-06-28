<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:import url="../../main.jsp"/>

<!-- include libraries(jQuery, bootstrap) -->
<!-- CSS only -->
<!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet"> -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script type="text/javascript">

$(function() {
	
	
	<%-- 
	
	웹 에디터에 엄청 큰 사진을 올리게 되면 서버(tomcat)이 받아들이지 못해 POST 요청모두를 못받는 
	경우가 생길수 있는데 이 경우엔 서버의 요청에 대한 사이즈를 무제한으로 설정하면 해결할수 있다 
	이 경우는 mutipart가 아니라 data-64로 처리하는 동안 발생하는 문제점이다
	확인해보니 아무런 톰캣 설정을 하지 않으면 POST타입으로 데이터를 전송할때 POST BODY의 사이즈가 2mb로
	제한되어 있다는 부분이 문제점이 되는 것임...!
	
	server 프로젝트에서 server.xml파일에서 
	<Connector connectionTimeout="20000" port="8888" protocol="HTTP/1.1" redirectPort="8443"/>
	에서 
	<Connector connectionTimeout="20000" port="8888" protocol="HTTP/1.1" redirectPort="8443" maxPostSize="5242880"/>
	과 같이 사이즈를 지정해주거나 
	<Connector connectionTimeout="20000" port="8888" protocol="HTTP/1.1" redirectPort="8443" maxPostSize="-1"/>
	으로 지정하면 문제가 해결된다
	 
	 ** -1로 설정하면 최대 설정값인 2GB로 설정이된다
	 
	
	 --%>
	
	//div#content에 에디터 적용하기
	$("#summernote").summernote({
				height: 400,
				width: 800,
				//resize: none;
				disableResizeEditor: true,
				//fileSave
				callbacks: {
					onImageUpload: function(files, editor, welEditable) {
						console.log("사용이 되나요1?");
						for(var i = files.length -1 ; i >= 0; i--){
							sendFile(files[i], this)
						}
					}
				}
			});
	
	function sendFile(file, el) {
		console.log("el {}", el);
		data = new FormData();
		data.append("file", file);	//** 파일전달파라미터의 name
		
		$.ajax({
			data: data
			,type: "POST"
			,url: "./writeFileupload"
			,cache: false
			,contentType: false
			,processData: false
			,success: function(res) {
				var image = $('<img>').prop('src', res.url)
				$(el).summernote('insertNode', image[0])
				console.log($(el))
				console.log(res)
				console.log(res.url)
			}
			,error: function() {
				console.log("error입니다스!")
			}
		})
	}
	
	$("#btnCancel").click(function() {
		
		history.go(-1)
	})
	
// 	$(".img-wrap").click(function() {
// 		$("#file").click()
// 	})
	
// 	$("#file").change(function() {
		
// 		var files = this.files;
		
// 		for(var i = 0; i<files.length; i++){
			
// 			if(!files[i].type.includes("image")){
// 				alert((i+1)+ "번째 파일("+files[i]+")은 이미지가 아닙니다")
// 				continue
// 			}
			
// 			$(".uploadedPic").html('')
			
// 			var reader = new FileReader()
			
// 	        reader.onload = function(){
// 	           $("<img>")
// 	           .attr({
// 	              src:this.result
// 	              ,width:200
// 	              ,height:200
// 	           })
// 	           .appendTo($(".uploadedPic"))
// 	        }   

// 			reader.readAsDataURL(files[i])
			
// 		}
// 	})
})

</script>
<style type="text/css">
#summernoteDiv{
	display: inline-block;
	position: relative;
}
#files{
	display: inline-block;
}


</style>


<div id="Alltitle" style="text-align: center; padding-top: 10px;">




</div>

<div  class="wirte" style ="width: 800px; margin: 0 auto;">
<form action="./write" method="post" enctype="multipart/form-data">
	<input type="hidden" id="curPage" name="curPage" value="">
<div class="input-group mb-3">
	<label for="title" class="input-group-text">제목</label>
	<input type="text" id="title" name="title" class="form-control">
</div>
<div class="input-group mb-3 rounded-3">
	<br>
	<label for="summernote" class="input-group-text rounded-top" style="width: 800px;" >내용</label>
	<div id="summernoteDiv">
	<textarea id="summernote" name="content" class="form-control" ></textarea>
	</div>
<!-- 	<div class="img-wrap" style="cursor:pointer;">	 -->
<!-- 		<img alt="picUpIcon" src="/resources/image/fileuploadIcon.png" style="width:50px;"> -->
<!-- 	</div> -->
<!-- 	<div class="uploadedPic"> -->
	
<!-- 	</div> -->
	<br>
	<input type="file" id="file" name="file" multiple="multiple" class="form-control rounded-bottom">
	<br>
</div>
<div id="btnGroup">
	<button class="btn btn-secondary">전송</button>
	<button id="btnCancel" type="button" class="btn btn-secondary">작성취소</button>
</div>
</form>
</div>
</div>
</div>
</div>
</body>
</html>