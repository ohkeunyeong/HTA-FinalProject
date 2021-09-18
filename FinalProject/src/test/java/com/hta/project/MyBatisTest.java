package com.hta.project;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class MyBatisTest {
	
	private static final Logger logger = LoggerFactory.getLogger(MyBatisTest.class);
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
//	@Test
	public void testSqlSessionFactory() {
		logger.info("sqlSessionFactory : " + sqlSessionFactory);
	}
	
	@Test
	public void testSqlSession() {
		try(SqlSession sqlSession = sqlSessionFactory.openSession()){
			logger.info("sqlSession : " + sqlSession);
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
