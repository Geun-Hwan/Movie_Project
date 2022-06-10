 var pageNum;    
 var code;
 var userid;
 var sort;
$(document).on("click","#pagingul li a",function(){ 
		 pageNum=$(this).attr("id");    
		 code=$("#code").val();
		 userid=$("#userid").val();
		 sort = $(".sortTab.on").val();
		
		 $.ajax({
				type : "post",
					url : "reviewPaging",
					data : {
						pageNum : pageNum,
						code : code,
						sort : sort
					},
					async: true,
					dataType : 'json',
					beforeSend : function(xhr){
						$(".wrap-loading").removeClass('display-none');
						$.blockUI({ message: null }); 
					},
					complete : function(){
						$.ajax({
							type : "POST",
							url : "reviewBoard",
							async : false,
							dataType : "html",
							cache : false,
							success : function(data2) {
								$("#checkout").children().remove();
								$('#checkout').html(data2);
								$(".wrap-loading").addClass('display-none'); 
								$.unblockUI();
								var cur=pageNum; //선택한 페이지 링크 제거
								$("#"+cur).remove('href');
							}
						});
					}
			});
	});


function datesort(){
	if(pageNum==undefined){
		pageNum=1;
	}
	$("#datesort").addClass("on");
	$("#likesort").removeClass("on");     	
	
	code=$("#code").val();
	userid=$("#userid").val();
	console.log(pageNum);
	console.log(userid);
	console.log(code);
	sort = $(".sortTab.on").val();
	
	$.ajax({
		type : "post",
		url : "reviewPaging",
		data : {
			pageNum : pageNum,
			code : code,
			sort : sort
		},
		async: false,
		dataType : 'json'
		});
	$.ajax({
		type : "POST",
		url : "reviewBoard",
		async : false,
		dataType : "html",
		cache : false,
		success : function(data2) {
			$("#checkout").children().remove();
			$('#checkout').html(data2);
			
			var cur=pageNum; //선택한 페이지 링크 제거
			$("#"+cur).removeAttr('href');
		}
	});
}

function likesort(){
	if(pageNum==undefined){
		pageNum=1;
	}
	$("#likesort").addClass("on");
	$("#datesort").removeClass("on");
	
	code=$("#code").val();
	userid=$("#userid").val();
	  	
	sort = $(".sortTab.on").val();
	
	$.ajax({
		type : "post",
		url : "reviewPaging",
		data : {
			pageNum : pageNum,
			code : code,
			sort : sort
		},
		async: false,
		dataType : 'json'
		});
	
	$.ajax({
		type : "POST",
		url : "reviewBoard",
		async : false,
		dataType : "html",
		cache : false,
		success : function(data2) {
			$("#checkout").children().remove();
			$('#checkout').html(data2);
			
			var cur=pageNum; //선택한 페이지 링크 제거
			$("#"+cur).removeAttr('href');
		}
	});
}