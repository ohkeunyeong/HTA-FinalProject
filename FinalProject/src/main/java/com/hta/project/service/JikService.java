package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Jik;

public interface JikService {
	

	public int getListCount();
	

	public List<Jik> getJikList(int page, int limit);
	

	public Jik getDetail(int num);
	

	public int jikReply(Jik jik);
	

	public int jikModify(Jik modifyjik);
	

	public int jikDelete(int num);
	

	public int setReadCountUpdate(int num);
	

	public boolean isJikWriter(int num, String pass);
	

	public void insertJik(Jik jik);


	public int jikReplyUpdate(Jik jik);

	
}
