package com.hta.project.domain;

public class Message {
	private String user;
	private String to;
	private String articleId;
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getArticleId() {
		return articleId;
	}
	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}
	public String getArticleOwner() {
		return articleOwner;
	}
	public void setArticleOwner(String articleOwner) {
		this.articleOwner = articleOwner;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	private String articleOwner;
	private String message;

}
