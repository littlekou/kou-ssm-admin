package com.ssmAdmin.service.impl;

import com.ssmAdmin.dao.MenuDao;
import com.ssmAdmin.dao.RoleMenuDao;
import com.ssmAdmin.entity.sqlEntity.RoleMenu;
import com.ssmAdmin.service.RoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class RoleMenuServiceImpl implements RoleMenuService {

	@Autowired
	private RoleMenuDao roleMenuDao;

	public List<RoleMenu> selectRelationByRoleId(Integer integer) {
		return roleMenuDao.selectRelationByRoleId(integer);
	}
	public Integer deleteRelationByRoleId(Long sysRoleId) {
		Integer deleteNum = roleMenuDao.deleteRelationByRoleId(sysRoleId);
		System.err.println("deleteNum:::"+deleteNum);
		return deleteNum;
	}
	public void saveRelation(RoleMenu sysRoleAuth) {
		roleMenuDao.saveRelation(sysRoleAuth);
	}
	

}

