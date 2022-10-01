<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<jsp:include page="orderHeader.jsp" />
<style>
    


    .small_font{
        font-size: 9pt;
    }

    span.span_click:hover{
        color: rgb(117, 117, 117);
        cursor: pointer;
    }
    
	span.boldtxt{
		display: block;
		font-weight: bold;
		font-size: 11pt;
	}
	
	span.puretxt{
		display: block;
		font-size: 10pt;
		margin-bottom: 6px;
	}
	
	span.error{
		display: block;
		font-size: 10pt;
		margin-bottom: 15px;
		color:red;
	}
	
	/*
	span.nm{
		font-size: 10pt;
		margin-bottom: 6px;
	} */
	
	
	
	input.input_style{
		margin-bottom: 20px;
		width: 100%;
		height: 40px;
		border: 1px solid black;
		font-size: 10pt;
		text-indent: 10px;
	}
	
	button.button1{
		cursor: pointer;
		width: 110px;
		height: 40px;
		margin-left: 5px;
		background-color: black;
		color: white;
		font-size: 10pt;
	}
	
	button.button2{
		cursor: pointer;
		width: 245px;
		height: 40px;
		border: 1px solid black;
		background-color: white;
		color: black;
		font-size: 10pt;
	}
	
	div#box1{
		display:inline-block;
		width: 500px;
		margin-left: 37%;
	}
	
	div#box2{
		display:inline-block;
		width: 350px;
		margin-left: 10%;
	}
	
	/* 반응형 */
    @media (max-width: 1659px) {
    	div#box1{
    		display:block;
    		margin-left: auto;
    		margin-right: auto;
    	}
        div#box2{
        	display:block;
        	width: 500px;
        	margin: 100px auto 150px auto;
        }
    }
    
    table {
		width: 100%;
		font-size: 10pt;
	}
	
	.myleft{
		text-align: left;
	}
	
	.myright{
		text-align: right;
	}
	
	tr > td:first-child {
		width: 90px;
	}
	
	img{
		width: 80px;
		height: 100px;
	}
	
	tr.empty_tr{
		height: 70px;
	}
	
	tr.height_tr{
		height: 30px;
	}
	
	tr.top_line{
		border-top: 1px solid gray;
	}
	
</style>
<!-- Optional JavaScript -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	$(document).ready(function(){
	
	    
	    // 이전단계로 클릭이벤트 
	    $("button#prev").click(function(){
	    	history.back();
	    });
	    
	    $("span.error").hide();
	    $("a#2_add").css('color','black');
	    
	    
	    // 배송주소 사용 클릭 이벤트
	    $("input#useAdd").click(function(){
	    	console.log("${requestScope.email}");
	    	
	    	if($("input#useAdd").prop("checked")==true){  // 모두 값 넣어주기 
	    		
	    		$("input#email").val("${requestScope.email}");
	    		$("input#name").val("${name}");
	    		$("input#mobile").val("${mobile}");
	    		$("input#postcode").val("${postcode}");
	    		$("input#address").val("${address}");
	    		$("input#detailAddress").val("${detailAddress}");
	    		$("input#extraAddress").val("${extraAddress}");
	    		
	    	} else {// 이미 선택 상태라면 모두 지워주기
	    		
	    		$("input#email").val('');
	    		$("input#name").val('');
	    		$("input#mobile").val('');
	    		$("input#postcode").val('');
	    		$("input#address").val('');
	    		$("input#detailAddress").val('');
	    		$("input#extraAddress").val('');
	    		
	    								
	    	}
	    	
	    }); // end of 배송주소 사용 클릭 이벤트
	    
	    
	    // 이메일 블러 이벤트
	    $("input#email").blur((e)=>{
	    	
			const $target = $(e.target);
			// 정규표현식으로 한번 걸러줄거임
			// const reqExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			// 또는
			const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
			// 숫자 문자 특수문자를 포함한 형태의 8~15글자 의 암호 정규표현식 객체를 만든거임
			
			const bool = regExp.test($target.val()); // 정규 표현식에 값을 집어넣음
			
			if(bool){ // 정규 표현식에 맞는 경우
				$target.focus();
				$target.val('');
				
				$target.next().show();
				
			} else { // 정규 표현식에 틀린 경우
				$target.next().hide();
			}
		}); // end of 이메일 blur 이벤트
	    
	    
	    // 이름 인풋 블러이벤트 
	    $("input#name").blur((e)=>{
			const $target = $(e.target);
			const name = $target.val().trim();
			
			if(name == ""){ 
				$target.focus();
				$target.val('');
				
				$target.next().show();
				
			} else { // 글자를 입력은 한경우 
				$target.next().hide();
			}
		}); // end of 이름 blur 이벤트
	    
	    
	    
	    // 배송 주소 검사 주소 입력 창클릭하면 검색이 눌리도록 하기
	    // 우편번호 안들어와 있으면 누르게 시키기
	    
	    
	 	// 다음 단계로 클릭이벤트
	    $("button#next").click(function(){
	    	
	    	let b_Flag_requiredInfo = false;
			let_b_Flag_postCode = false;
			
			$("input.requiredInfo").each((index, item)=>{
				const data = $(item).val().trim();
				if(data ==""){
					alert("모든 항목을 전부 입력하셔야 합니다");
					b_Flag_requiredInfo = true;
					return false; // each 문을 break;
				}
			}); // end of each
			
			$("input.hiddenInfo").each((index, item)=>{
				const data = $(item).val().trim();
				if(data ==""){
					alert("배송지는 검색버튼을 클릭하여 입력하셔야 합니다");
					b_Flag_requiredInfo = true;
					return false; // each 문을 break;
				}
			}); // end of each
			
			
			if(b_Flag_requiredInfo){
				return; // 이 함수를 끝낸다
			}
			
			if(let_b_Flag_postCode){
				return; // 이 함수를 끝낸다
			}
	    	
	    	// 다음 페이지로~~~
	    	location.href = "<%=ctxPath%>/order/payInfo.sun";
	    	
	    });// end of 다음단계로 클릭 이벤트
	    
	}); // end of ready 
	
	
	function openDaumPOST(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            let addr = ''; // 주소 변수
	            let extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("extraAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("extraAddress").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('postcode').value = data.zonecode;
	            document.getElementById("address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailAddress").focus();
	        }
	    }).open();
	} // end of openDaumPOST()
