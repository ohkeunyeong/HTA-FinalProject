package com.hta.project;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class Okytest {
	private static final Logger logger = LoggerFactory.getLogger(Okytest.class);	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Test
	public void count() {
		String MYNONG_NAME = "test";
		String result=sqlsession.selectOne("Mynong.select", MYNONG_NAME);
		logger.info(result);
	}	
}
