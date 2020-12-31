package com.ssmAdmin.dao;

import com.ssmAdmin.entity.sqlEntity.RoleMenu;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleMenuDao extends BaseDao<RoleMenu> {

	List<RoleMenu> selectRelationByRoleId(@Param("roleId") Integer integer);

	Integer deleteRelationByRoleId(@Param("roleId") Long roleId);

	void saveRelation(RoleMenu sysRoleAuth);

}
