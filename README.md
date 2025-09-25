## 영화 예매 및 리뷰 사이트 제작 프로젝트(●'◡'●)

> 본 프로젝트는 cgv 홈페이지를 참고하여 제작하였습니다.

[🚗 cgv.co.kr](https://www.cgv.co.kr)

## 사용한 기술 스택🎫

<img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
<img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">
<br>
<img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
<img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white">
<img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
<img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">

## 개발 기간

2022.04.28- 2022.06.10 (6주)

## 프로젝트 실행🚍

mvn tomcat7:run

## 주요 기능 🐱‍🏍

### client

1.  회원가입
    - ID중복확인
    - 이메일 인증
2.  로그인
3.  마이페이지
    - 회원 정보 수정
    - 회원 탈퇴 하기
    - 예매 내역 보기
    - 리뷰 관리(수정/삭제)
    - 문의 내역 보기, 답변 확인
4.  영화 예매 하기
    - 영화 ,극장, 시간,좌석 선택
    - 카카오페이 결제
    - 선택 좌석 처리
    - 예약 좌석 처리
5.  영화 리뷰 작성
    - 리뷰,별점 작성
    - 수정
    - 삭제
    - 신고 하기
    - 추천 하기
6.  문의하기
    - 문의 작성
    - 파일 업로드

### admin

1.  영화 관리
    - 영화 등록
    - 수정
    - 삭제
2.  회원 관리
    - 회원 정보 보기
    - 예매 내역
    - 리뷰 내역
    - 문의 내역
    - 회원 정지
    - 회원 탈퇴
3.  문의 관리
    - 문의 삭제
    - 답변 작성
    - 파일 다운로드
4.  리뷰 관리
    - 리뷰 수정
    - 삭제
5.  신고 처리(미흡) - 신고 유저 정지 기간 설정 - 신고 삭제 - 신고 중복 처리 , 경고 기능 (미완성)
    <br>

---

## 주요 코드👀

### 카카오 결제 api

iamport 홈페이지에서 미리 부여 받은 코드를 이용했다.<br>
결제성공시 예약정보를 DB에 저장하도록 했음.

```js
$(function(){
       var IMP = window.IMP;
       IMP.init('imp33034326');
       var msg;

       IMP.request_pay({
           pg : 'kakaopay',
           pay_method : 'card',
           merchant_uid : 'merchant_' + new Date().getTime(),
           name : '<%=ticket.getTitle()%> <%=ticket.getPerson()%>매',
            amount : <%=ticket.getPrice()%>,

       }, function(rsp) {
           if ( rsp.success ) {
               jQuery.ajax({
                   url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                   type: 'POST',
                   dataType: 'json',
                   data: {
                       imp_uid : rsp.imp_uid
                       //기타 필요한 데이터가 있으면 추가 전달
                   } '''생략
```

---

### 파일 업로드 처리

```java
@PostMapping("/qnaWrite.do")
	public String qnaWirteDo(@ModelAttribute QnaBoard qna, @RequestParam MultipartFile file, HttpSession session) throws IllegalStateException, IOException{
		String uploadDir = session.getServletContext().getRealPath("/resources/upload/"+qna.getUserid()+"/");
		String fileName = file.getOriginalFilename();
		File dir = new File(uploadDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		if(fileName.equals("")) {
			qna.setFileName("");
		}else {
			qna.setFileName(fileName);
			System.out.println(qna.getFileName());
			file.transferTo(new File(uploadDir,fileName));
		}
		System.out.println(uploadDir);
		System.out.println(fileName);
		QnaDAO qdao = new QnaDAO();
		qdao.insertQna(qna);

		return "redirect:/myPage?userid="+qna.getUserid();
	}
```

<br>

### 파일 다운로드

```java
@GetMapping("/download")
	public void download(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userid=request.getParameter("userid");
		String fileName=request.getParameter("fileName");
		System.out.println(userid);
		System.out.println(fileName);
		String path = session.getServletContext().getRealPath("/resources/upload/"+userid+"/"+fileName);
		byte[] fileByte = FileUtils.readFileToByteArray(new File(path));
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName, "UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");

	    response.getOutputStream().write(fileByte);
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}
```

### 페이징처리😂

페이징 처리를 구현할 때 웹페이지의 이동 없이(비동기) 처리하기 위해<br>

**ajax** 와 **session**을 이용하여 구현하였다.<br>

페이징번호 클릭시 ajax 통신으로 해당 번호를 넘겨 주어 미리 구현한 코드를 이용해 session을 저장<br>

html에 해당 session 값을 뿌려주어 페이징 처리를 구현<br>

### 좌석처리🪑

예약된 좌석의 처리를 위해 좌석을 화면에 띄워주기 전 예약된 좌석의 버튼을 비활성화 하였음.<br>
영화,상영관,날짜,시간을 넘겨주어 해당하는 예약내역이 있는지 확인<br>
아래 링크 참고 <br>

[선택한 좌석처리 js 🚗](https://github.com/Geun-Hwan/Movie_Project/blob/master/WebContent/resources/js/seat.js)

[예약된 좌석처리 js 🚗 ](https://github.com/Geun-Hwan/Movie_Project/blob/master/WebContent/resources/js/ticket.js)

### 참고한 블로그

https://hoing.io/archives/24492

https://velog.io/@kiki3700/%EC%8A%A4%ED%94%84%EB%A7%81-%EB%B6%80%ED%8A%B8-%EC%98%A4%EB%9D%BC%ED%81%B4-%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C-db-%EC%97%B0%EA%B2%B0autonomous-database#applicationpropertiesdata-source

https://drsggg.tistory.com/403

https://chlee21.tistory.com/170

https://electronlibrary.tistory.com/342

https://loy124.tistory.com/193

https://mchch.tistory.com/140?category=896023

https://bemeal2.tistory.com/44
