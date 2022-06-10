<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="css/bootstrap.css" rel="stylesheet" />
<link rel="stylesheet" href="css/module.css">
<link rel="stylesheet" href="css/loading.css">
<link rel="stylesheet" href="css/content.css">
<title>Insert title here</title>
</head>
<body>
<c:choose>
		<c:when test="${userid!=null&&admin==1}">
			<%@ include file="../layout/admin_header.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="../layout/header.jsp"%>
		</c:otherwise>
</c:choose>
<div style="width:1200px; margin:0 auto; margin-top:30px; padding-left:35px;">
    <h3>EVENT
    <c:if test="${admin==1}">
    	<button type="button" style="float:right; margin-right:10px;"class="btn btn-secondary">이벤트등록</button>
    	<button type="button" style="float:right; margin-right:10px;"class="btn btn-secondary">이벤트제거</button>
    </c:if>
    </h3>
</div>
<hr style="width:1010px; padding-right:110px;border:1.5px solid gray;"color="gray">
<div class="col-detail event" style="width:1200px; margin:0 auto; display:flex;">
	<ul class="sect-evt-item-list" style="list-style:none; width:900px;">
		<li style="width:256px; margin-top:30px;">	
		<a id="tile_0" href="http://www.cgv.co.kr/event/Goods/Default.aspx" target="_blank"> <div class="evt-thumb">		
		<img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34022/16450753700990.jpg" alt="개봉작 사용설명서"></div>
		<div class="evt-desc"><p class="txt1">개봉작 사용설명서</p><p class="txt2"> </p></div></a>
		</li>
			
		<li style="width:256px; margin-top:30px;">	
		<a id="tile_1" href="./detailViewUnited.aspx?seq=34641&amp;menu=001" target="_blank"><div class="evt-thumb">
		<img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34641/16541443521240.jpg" alt="[브로커]
		CGV 필름마크"></div><div class="evt-desc"><p class="txt1">[브로커]
		CGV 필름마크</p><p class="txt2">2022.06.02~2022.06.26</p></div></a>
		</li>
		
		<li style="width:256px; margin-top:30px;">
		<a id="tile_2" href="./detailViewUnited.aspx?seq=34615&amp;menu=001" target="_blank"><div class="evt-thumb"><img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34615/16535518195160.jpg" alt="[쥬라기월드:도미니언]
		4DX 한정판 굿즈"></div><div class="evt-desc"><p class="txt1">[쥬라기월드:도미니언]
		4DX 한정판 굿즈</p><p class="txt2">2022.05.26~2022.06.19</p></div></a>
		</li>	
		<li style="width:256px; margin-top:30px;">	
		<a id="tile_3" href="./detailViewUnited.aspx?seq=34611&amp;menu=001" target="_blank"><div class="evt-thumb"><img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34611/16535271496250.jpg" alt="[쥬라기 월드: 도미니언]
		IMAX 한정판 포스터"></div><div class="evt-desc"><p class="txt1">[쥬라기 월드: 도미니언]
		IMAX 한정판 포스터</p><p class="txt2">2022.05.26~2022.06.07<span> . </span></p></div></a>
		</li>
		
		<li style="width:256px; margin-top:30px;">	
		<a id="tile_4" href="./detailViewUnited.aspx?seq=34608&amp;menu=001" target="_blank"><div class="evt-thumb"><img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34608/16534549224840.jpg" alt="[쥬라기 월드: 도미니언]
		CGV 필름마크"></div><div class="evt-desc"><p class="txt1">[쥬라기 월드: 도미니언]
		CGV 필름마크</p><p class="txt2">2022.05.25~2022.06.19</p></div></a>
		</li>
			
		<li style="width:256px; margin-top:30px;">	
		<a id="tile_5" href="./detailViewUnited.aspx?seq=34521&amp;menu=001" target="_blank"><div class="evt-thumb"><img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34521/16521429577520.jpg" alt="[범죄도시2] 
		포토플레이 시크릿 컷"></div><div class="evt-desc"><p class="txt1">[범죄도시2] 
		포토플레이 시크릿 컷</p><p class="txt2">2022.05.10~2022.06.05<span> . </span></p></div></a>
		</li>
		
		<li style="width:256px; margin-top:30px;" >	
		<a id="tile_6" href="./detailViewUnited.aspx?seq=34501&amp;menu=001" target="_blank"><div class="evt-thumb"><img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34501/16521431715560.jpg" alt="[CGV NFT 플레이 포스터] 
		No.2 범죄도시2"></div><div class="evt-desc"><p class="txt1">[CGV NFT 플레이 포스터] 
		No.2 범죄도시2</p><p class="txt2">2022.05.10~2022.06.12</p></div></a>
		</li>
		
		<li style="width:256px; margin-top:30px;">	
		<a id="tile_7" href="./detailViewUnited.aspx?seq=34644&amp;menu=001" target="_blank"><div class="evt-thumb"><img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34644/16541570348090.jpg" alt="[CGV X ABC]수제맥주
		씨지비어 2종 런칭!"></div><div class="evt-desc"><p class="txt1">[CGV X ABC]수제맥주
		씨지비어 2종 런칭!</p><p class="txt2">2022.06.02~2022.06.30</p></div></a>
		</li>
			
		<li style="width:256px; margin-top:30px;">	
		<a id="tile_8" href="./detailViewUnited.aspx?seq=34637&amp;menu=001" target="_blank"><div class="evt-thumb"><img src="https://img.cgv.co.kr/WebApp/contents/eventV4/34637/16539003711120.jpg" alt="[쥬라기월드: 도미니언]야광컵 론칭!"></div><div class="evt-desc"><p class="txt1">&lt;쥬라기월드: 도미니언&gt;
		야광컵 론칭!</p><p class="txt2">2022.05.30~2022.06.14</p></div></a>
		</li>
	</ul>
	<div class="col-aside" style="padding-top:30px;">
    	<div class="ad-event">
            <div class="ad-partner01">
                <iframe src="http://ad.cgv.co.kr/NetInsight/html/CGV/CGV_201401/sub@M_Rectangle" width="160" height="300" title="영화광고-마녀(魔女) Part2. The Other One" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" name="M_Rectangle" id="M_Rectangle"></iframe>
            </div>
            <div class="ad-partner01">
                <iframe src="http://ad.cgv.co.kr/NetInsight/html/CGV/CGV_201401/sub@C_Rectangle" width="160" height="300" title="" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" name="C_Rectangle" id="C_Rectangle"></iframe>
            </div>
            <div class="ad-partner02">
                <iframe src="http://ad.cgv.co.kr/NetInsight/html/CGV/CGV_201401/sub@Image_text" width="160" height="35" title="" frameborder="0" scrolling="no" marginwidth="0" marginheight="0" name="Image_text" id="Image_text"></iframe>
            </div>
        </div>
    </div>
</div>
<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
	​<script src="js/movieSearch.js"></script>
	​<script src="js/jquery.blockUI.js"></script>
	<script src="js/trailer.js"></script>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>