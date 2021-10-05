package com.hta.project.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class ApiController {
	private final static Logger logger = LoggerFactory.getLogger(ApiController.class);
	
	@Value("${weather}")
	private String weatherApiKey;
	
	@PostMapping("/weather")
	@ResponseBody
	public String weatherAPI(@RequestParam("lat") double lat,
						@RequestParam("lon") double lon) {
		logger.info("Api weatherAPI()");
		
		StringBuffer result = new StringBuffer();
		try {
			StringBuilder urlBuilder = new StringBuilder("https://api.openweathermap.org/data/2.5/weather");
			urlBuilder.append("?" + URLEncoder.encode("lat", "UTF-8") + "=" + lat); // 현재 사용자의 위도
			urlBuilder.append("&" + URLEncoder.encode("lon", "UTF-8") + "=" + lon); // 현재 사용자의 경도
			urlBuilder.append("&" + URLEncoder.encode("appid", "UTF-8") + "=" + weatherApiKey); // OpenWeatherMap API Key
			urlBuilder.append("&" + URLEncoder.encode("units", "UTF-8") + "=metric");
			logger.info("Weather URL = " + urlBuilder);
			
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			BufferedReader reader;
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			}else {
				reader = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			
			String line;
			while((line = reader.readLine()) != null) {
				result.append(line + "\n");
			}
			reader.close();
			conn.disconnect();
		}catch(Exception e) {
			e.printStackTrace();
		}
		logger.info("result = " + result);
		return result + "";
	}

}
