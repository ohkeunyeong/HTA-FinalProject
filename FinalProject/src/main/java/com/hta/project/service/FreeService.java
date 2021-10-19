package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Free;
import com.hta.project.domain.Free_File;

public interface FreeService {
	

	public int getListCount();
	
	public List<Free> getFreeList(int page, int limit);
	
	public Free getDetail(int num,String id);
	
	public int FreeModify(Free modifyfree);
	
	public int FreeDelete(int num);
	
	public int setReadCountUpdate(int num);
	
	public void insertFree(Free free);

	public int insert_deleteFile(String before_file);

	public Free getDetail2(int num);

	public List<Free> getFreeListSearchList(int page, int limit, int type, String search);

	public int getSearchListCount(int type, String search);

	public int isLike(String id, int num);

	public int like(int num, String id);

	public int dlike(int num, String id);

	public void LikeUp(int num);

	public void LikeDown(int num);

	public void insert_FreeFile(int free_num, String originalFileName, String savedFileName);

	public List<Free_File> getFile(int num);

	public List<Free> getMainfreeList(int page, int limit);



	
}
