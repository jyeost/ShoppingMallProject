<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
    
<jsp:include page="../common/adminSidebar.jsp" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<link rel="stylesheet" href="../css/bootstrap-datepicker.css" type="text/css">
<link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css">
<!-- Style -->
  <link rel="stylesheet" href="../css/style.css">
<style>
.form-outline {
    position: relative;
}
.form-outline .form-control~.form-label {
    /* position: absolute; */
    top: 0;
    max-width: 90%;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    left: 0.75rem;
    padding-top: 0.37rem;
    pointer-events: none;
    transform-origin: 0 0;
    transition: all .2s ease-out;
    color: rgba(0,0,0,.6);
    margin-bottom: 0;
}
.form-outline .form-control~.form-notch {
    display: flex;
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    max-width: 100%;
    height: 100%;
    text-align: left;
    pointer-events: none;
}
.btn-group-sm>.btn, .btn-sm {
	padding: -.3125rem 1rem -.3125rem;
    line-height: 1.5;
}



.custom-table tbody tr.active {
    opacity: .4;
}


.nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
    color: #495057;
    background-color: transparent; 
    border-color: transparent transparent #6eacef transparent;
	border-bottom-width: 2px;
}
a.nav-link{
 color: #495057;
}
.nav {
	padding-left: 100px;
}


/* 테이블 */
    
.custom-table thead tr, .custom-table thead th {
border-top: none;
border-bottom: none!important;
}
.table thead tr th {
    /* vertical-align: bottom; */
    border-bottom: 2px solid #dee2e6;
    font-weight: normal;
    color:#161616;
}
.control {
    display: block;
    position: relative;
    margin-bottom: 25px;
    cursor: pointer;
    font-size: 18px;
}
.custom-table tbody tr th:last-child, .custom-table tbody tr td:last-child {
    border-top-right-radius: 7px;
    border-bottom-right-radius: 7px;
}
.custom-table tbody tr th:first-child, .custom-table tbody tr td:first-child {
    border-top-left-radius: 7px;
    border-bottom-left-radius: 7px;
}
.custom-table tbody tr th, .custom-table tbody tr td {
    background-color: #fff;
    border: none;
}

.custom-table tbody th, .custom-table tbody td {
    color: #777;
     font-weight: 400; 
    padding-bottom: 20px;
    padding-top: 20px;
    /* font-weight: 300; */
}
.custom-table tbody td small, .custom-table tbody tr td:nth-child(5), .custom-table tbody tr td:nth-child(2), .custom-table tbody tr td:nth-child(3){
	color: #777;
    /* font-weight: 400; */
	/* font-weight: 300; */
}
.custom-table tbody td a{
	color: #777;
}
.custom-table tbody tr.spacer td {
    padding: 0 !important;
    height: 10px;
    border-radius: 0 !important;
    background: transparent !important;
}
.control input {
    position: absolute;
    z-index: -1;
    opacity: 0;
}
.control--checkbox .control__indicator:after {
    top: 50%;
    left: 50%;
    -webkit-transform: translate(-50%, -52%);
    -ms-transform: translate(-50%, -52%);
    transform: translate(-50%, -52%);
}
.control__indicator:after {
    font-family: 'icomoon';
    content: '\e5ca';
    position: absolute;
    display: none;
}
.control input:checked ~ .control__indicator {
    border: 2px solid #007bff;
    background: #007bff;
}
.control__indicator {
    position: absolute;
    top: 7px;
    left: 0;
    height: 15px;
    width: 15px;
    border-radius: 3px;
    border: 2px solid #ccc;
    background: transparent;
}
.custom-table tbody tr th:before, .custom-table tbody tr th:after, .custom-table tbody tr td:before, .custom-table tbody tr td:after {
    -webkit-transition: .3s all ease;
    -o-transition: .3s all ease;
    transition: .3s all ease;
    content: "";
    left: 0;
    right: 0;
    position: absolute;
    height: 1px;
    background: #007bff;
    width: 100%;
    opacity: 0;
    visibility: hidden;
}
/* 테이블 끝*/

