<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		String email = request.getParameter("email");

		System.out.println(email);
		System.out.println("test");
	%>

	<form name="hiddenNaver" action="../naverjoin.do" method="post">
		<input type="hidden" name="email" value=<%=email%>>
	</form>

	<script type="text/javascript">
		document.hiddenNaver.submit();
	</script>
</body>
</html>