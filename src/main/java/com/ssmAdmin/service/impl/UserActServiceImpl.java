package com.ssmAdmin.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.ssmAdmin.dao.UserActDao;
import com.ssmAdmin.entity.AjaxPage;
import com.ssmAdmin.entity.ScriptPage;
import com.ssmAdmin.entity.UserAct;
import com.ssmAdmin.entity.sqlEntity.Member;
import com.ssmAdmin.service.UserActService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class UserActServiceImpl implements UserActService {
	
	@Autowired
	private UserActDao userActDao;
	
	/** 添加 **/
	public int save(UserAct useract){
		return userActDao.save(useract);
	}
	
	/** 修改 **/
	public int update(UserAct useract){
		return userActDao.update(useract);
	}
	
	/** 删除 **/
	public int delete(UserAct useract){
		return userActDao.delete(useract);
	}
	
	/** 获取列表 **/
	public ScriptPage getList(UserAct useract, AjaxPage ajaxPage){
		ScriptPage scriptPage = new ScriptPage();
		useract.setPageIndex(ajaxPage.getSkipNo());
		useract.setPageSize(ajaxPage.getPageSize());
		List<UserAct> rows = userActDao.getList(useract);
		scriptPage.setRows(rows);
		int total = userActDao.getCount(useract);
		scriptPage.setTotal(total);
		return scriptPage;
	}
	/**
	 * 记录用户操作
	 * @param currentUser
	 * @param userActStr
	 * @param map
	 */
	public void LogAct(Member currentUser, String userActStr, Map<String,Object> map){
		String[] actStr = userActStr.split("/");
		
		UserAct userAct = new UserAct();
		userAct.setUserName(currentUser.getId()+"");
		userAct.setAction(actStr[1]);
		userAct.setOperation(actStr[2]);
		String msg = "";
		for (String key : map.keySet()) {
			Pattern p = Pattern.compile("Name|name");
			Matcher m = p.matcher(key);
			if(m.find()){
				msg += " "+((String[])map.get(key))[0];
			}
		}
		userAct.setInfo(msg);
		userAct.setDetailInfo(JSONObject.toJSONString(map));
		userActDao.save(userAct);
	}
}
