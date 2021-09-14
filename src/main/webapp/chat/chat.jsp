<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Web Socket Example</title>
</head>
<body>
	<center>
		<form>
			<!-- message input -->
			<input id="textMessage" type="text"> 
			<input onclick="sendMessage()" value="Send" type="button">
			<!-- WebSocket 접속 종료하는 버튼 -->
			<input onclick="disconnect()" value="Disconnect" type="button">
		</form>
		<br />
		<!-- 콘솔 메시지의 역할을 하는 로그 텍스트 에리어.(수신 메시지도 표시한다.) -->
		<textarea id="messageTextArea" rows="10" cols="50"></textarea>
		<script type="text/javascript"> // 함수 형태 
			//자동으로 접속 시작, onopen 함수 호출
			var webSocket = new WebSocket(
					"ws://localhost:8080/BoardSite/websocket");
			var messageTextArea = document.getElementById("messageTextArea");
			// 예외발생
			webSocket.onopen = function(message) {
				messageTextArea.value += "Server connect...\n";
			};
			// WebSocket 서버와 접속이 끊기면 호출되는 함수
			webSocket.onclose = function(message) {
				messageTextArea.value += "Server Disconnect...\n";
			};
			// WebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수
			webSocket.onerror = function(message) {
				messageTextArea.value += "error...\n";
			};
			// WebSocket 서버로 부터 메시지가 오면 호출되는 함수
			webSocket.onmessage = function(message) {
				//콘솔
				messageTextArea.value += "Recieve From Server => "
						+ message.data + "\n";
			};
			//inpy
			function sendMessage() {
				var message = document.getElementById("textMessage");
				messageTextArea.value += "Send to Server => " + message.value
						+ "\n";
				webSocket.send(message.value); //서버에 메시지 송신
				message.value = "";// 송신 메시지를 작성하는 텍스트 박스를 초기화한다.
			}

			//WebSocket 접속 해제
			function disconnect() {
				webSocket.close();
			}
		</script>
	</center>
</body>
</html>