</script>


	<div class="container-fluid" style="margin-top:120px; margin-bottom:120px;">
	<div id="box1" >
		<form name="frmDeliveryInfo">
			<c:if test="${not empty sessionScope.loginuser }">
				<span class="boldtxt mb-4">배송지정보</span>
			</c:if>
			<c:if test="${empty sessionScope.loginuser }">
				<span class="boldtxt mb-4">비회원 배송지 입력하기</span>
			</c:if>
			
			<span class="puretxt mb-1"> 빈칸 없이 모두 입력해주십시오. </span>
			<c:if test="${ not empty sessionScope.loginuser }">
				<label class="link_tag"><input type="checkbox" id="useAdd" class="mr-2 "/>회원정보와 동일한 배송주소 사용하기</label>
			</c:if>
			<span class="puretxt mt-4">이메일</span>
			<input type="text" name="email" id="email" class="input_style requiredInfo" autofocus placeholder="이메일"/>
			<span class="error">입력하신 이메일이 형식에 맞지 않습니다</span>
			
			<span class="puretxt">이름</span>
			<input type="text" name="name" id="name" class="input_style requiredInfo" placeholder="이름"/>
			<span class="error">이름은 공백으로 입력 불가능 합니다</span>
			
			<span class="puretxt">전화번호</span>
			<input type="text" name="mobile" id="mobile" class="input_style requiredInfo" placeholder="전화번호"/>
			<span class="error">은 공백으로 입력 불가능 합니다</span>
			
			<%-- 배송지 시작 --%>
			<span class="puretxt">배송지검색</span>
			<input type="hidden" id="postcode" name="postcode" class="hiddenInfo"/>
			
			<input type="text" id="address" name="address" class="input_style requiredInfo" placeholder="주소" style="display: inline-block; width: 380px;"/>
			<button type="button" class="button1" onclick="openDaumPOST();">검색</button>
			<span class="puretxt">상세주소</span>
			<input type="text" id="detailAddress" name="detailAddress" class="input_style requiredInfo"  placeholder="상세주소" />
			<span class="error">은 공백으로 입력 불가능 합니다</span>
			<input type="hidden" id="extraAddress" name="extraAddress"  class="hiddenInfo"/>
			<%-- 배송지 끝 --%>
			<br><br>
			<button type="button" id="prev" class="button2">이전 단계로</button>
			<button type="button" id="next" class="button1" style="width: 245px;">다음 단계로</button>
		</form>
	</div>
	<div id="box2">
		<table>
			<thead>
				<tr>
					<td style="font-weight: bold;">주문내역</td>
					<td colspan="2" class="myright"><strong><a href="<%= ctxPath%>/order/cart.sun" class="link_tag">수정</a></strong></td>
				</tr>
				<tr style="height: 50px;">
					<td> 상품</td>
					<td colspan="2" class="myright">가격</td>
				</tr>
			</thead>
			<tbody>
				<%-- 반복시작 --%>
				<tr>
					<td rowspan="3" style="vertical-align: top; text-align: center;"><img src="<%= ctxPath %>/images/sun_img.png"></td>
					<td style="font-weight: bold;">상품명</td>
					<td class="myright">상품가격</td>
				</tr>
				<tr>
					<td>수량:1</td>
					<td class="myright">37826원</td>
				</tr>
				<tr class="empty_tr">
					<td colspan="3" class="empty_td"></td>
				</tr>
				<%-- 반복끝 --%>
				<tr>
					<td rowspan="3" style="vertical-align: top; text-align: center;"><img src="<%= ctxPath%>/images/sun_img.png"></td>
					<td style="font-weight: bold;">상품명</td>
					<td class="myright">상품가격</td>
				</tr>
				<tr>
					<td>수량:1</td>
					<td class="myright">37826원</td>
				</tr>
				<tr class="empty_tr">
					<td colspan="3" class="empty_td"></td>
				</tr>
				<tr>
					<td rowspan="3" style="vertical-align: top; text-align: center;"><img src="<%= ctxPath%>/images/sun_img.png"></td>
					<td style="font-weight: bold;">상품명</td>
					<td class="myright">상품가격</td>
				</tr>
				<tr>
					<td>수량:1</td>
					<td class="myright">37826원</td>
				</tr>
				<tr class="empty_tr">
					<td colspan="3"></td>
				</tr>
				<%-- 반복끝 --%>
			</tbody>
			<tfoot>
				<tr class="height_tr top_line">
					<td>상품합계</td>
					<td colspan="2" class="myright">37826원</td>
				</tr>
				<tr class="height_tr">
					<td>배송비</td>
					<td colspan="2" class="myright">0원</td>
				</tr>
				<tr style="height: 50px;" class="top_line">
					<td>총합계</td>
					<td>수량:10</td>
					<td class="myright">37826원</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
	
<jsp:include page="../common/footer.jsp" />