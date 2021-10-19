package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Jik;
import com.hta.project.domain.Jik_File;

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

	public int isLike(String id, int num);

	public int like(int num, String id);

	public int dlike(int num, String id);

	public void LikeUp(int num);

	public void LikeDown(int num);

	public void insert_JikFile(int jik_num, String originalFileName, String savedFileName);

	public List<Jik_File> getFile(int num);

	public List<Jik> getMainjikList(int page, int limit);



	
}
