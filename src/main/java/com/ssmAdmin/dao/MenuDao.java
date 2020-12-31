package com.ssmAdmin.dao;

import com.ssmAdmin.entity.sqlEntity.Menu;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface MenuDao extends BaseDao<Menu> {

	List<Menu> getMenuByParams(Map<String, Object> params);

	void updateMenu(Menu menu);

	void insertMenu(Menu menu);

}