p{
	font-weight: 350;
}
th{
	font-weight: 300;
}
thover{
    background-color: #f4f4f4;
    border: none;
    cursor: pointer;
}
.table td > p {
    padding-top: 0;
    margin: auto;
}
</style>
<script src="../js/jquery-3.6.0.min.js" type="text/javascript"></script>
<script src="../js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script src="../js/bootstrap-datepicker.js" type="text/javascript"></script>
<script  type="text/javascript">
$(document).ready(function () {
	
	/* 행호버효과 */
	$("tr[scope='row']>td").hover(function() {
		/* $(this).addclass('thover'); */
		$(this).css('background-color','transparent');
		$(this).siblings().css('background-color','transparent');
	},function(){
		$(this).css('background-color','#fff');
		$(this).siblings().css('background-color','#fff');
	});
	
 	$("tr[scope='row']").click(function() {
 		goAnswerForm();
	});
 	/* 행호버효과 */
 	
 	
 	
 	
 	// 문서가 로딩되자마자 전체 목록이 보여져야 하므로 
 	displayTypeTab("전체");
 	
 	
 	// ----탭분류를 클릭했을때----- 
 	$("a.nav-link").click(function(){
 		$("tbody#contactList").html("");
 		const ctype = $(this).text();
 		alert(ctype);
 		// 목록불러오는 함수 
 		displayTypeTab(ctype);
 	});
 	// ----탭분류를 클릭했을때----- 
 	
 	
 	
	
});



	// === 답변폼창 나오기 === //
	function goAnswerForm(){
		
		// 나의 정ㅂ 수정하기 팝업창 띄우기
		const url = "<%= request.getContextPath()%>/jieun/manager_answerFrm.jsp";
		
		// 너비 800, 높이 600 인 팝업창을 화면 가운데 위치시키기
		const pop_width = 800;
		const pop_height = 600;
		const pop_left = Math.ceil((window.screen.width - pop_width)/2); /* 정수로만듦 */
		const pop_top = Math.ceil((window.screen.height - pop_height)/2);/* 정수로만듦 */
		
						// 팝업창이름(아무것도안써도상관없음)
		window.open(url, "goAnswerForm",
				    "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
						
	}// end of function goEditPersonal(){}
	
	
	
	// 선택한 탭에 따른 다른 타입 나오기 
	function displayTypeTab(ctype){
		$.ajax({
			url:"<%= request.getContextPath()%>/admin/contactDisplayJSON.sun",
			data:{"ctype":ctype
			},
			dataType:"JSON",
			success:function(json){
//				console.log(json);
// 				console.log(typeof json); // object     ** json의 타입은 object(객체)모양임 
				let html = "";
				if(json.length == 0){// 글이 없는경우.
					// !!! 주의 !!!
	                // if(json == null) 이 아님!!!
	                // if(json.length == 0) 으로 해야함!!
					html += "등록된 문의글이 없습니다.";
				
					// $("div#displayHIT").html(html);
				}
				else if( json.length > 0 ){ // 데이터가 존재하는 경우  
					
					$.each(json, function(index, item){  // each 는 파라미터가 2개 ( index, item )
						
						html += '<tr scope="row" class="hover">'+
									'<th scope="row">'+
										'<label class="control control--checkbox">'+
											'<input type="checkbox">'+
											'<div class="control__indicator"><i class="fa fa-check" style="color:#fff; font-size: 8pt; display: block;"></i></div>'+
										'</label>'+
									'</th>'+
									'<td>'+item.contactid+'</td>'+
									'<td>'+
										'<p class="fw-bold mb-1">'+item.fk_userid+'</p>'+
										'<p class="text-muted mb-0">'+item.email+'</p>'+
									'</td>'+
									'<td>'+
										'<p class="fw-normal mb-1">'+item.ctype+'문의</p>'+
										'<p class="text-muted mb-0">'+item.contents+'</p>'+
									'</td>'+
									'<td>'+item.cregisterday+'</td>'+
									'<td>&nbsp;<p href="#" style="display: inline-block"><i class="fas fa-envelope-square"></i></p>&nbsp;&nbsp;'+
										'<a href="#" style="display: inline-block; color: #dc3545;"><i class="fas fa fa-close"></i></a></td>'+
								'</tr>'+
								'<tr class="spacer"><td colspan="100"></td></tr>';
								
					});// end of $.each -------------------------
				
					$("tbody#contactList").html(html); 
					
					
				}				
				
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
			
			
		});
		
	} 
	
	
	
</script>
<%-- 인덱스 시작 --%>



 <body style="background: #f4f4f4;">   
<section class="py-4 px-2 " style="width:90%; margin:0 auto; ">
 
 &nbsp;&nbsp; <h3 style="color:#404040; font-size: 16pt; font-weight: bolder; margin: 0 0 3% 10%;">Contact</h3> 
<!-- Tabs navs -->
<ul class="nav nav-tabs mb-5" id="ex1" role="tablist" style="margin:auto;">
  <li class="nav-item" role="presentation">
    <a
      class="nav-link active"
      id="ex1-tab-1"
      data-mdb-toggle="tab"
      href="#ex1-tabs-1"
      role="tab"
      aria-controls="ex1-tabs-1"
      aria-selected="true"
      >전체</a>
  </li>
  <li class="nav-item" role="presentation">
    <a
      class="nav-link"
      id="ex1-tab-2"
      data-mdb-toggle="tab"
      href="#ex1-tabs-2"
      role="tab"
      aria-controls="ex1-tabs-2"
      aria-selected="false"
      >상품</a
    >
  </li>
  <li class="nav-item" role="presentation">
    <a
      class="nav-link"
      id="ex1-tab-3"
      data-mdb-toggle="tab"
      href="#ex1-tabs-3"
      role="tab"
      aria-controls ="ex1-tabs-3"
      aria-selected="false"
      >배송</a
    >
  </li>
  <li class="nav-item" role="presentation">
    <a
      class="nav-link"
      id="ex1-tab-4"
      data-mdb-toggle="tab"
      href="#ex1-tabs-4"
      role="tab"
      aria-controls="ex1-tabs-4"
      aria-selected="false"
      >교환/반품</a
    >
  </li>
  <li class="nav-item" role="presentation">
    <a
      class="nav-link"
      id="ex1-tab-5"
      data-mdb-toggle="tab"
      href="#ex1-tabs-5"
      role="tab"
      aria-controls="ex1-tabs-5"
      aria-selected="false"
      >기타</a
    >
  </li>
</ul>
<!-- Tabs navs -->

<!-- Tabs content -->
<div class="tab-content" id="ex1-content">
  <div
    class="tab-pane fade show active"
    id="ex1-tabs-1"
    role="tabpanel"
    aria-labelledby="ex1-tab-1"
  >
    <!-- 전체문의 -->
  </div>
  <div class="tab-pane fade" id="ex1-tabs-2" role="tabpanel" aria-labelledby="ex1-tab-2">
    <!-- 상품문의 -->
  </div>
  <div class="tab-pane fade" id="ex1-tabs-3" role="tabpanel" aria-labelledby="ex1-tab-3">
    <!-- 배송문의 -->
  </div>
  <div class="tab-pane fade" id="ex1-tabs-3" role="tabpanel" aria-labelledby="ex1-tab-4">
    <!-- 교환/환불문의 -->
  </div>
  <div class="tab-pane fade" id="ex1-tabs-3" role="tabpanel" aria-labelledby="ex1-tab-5">
    <!-- 기타문의 -->
  </div>
</div> 
<!-- Tabs content -->




    
    <!-- 테이블필터 -->

    <div class="table-responsive custom-table-responsive" style="width:80%; margin:auto;">
    	<!-- <h3 style="color:#212121; font-size: 15pt; font-weight: normal;">Q&A</h3> -->
	    	<div class="input-group mb-4">
			  <input type="text" class="form-control" id="advanced-search-input" placeholder="검색하고 싶은 회원의 전화번호,이메일,이름을 입력해주세요." />
			  <button class="btn btn-primary" id="advanced-search-button" type="button" style="border:none; background-color: #45494c">
			    <i class="fa fa-search"></i>
			  </button>
			</div>

		<table class="table custom-table ">
		<thead>
			<tr style="overflow: hidden; color:#212121;" class="fixed">
				<th scope="col">
				<label class="control control--checkbox">
					<input type="checkbox" class="js-check-all">
					<div class="control__indicator"><i class="fa fa-check" style="color:#f4f4f4; font-size: 8pt; display: block;"></i></div>
				</label>
				</th>
				<th scope="col">no</th>
				<th scope="col">Name</th>
				<th scope="col">Contents</th>
				<th scope="col">Date</th>
				<th scope="col"></th>
			</tr>
		</thead>
		<tbody id="contactList">
		
		
		<tr scope="row" class="hover">
			<th scope="row">
			<label class="control control--checkbox">
				<input type="checkbox">
				<div class="control__indicator"><i class="fa fa-check" style="color:#fff; font-size: 8pt; display: block;"></i></div>
			</label>
			</th>
			<td>1392</td>
			<td>
			 <p class="fw-bold mb-1">John Doe</p>
             <p class="text-muted mb-0">john.doe@gmail.com</p>
			</td>
			<td>
				<p class="fw-normal mb-1">배송문의</p>
        		<p class="text-muted mb-0">배송 언제시작할까요?</p>
			</td>
			<td>2022.09.20 18:09:34</td>
			<td>&nbsp;<p href="#" style="display: inline-block"><i class="fas fa-envelope-square"></i></p>&nbsp;&nbsp;<a href="#" style="display: inline-block; color: #dc3545;"><i class="fas fa fa-close"></i></a></td>
		</tr>
		
		<tr class="spacer"><td colspan="100"></td></tr>
		
		
		</tbody>
		</table>
</div>
</section>



  
</body>

<%-- 인덱스 끝 --%>

