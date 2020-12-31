package com.ssmAdmin.service.impl;

import com.ssmAdmin.dao.MenuDao;
import com.ssmAdmin.entity.sqlEntity.Menu;
import com.ssmAdmin.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuDao menuDao;

	public List<Menu> getMenuByParams(Map<String, Object> params) {
		return menuDao.getMenuByParams(params);
	}
	public void updateMenu(Menu menu) {
		menuDao.updateMenu(menu);
	}
	public void insertMenu(Menu menu) {
		menuDao.insertMenu(menu);
	}

}

