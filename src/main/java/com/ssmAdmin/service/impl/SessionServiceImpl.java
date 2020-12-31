package com.ssmAdmin.service.impl;

import com.ssmAdmin.dao.SessionDao;
import com.ssmAdmin.entity.sqlEntity.UserSession;
import com.ssmAdmin.service.SessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;


@Service
public class SessionServiceImpl implements SessionService {

	@Autowired
	private SessionDao sessionDao;

	@Override
	public UserSession getSessionIdById(Long userId) {
		return sessionDao.getSessionIdById(userId);
	}

	@Override
	public void saveSession(Map<String, Object> map) {
		sessionDao.saveSession(map);
	}

	@Override
	public void updateSession(Map<String, Object> map) {
		sessionDao.updateSession(map);
	}
}

