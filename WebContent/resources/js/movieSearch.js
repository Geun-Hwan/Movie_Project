function movieSearch(){
	var str=$("#search").val();

	str=str.trim();
	str=str.replace(/\s{2,}/gi, ' ');
	if(str==''){
		alert("검색어를 입력해주세요.")
		return;
	}
	
	if(str.length<2){
		alert("두자 이상 입력해주세요.")
		return;
	}
	
	$("#search").val(str);
	$('.wrap-loading').removeClass('display-none');
	 var newForm = document.getElementById('searchform');
		newForm.method="get";
		newForm.submit();
}
//엔터로 검색시 처리
function searchEvt(){
	 var str=$("#search").val();
	// 공백으로만 이루어져 있으면 return
	 str=str.trim();
		str=str.replace(/\s{2,}/gi, ' ');
		if(str==''){
			alert("검색어를 입력해주세요.")
			return;
		}
		
		if(str.length<2){
			alert("두자 이상 입력해주세요.")
			return;
		}
		$('.wrap-loading').removeClass('display-none');
	 var newForm = document.getElementById('searchform');
		newForm.method="get";
		newForm.submit();
}