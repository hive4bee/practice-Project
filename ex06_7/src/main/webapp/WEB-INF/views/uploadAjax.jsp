<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>uploadAjax</title>
	<style>
		.uploadResult {
			width: 100%;
			background-color: gray;
		}

		.uploadResult ul {
			display: flex;
			flex-flow: row;
			justify-content: center;
			align-items: center;
		}
		
		.uploadResult ul li {
			list-style: none;
			padding: 10px;
		}
		
		.uploadResult ul li img {
			width: 100px;
		}
		
	</style>
	<style>
		.bigPictureWrapper {
		  position: absolute;
		  display: none;
		  justify-content: center;
		  align-items: center;
		  top:0%;
		  width:100%;
		  height:100%;
		  background-color: gray; 
		  z-index: 100;
		}
		
		.bigPicture {
		  position: relative;
		  display:flex;
		  justify-content: center;
		  align-items: center;
		}
	</style>
</head>
<body>
	<h1>upload with Ajax</h1>
	<div class='bigPictureWrapper'>
	  <div class='bigPicture'>
	  </div>
	</div>


	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>

	<div class='uploadResult'>
		<ul>

		</ul>
	</div>
	<button id='uploadBtn'>Upload</button>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<!--  
	<script>
		$(document).ready(function(){
			$("#uploadBtn").on("click", function(e){
				var formData = new FormData();
				var inputFile = $("input[name='uploadFile']");
				var files = inputFile[0].files;
				console.log(files);

				//add filedata to formdata
				for(var i=0; i<files.length; i++){
					formData.append("uploadFile", files[i]);
				}

				$.ajax({
					url:"/uploadAjaxAction",
					processData:false,
					contentType:false,
					data:formData,
					type:"POST",
					success:function(result){
						alert("Uploaded");
					}
				});//end $.ajax
			});
		});
	</script>
	 -->
	<!-- 
	 // 정규표현식 객체 생성자 
	var pattern = new RegExp('a');

	 // RegExp.exec() => 필요한 정보(문자)를 추출하는데 목적 
	 console.log(pattern.exec('abcdef')); // ["a"] 
	 // 실행결과는 문자열 a를 값으로 하는 배열을 리턴한다. 
	 console.log(pattern.exec('bcdefg')); // null 
	 // 인자 'bcdef'에는 a가 없기 때문에 null을 리턴한다. 
	 
	 //RegExp.test() => 패턴이 있는지 없는지를 테스트하는데 목적 
	 // test는 인자 안에 패턴에 해당되는 문자열이 있으면 true, 없으면 false를 리턴한다. 
	 console.log(pattern.test('abcdef')); // true 
	 console.log(pattern.test('bcdefg')); // false

	  -->
	<script>
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;//5MB;
		var cloneObj = $(".uploadDiv").clone();
		var uploadResult = $(".uploadResult ul");
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		$("#uploadBtn").on("click", function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			//console.log(files);
			for(var i=0; i<files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url : "/uploadAjaxAction",
				processData : false,
				contentType : false,
				data : formData,
				type : "POST",
				dataType:"json",
				success : function(result) {
					console.log(result);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			});//$.ajax
		});
		//파일이름만 출력함
		/* 
		function showUploadedFile(uploadResultArr){
			var str = "";
			$(uploadResultArr).each(
					function(i, obj) {
						if(!obj.image){
							str+="<li><img src='/resources/img/attach.png'>"
								+obj.fileName+"</li>";
						}else{
							str += "<li>" + obj.fileName + "</li>";
						}
			});
			uploadResult.append(str);
		}
		 */
		 /* 
		 //이미지파일을 업로드할 경우 이미지만, 이미지파일이 아닐경우 이름/디폴트이미지만
		 function showUploadedFile(uploadResultArr){
				var str = "";
				$(uploadResultArr).each(
						function(i, obj) {
							if(!obj.image){
								str+="<li><img src='/resources/img/attach.png'>"
									+obj.fileName+"</li>";
							}else{
								//str += "<li>" + obj.fileName + "</li>";
								var fileCallPath=encodeURIComponent(obj.uploadPath+"\\s_"+obj.uuid+"_"+obj.fileName);
								str+="<li><img src='/display?fileName="+fileCallPath+"'><li>";
							}
				});
				uploadResult.append(str);
			}
		  */
		  /* 
		  //이제 다운로드까지 가능
		  function showUploadedFile(uploadResultArr){
				var str = "";
				$(uploadResultArr).each(
						function(i, obj) {
							if(!obj.image){
								var fileCallPath=encodeURIComponent(obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName);
								str+="<li><a href='/download?fileName="+fileCallPath+"'>"
									+"<img src='/resources/img/attach.png'>"+obj.fileName+"</a></li>";
							}else{
								//str += "<li>" + obj.fileName + "</li>";
								var fileCallPath=encodeURIComponent(obj.uploadPath+"\\s_"+obj.uuid+"_"+obj.fileName);
								str+="<li><img src='/display?fileName="+fileCallPath+"'><li>";
							}
				});
				uploadResult.append(str);
			}
		   */
		   
		   //첨부한 후 원본 이미지를 보여준다.
		   function showUploadedFile(uploadResultArr){
				var str = "";
				$(uploadResultArr).each(
						function(i, obj) {
							if(!obj.image){
								var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
								var fileLink=fileCallPath.replace(new RegExp(/\\/g), "/");
								str+="<li><a href='/download?fileName="+fileCallPath+"'>"
									+"<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"
									+"<span data-file=\'"+fileCallPath+"\' data-type='file'>X</span>"+"<div></li>";
							}else{
								//str += "<li>" + obj.fileName + "</li>";
								var fileCallPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
								var originPath = obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName;
								originPath = originPath.replace(new RegExp(/\\/g), "/");
								str +="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath+"'></a>"
										+"<span data-file=\'"+fileCallPath+"\' data-type='image'>X</span></li>";
							}
				});
				uploadResult.append(str);
			}
	</script>
	<script>
		function showImage(fileCallPath){
			//alert(fileCallPath);
			$(".bigPictureWrapper").css("display","flex").show();
			$(".bigPicture").html("<img src='/display?fileName="+encodeURIComponent(fileCallPath)+"'>").animate({width:'100%',height:'100%'},1000);
		}
		$(document).ready(function(){
			$(".bigPictureWrapper").on("click", function(e){
				$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
				setTimeout(()=>{//()=>{}
					$(this).hide();
				}, 1000);
			});
			
			$(".uploadResult").on("click", "span", function(e){
				var targetFile = $(this).data("file");
				var type=$(this).data("type");
				console.log(targetFile);
				
				$.ajax({
					url:"/deleteFile",
					data:{fileName:targetFile, type:type},
					dataType:'text',
					type:"POST",
					success:function(result){
						alert(result);
					}
				});//end $.ajax
			});//end uploadResult
		});//end ready
	</script>
</body>
</html>