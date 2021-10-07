package com.hta.project.handler;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import com.hta.project.domain.Cart;


@Controller
@ServerEndpoint(value="/echo") // 클라이언트가 접속할 주소
public class EchoHandler {
	
	static final List<Cart> sessionList = 
				Collections.synchronizedList(new ArrayList<Cart>());
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	public EchoHandler() {
		logger.info("웹소켓(서버) 객체생성");
	}
	
	/*
	 * @OnOpen 는 클라이언트가 웹소켓에 들어오고 서버에 아무런 문제 없어
	 * 들어왔을때 실행하는 메서드입니다.
	 * 
	 * 접속자마다 한개의 세션이 생성되어 데이터 통신수단을 사용되며 접속자 마다 구분됩니다.
	 */
	@OnOpen
	public void onOpen2(Session session) {
		logger.info("Open session id : " + session.getId());
		logger.info("session 쿼리 스트링 : " + session.getQueryString());
		
		// id="admin"&filename=/2021-9-23/bbs202192312060952.png
		String queryString = session.getQueryString();
		String id = queryString.substring(queryString.indexOf("=")+1,
										  queryString.indexOf("&"));
		System.out.println(id);
		String nick = queryString.substring(queryString.lastIndexOf("=")+1);
		System.out.println(nick);
		Cart cart = new Cart();
		cart.setSession(session);
		cart.setId(id);
		sessionList.add(cart);
		
		String message = id + "님이 입장하셨습니다.in";
		sendAllSessionToMessage(session, message);
	}
	
	// 보낸 사람 정보(id와 파일이름) 구하기
	private String getinfo(Session self) {
		String infomation = "";
		synchronized (sessionList) {
			for(Cart cart : EchoHandler.sessionList) {
				Session s = cart.getSession();
				if(self.getId().equals(s.getId())) {
					infomation = cart.getId();
					// 보낸 사람의 정보 : 
					logger.info("보낸 사람의 정보 = " + infomation);
					break;
				}
			}
		} // synchronized end
		return infomation;
	}
	
	/*
	 * 현재의 세션으로 부터 도착한 메시지를 나를 제외한 모든 사용자에게 메시지를 전달합니다.
	 */
	private void sendAllSessionToMessage(Session self, String message) {
		String info = getinfo(self);
		
		synchronized (sessionList) {
			try {
				for(Cart cart : EchoHandler.sessionList) {
					Session s = cart.getSession();
					logger.info(self.getId());
					if(!self.getId().equals(s.getId())) {
						logger.info("나를 제외한 모든 사람에게 보내는 메시지 : "
								+ info + "&" + message);
						s.getBasicRemote().sendText(info + "&" + message);
					}
				}
			}catch(Exception e) {
				logger.info("sendAllSessionToMessage 오류 : " + e.getMessage());
			}
		}
	}
	
	/*
	 @OnMessage 는 클라이언트에게 메시지가 들어왔을 떄, 실행되는 메소드입니다.
	*/
	@OnMessage
	public void onMessage2(String message, Session session) {
		logger.info("Message : " + message);
		sendAllSessionToMessage(session, message);
	}
	
	@OnError
	public void onError2(Throwable e, Session session) {
		e.printStackTrace();
		logger.info("error입니다.");
		remove(session);
	}
	
	// @OnClose 는 클라이언트와 웹소켓과의 연결이 끊기면 실행되는 메소드입니다. 
	@OnClose
	public void onClose2(Session session) {
		logger.info("Session " + session.getId() + " has ended");
		remove(session);
	}
	
	private void remove(Session session) {
		synchronized (sessionList) {
			for(int i = 0; i < sessionList.size(); i++) {
				Session s = sessionList.get(i).getSession();
				if(session.getId().equals(s.getId())) { // 나와 세션 아이디가 같은 cart를 제거합니다.
					sessionList.remove(i);
					return;
				}
			}
		}
	}

}
