
package com.ssmAdmin.util;

import org.apache.commons.lang3.StringUtils;

public class CheckNum {

	public static Boolean checkNum(String code) {
		if (StringUtils.isNotEmpty(code)) {
			if (code.matches("[0-9]+")) {
				return true;
			}
		}
		return false;
	}
	public static String getPrice(String str){
		if(!str.contains(".")){
			return null;
		}
		int i = str.lastIndexOf(".");
		String preString = str.substring(0, i);
		String lastString = str.substring(i, str.length());
		String replace = preString.replace(".", "");
		String concat = replace.concat(lastString);
		return concat;
	}

}
