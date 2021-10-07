package com.hta.project.service;

import java.util.List;

import com.hta.project.domain.Jik_Comm;

public interface Jik_CommService {


	public int getListCount(int jik_num);
	

	public List<Jik_Comm> getJik_CommList(int jik_num, int page, int state);
	
	public int Jik_CommsInsert(Jik_Comm co);

	public int Jik_CommsDelete(int num);

	public int Jik_CommsUpdate(Jik_Comm co);


	public int Jik_CommsReply(Jik_Comm co);
	
	//jik_comm_re_seq값 수정
	public int Jik_CommsReplyUpdate(Jik_Comm co);
}
