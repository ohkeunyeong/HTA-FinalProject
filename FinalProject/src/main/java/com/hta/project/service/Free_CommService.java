package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Free_Comm;

public interface Free_CommService {


	public int getListCount(int free_num);
	

	public List<Free_Comm> getFree_CommList(int free_num, int page, int state);
	
	public int Free_CommsInsert(Free_Comm co);

	public int Free_CommsDelete(int num);

	public int Free_CommsUpdate(Free_Comm co);


	public int Free_CommsReply(Free_Comm co);
	
	//free_comm_re_seq값 수정
	public int Free_CommsReplyUpdate(Free_Comm co);


	public int Free_comm_ref_select(int free_comm_num);

	public int Free_comm_ref_select2(int select);
	
	public int Free_CommsDelete2(int free_comm_num);

}
