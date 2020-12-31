package com.ssmAdmin.dao;

import com.ssmAdmin.entity.sqlEntity.Role;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface RoleDao extends BaseDao<Role> {

	List<Role> getSysRoleByParams(Map<String, Object> params);

	void updateSysRole(Role sysRole);

	void insertSysRole(Role sysRole);

}
