package com.ssmAdmin.service;

import com.ssmAdmin.entity.sqlEntity.RoleMenu;
import java.util.List;

public interface RoleMenuService{

	List<RoleMenu> selectRelationByRoleId( Integer integer);

	Integer deleteRelationByRoleId(Long roleId);

	void saveRelation(RoleMenu roleMenu);

}
