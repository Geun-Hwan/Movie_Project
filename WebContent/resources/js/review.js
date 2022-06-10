function reviewChange(index){
	var userid=$("#reuserid"+index).text();
	var content=$("#recontent"+index).text();
	var write_date=$("#day"+index).text();

	$("#modal-review").val(content);
	$("#reuser").val(userid);
	$("#write_date2").val(write_date);
	$("#rescore").val(5);
	console.log($("#write_date2").val());
	console.log($("#reuser").val())
	
	$("#star").children("a").removeClass("ons");     	
  $("#star").children().addClass("ons");
	 
}

function reviewDelete(){
	var code=$("#code").val();
	var userid=$("#reuserid").text();
	console.log(code);
	if(confirm("정말 삭제 하시겠습니까?")){
		$.ajax({
		type : "post",
		url : "reviewDelete",
			data : {
				code : code,
				userid:userid
			},
			dataType : 'json',
			success : function(data) {
				if(data ==0){
					alert("삭제 실패");
					location.href='movieInfo?code='+code;
				}else{
					alert("삭제 완료");
					location.href='movieInfo?code='+code;
				}
			}
		})
	};
}
function fncChkBytemodal(obj, maxByte) {
	  var ls_str = obj.value;
	  var li_str_len = ls_str.length; 
	  var li_byte = 0;
	  var li_len = 0;
	  var ls_one_char = "";
	  var ls_str2 = "";
	  for ( var i=0; i< li_str_len; i++) {
		    ls_one_char = ls_str.charAt(i);
		 
		    if (escape(ls_one_char).length > 4) {
		      li_byte += 2;
		    } else {
		      li_byte++;
		    }
		        
		    if(li_byte <= maxByte) {
		      li_len = i + 1;
		    }
		  }
		  if(li_byte > maxByte) {
		    alert("250Byte 이상 작성할 수 없습니다. ");
		    ls_str2 = ls_str.substr(0, li_len);
		    obj.value = ls_str2;
		    fncChkBytemodal(obj, 4000);
		  } else {
		    document.getElementById('m-count').innerText = li_byte;
		  }
	}
function fncChkBytemodal2(obj, maxByte) {
	  var ls_str = obj.value;
	  var li_str_len = ls_str.length; 
	  var li_byte = 0;
	  var li_len = 0;
	  var ls_one_char = "";
	  var ls_str2 = "";
	  for ( var i=0; i< li_str_len; i++) {
		    ls_one_char = ls_str.charAt(i);
		 
		    if (escape(ls_one_char).length > 4) {
		      li_byte += 2;
		    } else {
		      li_byte++;
		    }
		        
		    if(li_byte <= maxByte) {
		      li_len = i + 1;
		    }
		  }
		  if(li_byte > maxByte) {
		    alert("250Byte 이상 작성할 수 없습니다. ");
		    ls_str2 = ls_str.substr(0, li_len);
		    obj.value = ls_str2;
		    fncChkBytemodal(obj, 4000);
		  } else {
		    document.getElementById('reson-count').innerText = li_byte;
		  }
	}
function fncChkByte(obj, maxByte) {
	  var ls_str = obj.value;
	  var li_str_len = ls_str.length; 
	  var li_byte = 0;
	  var li_len = 0;
	  var ls_one_char = "";
	  var ls_str2 = "";
	  for ( var i=0; i< li_str_len; i++) {
		    ls_one_char = ls_str.charAt(i);
		 
		    if (escape(ls_one_char).length > 4) {
		      li_byte += 2;
		    } else {
		      li_byte++;
		    }
		        
		    if(li_byte <= maxByte) {
		      li_len = i + 1;
		    }
		  }
		  if(li_byte > maxByte) {
		    alert("250Byte 이상 작성할 수 없습니다. ");
		    ls_str2 = ls_str.substr(0, li_len);
		    obj.value = ls_str2;
		    fncChkByte(obj, 4000);
		  } else {
		    document.getElementById('count').innerText = li_byte;
		  }
	}



function revChangeConfirm(){
	if(!($("#modal-review").val().trim().length)){ // 공백만 작성
		alert("내용을 입력해 주세요.");
		return;
	}
	
	
	console.log($("#reviewChangeCheck").text());
	var newForm = $("#reviewChangeForm");
	newForm.method="post";
	newForm.submit();
}

function reviewLike(ths){
	var reviewcode = $("#code").val();
	var writerid =$(ths).attr("id"); //추천 클릭시 작성자 아이디 추출. 
	var writerLike = Number($("#idLikeValue"+writerid).text())+1; // 클릭시 작성자 추천수 확인후 +1
	console.log(reviewcode); //code
	console.log(writerid); // userid
	console.log(writerLike); // like
	// 위의 3값으로 db 업데이트 하고 
	$.ajax({
		type : "post",
		url : "reviewLike",
			data : {
				code : reviewcode,
				userid:writerid,
				like:writerLike
			},
			dataType : 'json',
			async : false
		})
	
	$("#idLikeValue"+writerid).text(writerLike);
}
function userReport(){
	
	console.log($("#userid").val().length);
	if($("#userid").val().length==0){
		alert("로그인후 이용해 주세요.")
		return;
	}
}
