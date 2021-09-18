<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Web Socket Example</title>
</head>
<body>
	<form>
		<input id="user" type="text" value="anonymous"> <!-- 유저명 박스 -->
		<input id="textMessage" type="text"> <!-- 메시지 박스 -->
		<input onclick="sendMessage()" value="Send" type="button"> <!-- 메시지 송신버튼 -->
		<input onclick="disconnect()" value="Disconnect" type="button"> <!-- 종료버튼 -->
	</form>
	<br />
	<!-- 콘솔 메시지의 역할을 하는 로그 텍스트 에리어.(수신 메시지도 표시한다.) -->
	<textarea id="messageTextArea" rows="10" cols="50"></textarea>
	<script type="text/javascript">
	// 콘솔 텍스트에 메시지를 출력한다.
	
		// 「broadsocket」는 호스트 명
		// WebSocket 오브젝트 생성 , 자동 onopen 접속
		var webSocket = new WebSocket(
		"ws://localhost:8080/BoardSite/broadsocket");
		// 콘솔 텍스트 에리어 오브젝트
		var messageTextArea = document.getElementById("messageTextArea");
		// WebSocket 서버와 접속이 되면 호출되는 함수
		webSocket.onopen = function(message) {
			messageTextArea.value += "서버와 연결이 완료 되었습니다.\n";
		};
		// WebSocket 서버와 접속이 끊기면 호출되는 함수
		webSocket.onclose = function(message) {
			messageTextArea.value += "서버와 연결이 중단되었습니다.\n";
		};
		// WebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수
		webSocket.onerror = function(message) {
			messageTextArea.value += "error...\n";
		};
		/// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
		webSocket.onmessage = function(message) {
			messageTextArea.value += message.data + "\n";
		};
		// Send 버튼을 누르면 호출되는 함수
		function sendMessage() {
			// 유저명 텍스트 박스 오브젝트를 취득
			var user = document.getElementById("user");
			// 송신 메시지를 작성하는 텍스트 박스 오브젝트를 취득
			var message = document.getElementById("textMessage");
			messageTextArea.value += user.value + "(me) => " + message.value
					+ "\n";
			// WebSocket 서버에 메시지를 전송(형식 「{{유저명}}메시지」)
			webSocket.send("[" + user.value + "]" + message.value);
			// 송신 메시지를 작성한 텍스트 박스를 초기화
			message.value = "";
		}
		// WebSocket 접속 해제
		function disconnect() {
			webSocket.close();
		}
	</script>
</body>
</html>