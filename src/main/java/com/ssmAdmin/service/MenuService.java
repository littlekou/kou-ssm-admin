package com.ssmAdmin.service;

import com.ssmAdmin.entity.sqlEntity.Menu;
import java.util.List;
import java.util.Map;

public interface MenuService{

	List<Menu> getMenuByParams(Map<String, Object> params);

	void updateMenu(Menu menu);

	void insertMenu(Menu menu);

}
