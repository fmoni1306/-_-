/**
 * 
 */

	var idRe = /^[0-9a-zA-Z]{0,15}$/;
	var nameRe = /^[가-힣]{0,5}$/;
	var hpRe = /^(010|011)\d{3,4}\d{4}$/;
	var mailRe = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
	var UpperReg = /[A-Z]/;
	var LowerReg = /[a-z]/; 
	var numReg = /[0-9]/;
	var charReg = /[!@#$%]/;
	var lengthReg = /^[A-Za-z0-9!@#$%]{8,15}$/;

function eId(val) {
	if(idRe.test(val)){
		document.getElementById('idCheck').innerHTML = "";
	}
	if(!idRe.test(val)){
		document.getElementById('idCheck').style.color = "red";
		document.getElementById('idCheck').innerHTML = "아이디를 확인해주세요";
	}
}

function kName(val) {
	if(nameRe.test(val)){
		document.getElementById('nameCheck').innerHTML = "";
	}
	if(!nameRe.test(val)){
		document.getElementById('nameCheck').style.color = "red";
		document.getElementById('nameCheck').innerHTML = "이름을 확인해주세요";
	}
}
function phoneNumber(val) {
	if(hpRe.test(val)){
		document.getElementById('hpCheck').innerHTML = "";
	}
	if(!hpRe.test(val)){
		document.getElementById('hpCheck').style.color = "red";
		document.getElementById('hpCheck').innerHTML = "연락처를 확인해주세요";
	}
}
function maillength(val) {
	if(mailRe.test(val)){
		document.getElementById('mailCheck').innerHTML = "";
	}
	if(!mailRe.test(val)){
		document.getElementById('mailCheck').style.color = "red";
		document.getElementById('mailCheck').innerHTML = "이메일을 확인해주세요";
	}
}
	



function 전송() {
	if(document.fr.name.value == ""||!(nameRe.test(document.fr.name.value))) {
		alert("이름을 확인해주세요")
		document.fr.name.focus();
		return ;
	} 
	if(document.fr.idChecker.value!="checked"){
		alert("아이디 중복을 확인 해주세요")
		document.fr.dup.focus();
		return;
	}
	if(document.fr.passChecker.value!="checked"){
		alert("비밀번호를 확인 해주세요")
		return;
	}
	
	if(document.fr.id.value == "" ||!(idRe.test(document.fr.id.value))) {
		alert("아이디를 확인해주세요")
		document.fr.id.focus();
		return ;
	}
	if(document.fr.pass.value == "" || !(lengthReg.test(document.fr.pass.value))) {
		alert("비밀번호를 확인해주세요")
		document.fr.pass.focus();
		return ;
	}
	if(document.fr.pass.value.length < 8 || document.fr.pass.value.length > 15) {
		alert("비밀번호는 8~15자리로 입력 해주세요")
		document.fr.pass.focus();
		return ;
	}	
	if(document.fr.pass.value != document.fr.pass2.value){
		alert("비밀번호가 일치 하지 않습니다")
		document.fr.pass.focus();
		return ;
	}
	if(document.fr.mail.value == "" || !(mailRe.test(document.fr.mail.value))) {
		alert("이메일을 확인해주세요")
		document.fr.mail.focus();
		return ;
	}
	if(document.fr.mailChecker.value == "notCheck"){
		alert("이메일인증을 해주세요")
		document.fr.mail.focus();
		return;
	}
	if(isNaN(document.fr.hnumber.value)){
		alert("연락처는 숫자만 입력 가능합니다.")
		return;
	}
	if(document.fr.hnumber.value == "" || !(hpRe.test(document.fr.hnumber.value))) {
		alert("연락처를 확인해주세요")
		document.fr.hnumber.focus();
		return ;
	}
	if(document.fr.postcode.value == "") {
		alert("우편번호를 입력해주세요")
		document.fr.adress.focus();
		return ;
	}
	document.fr.submit();
}

function idCheck() {
	var id = document.fr.id.value
	var idchecker = /^[0-9a-z]{4,15}$/
	if(id.length < 1 || id== null){
		alert("중복 체크할 아이디를 입력해주세요")
		return false;
	}
	if(id.length <4){
		alert("아이디 길이를 확인 해주세요");
		return false;
	}
	if(!idchecker.test(id)){
		alert("아이디를 확인해주세요");
		return false;
	}
		url = "../insert/duplicate.jsp?id="+id
		open(url,"get","height = 200, width = 600");
		document.fr.idChecker.value="checked";
	
			
}
function mailCheck () {
	var mail = document.fr.mail.value
	if(mail.length < 1 || mail == null){
		alert("중복 체크할 이메일을 입력해주세요")
		return false;
	}
	
	if(!mailRe.test(mail)){
		alert("이메일을 형식을 확인해주세요");
		return false;
	}
	
	url = "../insert/mailcheck.jsp?mail="+mail
		open(url,"get","height = 200, width = 600");
//	document.fr.mailChecker.value="checked";
}



function passCheck(val) {
	
	if(val.length <8){
		document.getElementById('passCheck').innerHTML = "8 ~ 15 자리를 입력해주세요";
	}
	
	
	var a = 0;
	
	if(UpperReg.exec(val) !=null ){
		a+=1;
	}
	if(LowerReg.exec(val) !=null) {
		a+=1;
	}
	if(numReg.exec(val) !=null) {
		a+=1;
	}
	if(charReg.exec(val) !=null) {
		a+=1;
	}
	
	
	if(a==0 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 사용불가";
		document.getElementById('passCheck').style.color = "red";
		document.fr.passChecker.value = "notCheck";
	}
	if(a==1 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 미흡";
		document.getElementById('passCheck').style.color ="red";
		document.fr.passChecker.value = "checked";
	}
	if(a==2 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 보통";
		document.getElementById('passCheck').style.color ="orange";
		document.fr.passChecker.value = "checked";
	}
	if(a==3 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 높음";
		document.getElementById('passCheck').style.color ="blue";
		document.fr.passChecker.value = "checked";
	}
	if(a==4 && val.length> 7){
		document.getElementById('passCheck').innerHTML = "보안 : 매우높음";
		document.getElementById('passCheck').style.color ="green";
		document.fr.passChecker.value = "checked";
	}
}

function idNotCheck() {
	document.fr.idChecker.value = "notCheck"
}
function mailNotCheck() {
	document.fr.mailChecker.value = "notCheck"
}




//function passCheck() { // 버튼을통해 Dao를 사용해서 비밀번호 체크
//	var pass =document.fr.pass.value
//	if(pass <1 || pass == null){
//		alert("비밀번호를 입력해주세요");
//		return;
//	}
//	var url = "passCheck.jsp?pass="+pass
//			open(url,"post","left=screen.width","top=screen.height","height = 10, width = 10")
		
//			document.fr.passChecker.value ="checked";
		
//}

//function passNotCheck() {
//	document.fr.passChecker.value = "notCheck"
//}

