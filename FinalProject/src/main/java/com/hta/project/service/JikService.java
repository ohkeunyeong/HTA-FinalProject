package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Jik;

public interface JikService {
	

	public int getListCount();
	
	public List<Jik> getJikList(int page, int limit);
	
	public Jik getDetail(int num,String id);
	
	public int jikModify(Jik modifyjik);
	
	public int jikDelete(int num);
	
	public int setReadCountUpdate(int num);
	
	public void insertJik(Jik jik);

	public int insert_deleteFile(String before_file);

	public Jik getDetail2(int num);

	public List<Jik> getJikListSearchList(int page, int limit, int type, String search);

	public int getSearchListCount(int type, String search);



	
}
