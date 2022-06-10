$(document).ready(function() {
	var titlecheck = $(".movie.active").length;
	var cinemacheck = $(".theater-place.active").length;
	var datecheck = $(".movie-date-wrapper-active").length;
	var release;
	var price;
	$(document).on("click",".movie",function(){ 
    	titlecheck=$(".movie.active").length;
    	datecheck=0;
    	price=$(this).find("#price").val();
    	$(".movie").removeClass("active");
    	$(this).addClass("active");
    	$(".movie-date-wrapper").removeClass("norelease");
    	$(".movie-date-wrapper").attr("disabled",false);
    	release=new Date($(this).find("#release").val());
    	console.log("개봉일:"+release);
    	console.log(price);
    	$(".movie-date-wrapper").removeClass("movie-date-wrapper-active");
		$("#checkOk").children().remove();
		$("#checkOk").html("<div style='text-align:center; margin-top:200px; font-size:18px;'><b>영화,극장,날짜를 선택해 주세요.</b></div>")
    	if(release>date)
    	{
    		if(date.getMonth()+1 == release.getMonth()+1){
    			for(var idx=0; idx<release.getDate()-date.getDate(); idx++){
    				
    				$(".movie-date-wrapper").eq(idx).addClass("norelease");
    				$(".movie-date-wrapper").eq(idx).attr("disabled",true)
    			}
    		}else{ 
    			for(var idx=0; idx<$(".nextMonth").index()+release.getDate()-1; idx++){
    				datecheck=0;
    				$(".movie-date-wrapper").eq(idx).addClass("norelease");
    				$(".movie-date-wrapper").eq(idx).attr("disabled",true)
    			}
    		 }
    		console.log(release.getDate());
    	} 
    	   	 	
    });
	
	
	$(document).on("click",".theater-place",function(){
		cinemacheck =$(".theater-place.active").length;
		datecheck=0;
		$(".movie-date-wrapper").removeClass("movie-date-wrapper-active");
		$("#checkOk").children().remove();
		$("#checkOk").html("<div style='text-align:center; margin-top:200px; font-size:18px;'><b>영화,극장,날짜를 선택해 주세요.</b></div>")
		$(".theater-place").removeClass("active");
    	$(this).addClass("active");
    	
		
    });
	
	$(document).on("click",".movie-date-wrapper",function(){	
		datecheck =$(".movie-date-wrapper-active").length;
		var day = $(".movie-date-wrapper-active").find($(".movie-day")).text();
		var week =$(".movie-date-wrapper-active").find($(".movie-week-of-day")).text();; 
		var remaindate;
		
		if ($(".nextMonth").index() > $(".movie-date-wrapper-active").index()) {
			
			 remaindate=year + "." + month + "." + day + "(" + week + ")";
			 
		} else {
			 remaindate=year + "." + month2 + "." + day + "(" + week + ")";
		}	
		var today = new Date();
		if(titlecheck != 0 &&cinemacheck != 0 &&datecheck != 0){
			
			$.ajax({
				type : "POST",
				url : "seatRemainCheck",
				data : {
					title : $(".movie.active").find("a").text(),
					movieDate : remaindate,
					cinema : "EZV"+$(".theater-place.active").text() + " "
							+ $(".selected-theater-place-info").eq(1).text()
				},
				async : true,
				beforeSend: function(xhr){
					$('.wrap-loading').removeClass('display-none');
					$.blockUI({ message: null });
				},
				success : function(data) {
					$.ajax({
						type : "GET",
						url : "timetable",
						async : false,
						dataType : "html",
						cache : false,
						success : function(data2) {
							$("#checkOk").children().remove();
							$('#checkOk').html(data2);
						}
					});					
				},complete : function(){
					$('.wrap-loading').addClass('display-none');
					$.unblockUI();
					
					if(today>new Date(remaindate+$(".time-select").eq(0).text())){
						$(".time-select").eq(0).attr("disabled",true);
						$(".seatcount").eq(0).css("color","black");
						$(".seatcount").eq(0).css("font-weight","bold");
						$(".seatcount").eq(0).text("상영시간 전에만 예매 가능합니다.");
					}
					if(today>new Date(remaindate+$(".time-select").eq(1).text())){
						$(".time-select").eq(1).attr("disabled",true);
						$(".seatcount").eq(1).css("color","black");
						$(".seatcount").eq(1).css("font-weight","bold");
						$(".seatcount").eq(1).text("상영시간 전에만 예매 가능합니다.");
					}
					if(today>new Date(remaindate+$(".time-select").eq(2).text())){
						$(".time-select").eq(2).attr("disabled",true);
						$(".seatcount").eq(2).css("color","black");
						$(".seatcount").eq(2).css("font-weight","bold");
						$(".seatcount").eq(2).text("상영시간 전에만 예매 가능합니다.");
					}
					if(today>new Date(remaindate+$(".time-select").eq(3).text())){
						$(".time-select").eq(3).attr("disabled",true);
						$(".seatcount").eq(3).css("color","black");
						$(".seatcount").eq(3).css("font-weight","bold");
						$(".seatcount").eq(3).text("상영시간 전에만 예매 가능합니다.");
					}
					
				}
			});
		}
    });
	  $(document).on("click",".time-select",function(){ 
      	$(".time-select").removeClass("time-wrapper-active");
      	$(this).addClass("time-wrapper-active");
      });

	
});