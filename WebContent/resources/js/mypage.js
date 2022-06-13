let userid =$("#myid").val();
let pass =null;
let regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,15}$/;
let pcheck = true;

$(document).ready(function(){
	$(".custum-list").click(function(){
		i = $(this).index();
		$(".custum-list").removeClass("liston");
		$(this).addClass("liston");
	});
	
	$('#qnaInfo').on('hide.bs.modal', function () {
	    console.log("close");
	  });
});
function myReview(){   	
	$.ajax({
		type : "post",
		url : "myInfoUpdate.do",
		data : {
			userid : userid
		},
		async : true,
		beforeSend : function (xhr){
			$('.wrap-loading').removeClass('display-none');
			$.blockUI({ message: null });
		},
		success : function(data) {
			pass = data;
		},
		complete : function(){
			$.ajax({
				type : "post",
					url : "myReviewAll.do",
					data : {
						userid : userid
					},
					async: false,
					dataType : 'json',
					complete : function(){
						$.ajax({
							type : "GET",
							url : "myReviewList",
							async : false,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#myContent").children().remove();
								$('#myContent').html(data2);
							},complete:function(){
								$(".wrap-loading").addClass('display-none');  	
								$.unblockUI();
							}
						});
					}
			});
		}
		});
}

function myInfoUpdate(){
	
	$.ajax({
		type : "post",
		url : "myInfoUpdate.do",
		data : {
			userid : userid
		},
		async : true,
		beforeSend : function (xhr){
			$('.wrap-loading').removeClass('display-none');
			$.blockUI({ message: null });
		},
		success : function(data) {
			pass = data;
			$.ajax({
				type : "GET",
				url : "myPageCheck",
				async : true,
				dataType : "html",
				cache : false,
				success : function(data2) {
					$("#myContent").children().remove();
					$('#myContent').html(data2);
				},
				complete : function(){
					$('.wrap-loading').addClass('display-none');
					$.unblockUI();
				}
			});
		}
	});
}

function passSubmit(){
	formPass = $("#mypassword").val();
	
	if(formPass == pass){
		$("#passconfirm").css("color","green");
		$("#passconfirm").html("비밀번호 일치.");
		$.ajax({
			type : "post",
			url : "memberUpdate",
			data : {
				userid : userid
			},
			dataType : 'json',
			async : true,
			complete : function(){
				$.ajax({
			        type : "GET",
			        url : "memberUpdate",
			        async : false,
			        dataType : "html",
			        cache : false,
			        success : function(data1) {
			        	$("#myContent").children().remove();
			            $('#myContent').html(data1);
			        }	
				});	
			}
		});

		
	}else{
		$("#passconfirm").html("비밀번호가 일치하지 않습니다.");
	}
}

function changeInfo(){
if(!($("#changeName").val().trim().length)){
	alert("이름을 입력해주세요.")
	return false;
}	
	
if ($("#changePass").val()!= $("#changePass2").val()) {
	alert("비밀번호가 일치하지 않습니다.");
	$("#changePass2").focus();
	return false;
	}

if ($("#birth").val().legth==0) {
	alert("생년월일을 입력해 주세요.");
	$("#birth").focus();

	return false;
	}
var ck=confirm("수정 하시겠습니까?");
if(pcheck==true&&ck){
	var newForm = document.getElementById('changeForm');
	newForm.method="POST";
	newForm.submit();
	}
}


function myReviewChange(index){
	var i = index;
	var	mycode = $("#mycode"+i).val();
	var	myid = $("#myid"+i).val();
	var	my_write_date;
	var	my_title;
	var	my_score;
	var	myreview;
	
	$.ajax({
		type : "post",
		url : "myOneReview",
		data : {
				mycode : mycode,
				myid : myid
			},
		dataType : 'json',
		async : false,
		success : function(data) {
			my_write_date=data.write_date;
			my_title=data.title;
			my_score=data.score;
			myreview=data.content;
		}
	});
	
	$("#star").children("a").removeClass("ons");     
	$('#star a:eq('+(my_score-1)+')').addClass("ons").prevAll("a").addClass("ons");
	$("#rescore").val(my_score);
	
	$("#reuser").val(myid);
	$("#code2").val(mycode);
	$("#write_date2").val(my_write_date);
	$("#modal-review").val(myreview)
	$("#rescore").val(my_score);
	$("#retitle").val(my_title);
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
		    document.getElementById('rev-count').innerText = li_byte;
		  }
	}


