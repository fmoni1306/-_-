<%@page import="java.util.regex.Pattern"%>
<%@page import="resMember.resDAO"%>
<%@page import="resMember.resDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="../js/Insert.js">
</script>
<link href="../css/main.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>

	<div id="wrap">
		<jsp:include page="../main/top.jsp"></jsp:include>


<fieldset style="text-align: left;">
<form class="form" action="insertPro.jsp" method="post" name="fr">
<div class ="form_group">		
<label>이름</label><br>
<input type="text" name="name" maxlength="5" onkeydown="kName(this.value)">
<div class = "check_font" id="nameCheck"></div>
</div>				
<label>생년월일</label><br> 
<input type="date" name="birth" value="1990-01-01"> <!-- 날짜 계산해서 유효한 값 넣는거 검사 --> 
<div class ="form_group">
<label> 성별</label><br>
<input type="radio" name = "gender" value="man"> 남자
<input type="radio" name = "gender" value="woman"> 여자
</div>
<div class ="form_group">
<label>아이디<br></label>
<input type="text" name="id" maxlength="15" onkeydown="eId(this.value)"
onkeydown="idNotCheck()" placeholder="4~15자리 아이디">
<input type="button" name="dup" value="아이디 중복확인" onclick="idCheck()">
<div class = "check_font"  id="idCheck"> </div>
<input type="hidden" name="idChecker" value="notCheck">
</div>
<div class ="form_group">
<label>비밀번호</label><br>
<input type="password" name="pass" maxlength="15" onkeydown="passCheck(this.value)" placeholder="8~15자리 입력" style="ime-mode: disable;">
<div class ="check_font" id="passCheck"></div>
</div>
<div class ="form_group">
<label>비밀번호 확인<br></label>
<input type="password" name="pass2" maxlength="15"> <br>
<!-- <input type="button" name="pChecker" value="비밀번호확인" onclick="passCheck()"><br>  -->
<input type="hidden" name="passChecker" value="notCheck">
</div>
<div class ="form_group">
<label>이메일</label> <br>
<input type="email" name="mail" onkeydown="maillength(this.value)">
<input type="button" name="dup" value="이메일 중복확인" onclick="mailCheck()">
<input type="hidden" name="mailChecker" value="notCheck" onkeydown="mailNotCheck()">
<div class = "check_font" id="mailCheck"></div>
</div>
<div class ="form_group">
<label>연락처 ("-" 없이 번호만 입력해주세요)</label> <br>
<input type="tel" name="hnumber" maxlength="11" onkeydown="phoneNumber(this.value)">
<div class = "check_font" id="hpCheck"></div><br>
</div>
<label>주소</label><br>
		<input type="text" id="postcode" placeholder="우편번호" name="postcode" readonly> 
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="address" placeholder="주소" name="address" ><br> 
		<input type="text" id="extraAddress" placeholder="참고항목" name="extraAddress"> 
		<input type="text" id="detailAddress" placeholder="상세주소" name="detailAddress">
		<script
			src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                    addr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script> <br> <br>
		<input type="button" value="회원가입" onclick="전송()"> <input type="button" value="취소" onclick="location.href='../main/home.jsp'">
	</form>
</fieldset>
</div>

<jsp:include page="../main/bottom.jsp"></jsp:include>
</body>
</html>