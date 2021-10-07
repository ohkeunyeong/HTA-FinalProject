package com.hta.project.domain;

import javax.websocket.Session;

public class Cart {
	private Session session;
	private String id;
	
	public Session getSession() {
		return session;
	}
	
	public void setSession(Session session) {
		this.session = session;
	}
	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {
		this.id = id;
	}

}