function myReviewSubmit(){
	
	console.log("test");
	
	if(!($("#modal-review").val().trim().length)){ // 공백만 작성
		alert("내용을 입력해 주세요.");
		return;
	}

	var recode=$("#code2").val()
	var reuser =$("#reuser").val()
	var rewrite_date=$("#write_date2").val()
	var remodal=$("#modal-review").val()
	var rescore=$("#rescore").val()
	var retitle=$("#retitle").val();
	
	$.ajax({
		type : "post",
		url : "myReviewUpdate",
		data : {
			recode : recode,
			reuser : reuser,
			rewrite_date:rewrite_date,
			remodal:remodal,
			rescore:rescore,
			retitle:retitle
			},
		dataType : 'json',
		async : false,
		success : function(data) {
			if(data==0){
				alert("수정실패");
			}
			else{
				$("#reviewChange").modal("hide");	
				myReview(); // 변경 후 바뀐 목록 재호출
				alert("수정완료.");
			}
		}
	});
}
function myReviewSubmit2(){
	
	console.log("test");
	
	if(!($("#modal-review").val().trim().length)){ // 공백만 작성
		alert("내용을 입력해 주세요.");
		return;
	}

	var recode=$("#code2").val()
	var reuser =$("#reuser").val()
	var rewrite_date=$("#write_date2").val()
	var remodal=$("#modal-review").val()
	var rescore=$("#rescore").val()
	var retitle=$("#retitle").val();
	
	$.ajax({
		type : "post",
		url : "myReviewUpdate",
		data : {
			recode : recode,
			reuser : reuser,
			rewrite_date:rewrite_date,
			remodal:remodal,
			rescore:rescore,
			retitle:retitle
			},
		dataType : 'json',
		async : false,
		success : function(data) {
			if(data==0){
				alert("수정실패");
			}
			else{
				$("#reviewChange").modal("hide");	
				alert("수정완료.");
			}
		}
	});
}

function myReviewDelete(index){
	var i = index;
	var	mycode = $("#mycode"+i).val();
	var	myid = $("#myid"+i).val();
	var deleteCheck=confirm("정말 삭제하시겠습니까?");
	var inpass;
	if(deleteCheck){
		inpass=prompt("삭제하시려면 비밀번호를 입력하세요."); // 모달로 변경 
	}else{
		return;
	}
	
	if(inpass==pass){
	$.ajax({
		type : "post",
		url : "reviewDelete",
		data : {
			code : mycode,
			userid : myid,
			},
		dataType : 'json',
		async : false,
		success : function(data) {
			if(data==0){
				alert("삭제실패");
			}
			else{
				myReview(); // 변경 후 바뀐 목록 재호출
				alert("삭제완료.");
			}
		}
	});
	}else if(inpass==undefined){
		return;
	}else{
		alert("비밀번호가 옳지 않습니다.")
	}
	
}

function myTicket(){
		$.ajax({
	        type : "GET",
	        url : "myAllTicket",
	        async : true,
	        data : {
	        	userid:userid
	        	},
	        dataType : "html",
	        cache : false,
	        beforeSend : function(){
	        	$('.wrap-loading').removeClass('display-none');
				$.blockUI({ message: null });
	        },
	        success : function(data1) {
	        	$("#myContent").children().remove();
	            $('#myContent').html(data1);
	        },
	        complete : function(){
	        	$('.wrap-loading').addClass('display-none');
				$.unblockUI();
	        }
		});	
}

function myAsk(){
	$.ajax({
		type : "post",
			url : "myQnaAll.do",
			data : {
				userid : userid
			},
			async: true,
			dataType : 'json',
			 beforeSend : function(){
		        	$('.wrap-loading').removeClass('display-none');
					$.blockUI({ message: null });
		        },
			complete : function(){
				$.ajax({
					type : "GET",
					url : "myQnaList",
					async : false,
					dataType : "html",
					cache : false,
					success : function(data2) {
						$("#myContent").children().remove();
						$('#myContent').html(data2);
					},complete:function(){
						$(".wrap-loading").addClass('display-none');  	
						$.unblockUI();
					}
				});
			}
	});
}

