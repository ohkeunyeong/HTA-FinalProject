package com.hta.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hta.project.domain.Account;

@Repository
public class AccDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public boolean insertAcc(Account account) {
		int count = sqlSession.insert("Accounts.insertAcc", account);
		return count > 0 ? true : false;
	}

	public List<Account> accViewList(String name, String yyyyMM) {
		Map<String, String> map = new HashMap<>();
		map.put("name", name);
		map.put("yyyyMM", yyyyMM);
		return sqlSession.selectList("Accounts.accViewList", map);
	}

	public Account accDetail(int seq) {
		Account dao = sqlSession.selectOne("Accounts.accDetail", seq);
		return dao;
	}

	public boolean accDelete(int seq) {
		int count = sqlSession.delete("Accounts.accDelete", seq);
		return count > 0 ? true : false;
	}

	public boolean accUpdate(Account account) {
		int count = sqlSession.update("Accounts.accUpdate", account);
		return count > 0 ? true : false;
	}

}
