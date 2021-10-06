package com.hta.project.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
 
public class EchoHandler extends TextWebSocketHandler {
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionEstablished : " + session);
		sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session);
		System.out.println("afterConnectionEstablished : " + session + " userID : " + userSessions.keySet());
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage : " + session + " : " + message);
		String senderId = getId(session);
//		for(WebSocketSession sess : sessions) {
//			sess.sendMessage(new TextMessage(senderId + ": " + message.getPayload()));
//		}
		
		// protocol : cmd,작성자,게시글작성자 (ex : reply,admin,ajaxk,234)
		String msg = message.getPayload();
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 4) {
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				String bno = strs[3];
				
				// 온라인 일때
				WebSocketSession boardWriterSession = userSessions.get(boardWriter);
				if(cmd.equals("reply") && boardWriterSession != null) {
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이 " + bno + "번 게시글에 댓글을 달았습니다!");
					boardWriterSession.sendMessage(tmpMsg);
				}
			}
		}
	}

	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String nick = (String)httpSession.get("nick");
		if(nick == null) {
			return session.getId();
		}else {
			return nick;
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectionClosed : " + session + " : " + status);
	}
    
}