function selfDeleteMember(){
	var delck=confirm("정말 탈퇴 하시겠습니까? 모든 활동 내역이 삭제 됩니다.");
	var inpass;
	if(delck){
		inpass=prompt("탈퇴하려면 비밀번호를 입력하세요.");	 // 모달로 변경
	}else{
		return;
	}
	
	if(pass==inpass){
			$.ajax({
				type : "post",
				url : "merberDelete",
				data : {
					userid : userid
					},
				dataType : 'json',
				async : false,
			});
			location.href="main";
			alert("정상적으로 탈퇴되었습니다.");
	}else if(inpass==undefined){
		return;
	}else{
		alert("비밀번호가 옳지 않습니다.");	
	}
}

function qnaInfo(num){
	var title=$("#qna_title"+num).val();
	var userid=$("#qna_userid"+num).val();
	var write_date=$("#qna_write_date"+num).val();
	var category=$("#qna_category"+num).val();
	var content=$("#qna_content"+num).val();
	var fileName=$("#qna_fileName"+num).val();
	var answer=$("#qna_answer"+num).val();
	var answerBoard;
	if(fileName!=""){
		$("#fileCheck").attr("href","download?userid="+userid+"&fileName="+fileName);
		$("#fileCheck").text(fileName);
	}else{
		$("#fileCheck").removeAttr("href");
		$("#fileCheck").text("첨부파일 없음");
	}
	if(answer==""){
		$("#answerCheck").hide();
		$("#answerNull").show();
	}else{
		$("#answerCheck").show();
		$("#answerNull").hide();
		$.ajax({
			url : "answerRead",
			type : "post",
			dataType : "json",
			data : {
				num : num
			},
			async : false,
			success : function(data){
				answerBoard = data;
			},
			complete: function(){
				$("#answer_title").val(answerBoard.title);
				$("#answer_userid").val(answerBoard.userid);
				$("#answer_write_date").val(answerBoard.write_date);
				$("#answer_category").val(answerBoard.category);
				$("#answer_content").val(answerBoard.content);
			}
		});
		//ajax num 데이터 보내고 답변글 받아오기 answer 부분에 띄워주기
	}
	
	$("#qna_title").val(title);
	$("#qna_userid").val(userid);
	$("#qna_write_date").val(write_date);
	$("#qna_category").val(category);
	$("#qna_content").val(content);
	
}

function deleteTicket(index){
	var userid=$("#duserid"+index).val();
	var title = $("#dtitle"+index).text();
	var cinema = $("#dcinema"+index).text();
	var seat = $("#dseat"+index).text();
	var date = $("#ddate"+index).text();
	var time = $("#dtime"+index).text();
	var admin =0;
	var today = new Date();
	
	console.log(userid);
	console.log(title);
	console.log(cinema);
	console.log(seat);
	console.log(date);
	console.log(time);
	
	if(today>new Date(date+time)){
		alert("영화시작 전까지만 취소 가능합니다.")
		return;
	}else{
		if(confirm("정말 취소 하시겠습니까?")){
			$.ajax({
		        type : "POST",
		        url : "ticketDelete",
		        async : true,
		        data : {
		        	userid:userid,
		        	title:title,
		        	cinema:cinema,
		        	seat:seat,
		        	movieDate:date,
		        	movieTime:time
		        	},
		        dataType : "html",
		        cache : false,
		        beforeSend : function(){
		        	$('.wrap-loading').removeClass('display-none');
					$.blockUI({ message: null });
		        },
		        success : function(data){
		        	admin=data;
		        },
		        complete : function(){
		        	$('.wrap-loading').addClass('display-none');
					$.unblockUI();
					if(admin==0){
						location.href="myPage?userid="+userid;
						alert("취소 완료");
					}
					if(admin==1){
						location.href="adminMyPage?userid=admin";
						alert("취소 완료");
					}
		        }
			});	
		}
	}
}
$('.modal').on('hidden.bs.modal', function (e) {

    console.log('modal close');
  $(this).data('modal',null);
});