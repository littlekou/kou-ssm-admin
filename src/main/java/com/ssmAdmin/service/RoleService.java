package com.ssmAdmin.service;


import com.ssmAdmin.entity.sqlEntity.Role;

import java.util.List;
import java.util.Map;

public interface RoleService{

	List<Role> getSysRoleByParams(Map<String, Object> params);

	void updateSysRole(Role sysRole);

	void insertSysRole(Role sysRole);

}
