package com.hta.project.task;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.hta.project.service.NongService;

@Service
public class FileCheckTask {

	private static final Logger logger = LoggerFactory.getLogger(FileCheckTask.class);

	@Value("${savefoldername}")
	private String saveFolder;

	@Autowired
	private NongService boardService;

	// 스케줄러를 이용해서 주기적으로
	// 매일, 매주, 매월 프로그램 실행을 위한 작업을 실시합니다.
	// @Scheduled(fixedDelay=1000)
	// 밀리세컨드 단위입니다.
	public void test() throws Exception {
		logger.info("test");
	}

	// cron 사용법
	// seconds(초:0~59) minutes(분:0~59) hours(시:0~23) day(일:1~31)
	// months(달:1~12) day of week(요일:0~6) year(optional)
	// 초 분 일 시 달 요일
	// @Scheduled(cron = "0 * * 13 * *")

	@Scheduled(cron = "0 0 13 * * *")
	public void checkFiles() throws Exception {

		logger.info("checkFiles");
		List<String> deleteFileList = boardService.getDeleteFileList();

		// for(String filename : deleteFileList) {
		for (int i = 0; i < deleteFileList.size(); i++) {
			String filename = deleteFileList.get(i);
			File file = new File(saveFolder + filename);
			if (file.exists()) {
				if (file.delete()) {
					logger.info(file.getPath() + " 삭제되었습니다.");
				}
			} else {
				logger.info(file.getPath() + " 파일이 존재하지 않습니다.");
			}
		}
	}

}
