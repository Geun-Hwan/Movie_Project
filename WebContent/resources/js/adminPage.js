function reportAll(){
		$.ajax({
			type : "post",
				url : "reportAll.do",
				async: true,
				dataType : 'json',
				complete : function(){
					$.ajax({
						type : "GET",
						url : "reportList",
						async : false,
						dataType : "html",
						cache : false,
						success : function(data2) {
							$("#adminContent").children().remove();
							$('#adminContent').html(data2);
						},complete:function(){
							console.log("완료");
						}
					});
				}
		});
	}
	
	$(document).on("click","#repagingul li a",function(){ 
		 pageNum=$(this).attr("id");    
		
		 console.log(pageNum);
		 
		 $.ajax({
				type : "post",
					url : "adminReportPaging",
					data : {
						pageNum : pageNum
					},
					async: true,
					dataType : 'json',
					beforeSoned : function(){
						$('.wrap-loading').removeClass('display-none');
						$.blockUI({ message: null });
					},
					complete : function ( ){
						$.ajax({
							type : "GET",
							url : "reportList",
							async : true,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#adminContent").children().remove();
								$('#adminContent').html(data2);
							},
							complete : function(){
								$('.wrap-loading').addClass('display-none');
								$.unblockUI();
							}
						});
					}
			}); 							
	});
	
	
	function ticketAll(){
		$.ajax({
			type : "post",
				url : "ticketAll.do",
				async: false,
				dataType : 'json',
				complete : function(){
					$.ajax({
						type : "GET",
						url : "ticketList",
						async : false,
						dataType : "html",
						cache : false,
						success : function(data2) {
							$("#adminContent").children().remove();
							$('#adminContent').html(data2);
						},complete:function(){
							console.log("완료");
						}
					});
				}
		});
	}
	
	$(document).on("click","#tipagingul li a",function(){ 
		 pageNum=$(this).attr("id");    
		
		 console.log(pageNum);
		 
		 $.ajax({
				type : "post",
					url : "adminTicketPaging",
					data : {
						pageNum : pageNum
					},
					async: true,
					dataType : 'json',
					beforeSoned : function(){
						$('.wrap-loading').removeClass('display-none');
						$.blockUI({ message: null });
					},
					complete : function ( ){
						$.ajax({
							type : "GET",
							url : "ticketList",
							async : true,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#adminContent").children().remove();
								$('#adminContent').html(data2);
							},
							complete : function(){
								$('.wrap-loading').addClass('display-none');
								$.unblockUI();
							}
						});
					}
			}); 							
	});
	
	function banUserAll(){
		$.ajax({
			type : "post",
				url : "banUserAll",
				async: true,
				dataType : 'json',
				beforeSoned : function(){
					$('.wrap-loading').removeClass('display-none');
					$.blockUI({ message: null });
				},
				complete : function(){
					$.ajax({
						type : "GET",
						url : "banList",
						async : false,
						dataType : "html",
						cache : false,
						success : function(data2) {
							$("#adminContent").children().remove();
							$('#adminContent').html(data2);
						},complete:function(){
							$('.wrap-loading').addClass('display-none');
							$.unblockUI();
							console.log("완료");
						}
					});
				}
		});
	}
	
	function reportResult(index){
		var writer = $("#writer"+index).val();
		var reson =$("#reson"+index).val();
		var today = new Date();
		var tomorrow = new Date(today.setDate(today.getDate()+1));
		var month = tomorrow.getMonth() +1;
		var day = tomorrow.getDate();
		var reportUser2 =$("#reporter"+index).val();
		var reportCode2 =$("#report_code"+index).val();
		month = month >= 10 ? month : '0' + month;
		day = day >= 10 ? day : '0' + day;
		
		var min =tomorrow.getFullYear() +'-'+month+'-'+day;
		console.log(min);
		console.log(reson);
		
		$("#ban_date").attr("min",min);
		$("#ban_date").val(min);
		$("#writeUser2").val(writer);
		$("#Reson2").val(reson);
		
		$("#reportUser2").val(reportUser2);
		$("#reportCode2").val(reportCode2);
	}
	function reportDelete(){
		var writer =$("#writeUser2").val();
		var reporter =$("#reportUser2").val();
		var code = $("#reportCode2").val();
		
		$.ajax({
			type:"post",
			url: "reportDelete",
			async:true,
			dataType:"json",
			data : {
				writer : writer,
				reporter : reporter,
				code : code
			},
			complete : function(){
				alert("해당 신고 반려");
				$("#reportResult").modal("hide");
				$(".modal-backdrop").remove();
				reportAll();
			}
		});
		
	}
	function reportBan(){
		var ban_date = $("#ban_date").val();
		
		if(ban_date.length ==0){
			alert("날짜를 선택해주세요.");
			return;
		}
		if(ban_date<$("#ban_date").attr("min")){
			alert("오늘 날짜 이후만 선택 가능합니다.");
			return;
		}
		
		var userid=$("#writeUser2").val();
		var ban_date=$("#ban_date").val();
		
		$.ajax({
			type:"post",
			url: "banChange",
			async:true,
			dataType:"json",
			data : {
				userid : userid,
				ban_date : ban_date
			},
			complete : function(){
				var writer =$("#writeUser2").val();
				var reporter =$("#reportUser2").val();
				var code = $("#reportCode2").val();
				
				alert("해당 유저 정지");
				$.ajax({
					type:"post",
					url: "reportDelete",
					async:true,
					dataType:"json",
					data : {
						writer : writer,
						reporter : reporter,
						code : code
					}
					});
				$("#reportResult").modal("hide");
				$(".modal-backdrop").remove();
				banUserAll();
				$(".custum-list").removeClass("liston");
				$(".custum-list").eq(3).addClass("liston");
			}
		})
	}
	
	function banCheck(userid,ban_date){
		$("#banuser").val(userid);
		$("#ban_date").val(ban_date);
		
		var today = new Date();
		var tomorrow = new Date(today.setDate(today.getDate()+1));
		var month = tomorrow.getMonth() +1;
		var day = tomorrow.getDate();
		
		month = month >= 10 ? month : '0' + month;
		day = day >= 10 ? day : '0' + day;
		
		var min =tomorrow.getFullYear() +'-'+month+'-'+day;
		console.log(min);
		$("#ban_date").attr("min",min);
	}
	
	
	function banDateChangeOk(){
		var userid = $("#banuser").val();
		var ban_date = $("#ban_date").val();
		
		if(ban_date.length ==0){
			alert("날짜를 선택해주세요.");
			return;
		}
		if(ban_date<$("#ban_date").attr("min")){
			alert("오늘 날짜 이후만 선택 가능합니다.");
			return;
		}
		
		$.ajax({
			type:"post",
			url: "banChange",
			async:false,
			dataType:"json",
			data : {
				userid : userid,
				ban_date : ban_date
			},
			complete : function(){
				alert("변경완료");
				$("#bandateChange").modal("hide");
				$(".modal-backdrop").remove();
				banUserAll();
			}
		})
	}
	
	
	function askAll(){
		$.ajax({
			type : "post",
				url : "askAll.do",
				async: true,
				dataType : 'json',
				complete : function(){
					$.ajax({
						type : "GET",
						url : "askList",
						async : false,
						dataType : "html",
						cache : false,
						success : function(data2) {
							$("#adminContent").children().remove();
							$('#adminContent').html(data2);
						},complete:function(){
							console.log("완료");
						}
					});
				}
		});
	}
	
	function answerWrite(num){
		
		var category=$("#qna_category"+num).val();
		var content=$("#qna_content"+num).val();
		var userid = $("#qna_userid"+num).val();
		var answer=$("#qna_answer"+num).val();
		
		if(answer !=""){
			alert("답변 완료한 문의입니다.");
			return;
		}
		$("#admin_category").val(category);
		$("#answerNum").val(num);
		$("#ask_userid").val(userid);
		
		$("#answerWriteform").modal("show");
	}
	
	function answerOk(){
		if($("#admin_title").val().trim().length ==0){
			alert("제목을 입력해주세요.");
			return;
		}
		if($("#admin_content").val().trim().length ==0){
			alert("내용을 입력해주세요.");
			return;
		}
		
		var newForm = document.getElementById('answerform');
		newForm.method="post";
		newForm.submit();
		alert("답변 완료");
	}
	
	function deleteQna(num){
		if(confirm("정말 삭제 하시겠습니까?")){
			$.ajax({
				type : "POST",
				url : "deleteQna.do",
				async : false,
				data : {
					num : num
				},
				dataType : "json",
				cache : false,
				complete:function(){
					alert("삭제 완료.");
					askAll();
				}		
			});
		}
	}