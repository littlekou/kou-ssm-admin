package com.ssmAdmin.service.impl;

import com.ssmAdmin.dao.RoleDao;
import com.ssmAdmin.entity.sqlEntity.Role;
import com.ssmAdmin.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDao sysRoleDao;

	public List<Role> getSysRoleByParams(Map<String, Object> params) {
		return sysRoleDao.getSysRoleByParams(params);
	}
	public void updateSysRole(Role sysRole) {
		sysRoleDao.updateSysRole(sysRole);
	}
	public void insertSysRole(Role sysRole) {
		sysRoleDao.insertSysRole(sysRole);
	}

}

