<%@page import="java.util.Date"%>
<%@page import="model.Ticket"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src ="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="js/popper.js"></script>
</head>
<body>
<%
	Ticket ticket =(Ticket)session.getAttribute("ticket");
%>
<script>
	
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
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
                $.post({
        			url : "ticketOk.do"
                });
                location.href="myPage?userid="+'<%=ticket.getUserid()%>'
                
                alert("결제성공");
               <%--  location.href='<%=request.getContextPath()%>/order/paySuccess?msg='+msg; --%>
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
              <%--   location.href="<%=request.getContextPath()%>/order/payFail"; --%>
                alert(msg);
                location.href="movieTicket";
            }
        });
        
    });
    </script>
</body>
</html>