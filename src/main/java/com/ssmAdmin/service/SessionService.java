package com.ssmAdmin.service;


import com.ssmAdmin.entity.sqlEntity.UserSession;

import java.util.Map;

public interface SessionService {

	public UserSession getSessionIdById(Long userId);

	public void saveSession(Map<String,Object> map);

	public void updateSession(Map<String,Object> map);
}

