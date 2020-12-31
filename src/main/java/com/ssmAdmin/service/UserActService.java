package com.ssmAdmin.service;

import com.ssmAdmin.entity.AjaxPage;
import com.ssmAdmin.entity.ScriptPage;
import com.ssmAdmin.entity.UserAct;
import com.ssmAdmin.entity.sqlEntity.Member;

import java.util.Map;

public interface UserActService {
	/** 添加 **/
	public int save(UserAct useract);

	/** 修改 **/
	public int update(UserAct useract);

	/** 删除 **/
	public int delete(UserAct useract);

	/** 获取列表 **/
	public ScriptPage getList(UserAct useract, AjaxPage ajaxPage);
	/**
	 * 记录用户操作
	 * @param currentUser
	 * @param userActStr
	 * @param map
	 */
	public void LogAct(Member currentUser, String userActStr, Map<String,Object> map);
}
