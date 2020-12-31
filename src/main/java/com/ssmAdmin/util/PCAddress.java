package com.ssmAdmin.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import javax.servlet.http.HttpServletRequest;


public class PCAddress {
	static Logger logger = Logger.getLogger(PCAddress.class);
	public static String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (!checkIp(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (!checkIp(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");//
		}
		if (!checkIp(ip)) {
			ip = request.getRemoteAddr();//
		}
		if(StringUtils.isNotBlank(ip)&&ip.indexOf(",") > 0 ) {
			logger.info(ip+"获取的两个IP");
			ip = ip.substring(0, ip.indexOf(","));
		}
		return ip;
	}
	
	private static boolean checkIp(String ip) {
		if (ip == null || ip.length() == 0 || "unkown".equalsIgnoreCase(ip)) {
			return false;
		}
		return true;
	}

}
