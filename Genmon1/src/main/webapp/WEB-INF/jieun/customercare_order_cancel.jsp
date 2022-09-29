<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="customerService.jsp" />
<style>
	div.Qbody{
		width: 100%;
		font-family: "Unica77LLWeb","SDGothicNeo", sans-serif;
	}
	div.Qtitle>span, div.Qtitle>ul>li{
		font-weight: lighter;
		font-size: 10pt;
	}
	a.btn{
		background-color: #000; 
		color: white; 
		font-size: 11pt; 
		width: 215px;
		text-align: center;
		margin: 30.5px 5px 0 0;
    	height: 40px;
    	border: solid 1px #000;
    	border-radius: 0;
	}
	.divider {
	    border-bottom: #e0e0e0 1px solid;
	    width: 100%;
	}
	.margin_b50 {
   	 	margin-bottom: 50px;
	}
	.margin_b200 {
   	 	margin-bottom: 200px;
	}
	.margin_t50 {
   	 	margin-top: 50px;
	}
	.box_content {
	    width: 100%;
	    margin-left: auto;
	    display: inline-block;
	    text-align: left;
	    margin-top:60px;
	    margin-bottom: 200px;
	}
	h2.title{
		font-size: 13pt;
		margin-bottom: 30.5px;
	}
	span {
		font-size: 11pt;
	}
@media screen and (max-width: 767px) { .divider {width: 100%;}}
	
</style>
		<!-- 배송탭 -->
			<div class="box_content col-md-8" >
            <div class="contents">
            <h2 class="title">주문 취소<br></h2>
            <div>
            	<div>주문 취소 및 변경</div>
                   	<span>• ‘주문 접수’ 및 ‘결제 완료’ 단계: [회원정보>주문>주문상세] 에서 취소 가능합니다.</span><br>
					<span>• ‘주문 접수’ 이후: 주문 변경이 불가하며, 취소 후 재 주문 부탁드립니다.</span><br>
					<span>• ‘배송 준비중’ 이후 단계: 주문 취소가 불가하며, 제품 수령 후 '반품' 으로 진행 부탁드립니다.</span><br>
					<span>• 선물하기의 경우 3일 이내 배송지 정보를 입력하지 않을 경우 자동 취소됩니다.</span>
                </div>
                    <div class="divider margin_b50 margin_t50"></div>
            </div>
            </div>
            </div>

<%-- 인덱스 끝 --%>

<jsp:include page="../common/footer.jsp" />