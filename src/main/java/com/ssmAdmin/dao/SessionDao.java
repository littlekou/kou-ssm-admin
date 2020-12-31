package com.ssmAdmin.dao;

import com.ssmAdmin.entity.sqlEntity.UserSession;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public interface SessionDao {

	UserSession getSessionIdById(@Param("userId") Long userId);

	void updateSession(Map<String, Object> map);

	void saveSession(Map<String, Object> map);
}
