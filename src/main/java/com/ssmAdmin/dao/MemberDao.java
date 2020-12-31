package com.ssmAdmin.dao;

import com.ssmAdmin.entity.sqlEntity.Member;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface MemberDao extends BaseDao<Member> {

	Member getMemberByMobile(@Param("loginName") String loginName, @Param("status") Integer status);

	Member getMemberById(@Param("id")Long id);

	List<Member> getMerchantList(Map<String, Object> params);

	void updateMember(Member member);

	String getParameterByParam(@Param("param1") String param1, @Param("param2") String param2,@Param("param3") String param3);

	void updateMemberParam(@Param("param1") String param1, @Param("param2") String param2,@Param("id") Long id);

	void insertMember(Member member);

	void deleteUser(@Param("id")Long id);

}