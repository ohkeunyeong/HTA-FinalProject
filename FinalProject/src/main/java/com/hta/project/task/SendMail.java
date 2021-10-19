package com.hta.project.task;

import javax.mail.internet.MimeMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import com.hta.project.domain.MailVO;

@Component
public class SendMail {

	@Autowired
	private JavaMailSenderImpl mailSender;

	private static final Logger logger = LoggerFactory.getLogger(SendMail.class);

	public void sendMail(MailVO vo) {
		MimeMessagePreparator mp = new MimeMessagePreparator() {

			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				// 두 번째 인자 true는 멀티 파트 메시지를 사용하겠다는 의미입니다.
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				helper.setFrom(vo.getFrom());
				helper.setTo(vo.getTo());
				helper.setSubject(vo.getSubject());

				// 1. 문자로만 전송하는 경우
				// 두 번째 인자는 html을 사용하겠다는 뜻입니다.
				helper.setText(vo.getContent(), true);

			}
		};
		mailSender.send(mp); // 메일 전송합니다.
		logger.info("메일 전송했습니다.");
	}
}
